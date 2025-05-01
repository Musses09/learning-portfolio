# -------------------------------------------------------------------------------------------------------------------------------#
# STAGE 1: PREPARING & UNDERSTANDING THE DATA
# -------------------------------------------------------------------------------------------------------------------------------#

# --- Load Libraries --- #
library(randomForest)
library(plyr)
library(caret)
library(ggplot2)
library(tibble)
library(dplyr)
library(tidyr)
library(reshape2)

# --- Load Raw Data --- #
kmer_table <- read.table("/Users/sahramusse/Downloads/14-18kmerdata.txt", sep = "\t", header = TRUE, row.names = 1, stringsAsFactors = FALSE, comment.char = "")
metadata <- read.table("/Users/sahramusse/Downloads/14-18metadata", sep = ",", header = TRUE, row.names = 1, stringsAsFactors = TRUE, comment.char = "")

# --- Exploratory Summary --- #
output_file <- "/Users/sahramusse/Documents/.../EDA_results.txt"
file_conn <- file(output_file, "wt")

writeLines(c(
  "### EXPLORATORY DATA ANALYSIS ###",
  paste("\nkmer_table dimensions:", paste(dim(kmer_table), collapse = " x ")),
  paste("\nmetadata dimensions:", paste(dim(metadata), collapse = " x ")),
  "\nStructure of metadata:",
  capture.output(str(metadata)),
  "\nSummary of metadata:",
  capture.output(summary(metadata))
), file_conn)

close(file_conn)


# -------------------------------------------------------------------------------------------------------------------------------#
# STAGE 2: PREPROCESSING THE DATASETS
# -------------------------------------------------------------------------------------------------------------------------------#

# --- Clean Metadata --- #
metadata$Country <- trimws(as.character(metadata$Country))
metadata$Region  <- trimws(as.character(metadata$Region))
metadata$Country <- droplevels(factor(metadata$Country))
metadata$Region  <- droplevels(factor(metadata$Region))

# --- Filter Rare K-mers --- #
remove_rare <- function(table, cutoff_pro = 0.2) {
  cutoff <- ceiling(cutoff_pro * ncol(table))
  table[rowSums(table > 0) > cutoff, , drop = FALSE]
}

kmer_table_rare_removed <- remove_rare(kmer_table)

# --- Normalize (Percent Composition) --- #
kmer_table_rare_removed_norm <- sweep(kmer_table_rare_removed, 2, colSums(kmer_table_rare_removed), '/') * 100

# --- Scale --- #
kmer_table_scaled <- scale(kmer_table_rare_removed_norm, center = TRUE, scale = TRUE)
save(kmer_table_scaled, file = "/Users/sahramusse/Downloads/kmer_table_scaled.RData")

# --- Align Metadata --- #
metadata <- metadata[colnames(kmer_table_scaled), ]
kmer_table_scaled <- kmer_table_scaled[, rownames(metadata)]

# --- Filter Singleton Countries --- #
country_counts <- table(metadata$Country)
valid_countries <- names(country_counts[country_counts > 1])
metadata_filtered <- metadata[metadata$Country %in% valid_countries, ]
kmer_filtered <- kmer_table_scaled[, rownames(metadata_filtered)]

# --- Final Training Set --- #
train_data <- data.frame(t(kmer_filtered))
train_data$Country <- droplevels(metadata_filtered$Country)


# -------------------------------------------------------------------------------------------------------------------------------#
# STAGE 3: HYPERPARAMETER TUNING FOR RANDOM FOREST
# -------------------------------------------------------------------------------------------------------------------------------#

# --- Control Settings --- #
set.seed(123)
train_control_ft <- trainControl(method = "repeatedcv", number = 5, repeats = 3, classProbs = FALSE, verboseIter = TRUE)

# --- Country Model (Fine-Tuned) --- #
RF_country_classify_ft <- train(
  x = train_data[, -ncol(train_data)],
  y = train_data$Country,
  method = "rf",
  trControl = train_control_ft,
  tuneGrid = data.frame(mtry = 10),
  ntree = 25
)
saveRDS(RF_country_classify_ft, "/Users/sahramusse/Documents/.../RF_country_filtered_model_ft.rds")

# --- Region Model (Fine-Tuned) --- #
kmer_table_scaled_region <- data.frame(t(kmer_table_scaled))
kmer_table_scaled_region$Region <- metadata$Region

features_region <- kmer_table_scaled_region[, !(colnames(kmer_table_scaled_region) %in% "Region")]
target_region <- kmer_table_scaled_region$Region

RF_region_classify_ft <- train(
  x = features_region,
  y = target_region,
  method = "rf",
  trControl = train_control_ft,
  tuneGrid = data.frame(mtry = 2),
  ntree = 25
)
saveRDS(RF_region_classify_ft, "/Users/sahramusse/Documents/.../RF_region_model_ft.rds")


# -------------------------------------------------------------------------------------------------------------------------------#
# STAGE 4: INTERNAL MODEL EVALUATION
# -------------------------------------------------------------------------------------------------------------------------------#

# --- Predict on Training Data --- #
pred_country_train <- predict(RF_country_classify_ft, newdata = train_data[, -ncol(train_data)])
cm_country <- confusionMatrix(pred_country_train, train_data$Country)

region_data <- data.frame(t(kmer_table_scaled))
region_data$Region <- metadata$Region
pred_region_train <- predict(RF_region_classify_ft, newdata = region_data[, -ncol(region_data)])
cm_region <- confusionMatrix(pred_region_train, region_data$Region)

# --- Save Country/Region Confusion Matrices as Heatmaps --- #
output_path <- "/Users/sahramusse/Downloads"

save_heatmap <- function(cm_table, title, xlab, ylab, fill_color, file_name) {
  df <- as.data.frame(cm_table)
  p <- ggplot(df, aes(x = Prediction, y = Reference, fill = Freq)) +
    geom_tile(color = "white") +
    geom_text(aes(label = Freq), size = 2) +
    scale_fill_gradient(low = "white", high = fill_color, limits = c(0, 250), name = "Frequency") +
    theme_minimal() +
    labs(title = title, x = xlab, y = ylab)
  ggsave(file.path(output_path, file_name), p, width = 10, height = 8)
}

save_heatmap(cm_country$table, "Confusion Matrix - Country", "Predicted", "True", "darkred", "conf_matrix_country_heatmap.png")
save_heatmap(cm_region$table,  "Confusion Matrix - Region",  "Predicted", "True", "steelblue", "conf_matrix_region_heatmap.png")

# --- Save F1 Score Barplots --- #
barplot_f1 <- function(f1_scores, main_title, col, filename) {
  png(file.path(output_path, filename), width = 1000, height = 600)
  barplot(f1_scores, las = 2, main = main_title, col = col, ylim = c(0, 1))
  dev.off()
}

barplot_f1(cm_country$byClass[, "F1"], "F1 Score per Class - Country", "lightblue", "f1_country_barplot.png")
barplot_f1(cm_region$byClass[, "F1"],  "F1 Score per Class - Region",  "skyblue",   "f1_region_barplot.png")


#-------------------------------------------------------------------------------------------------------------------------------#
# STAGE 5: FINAL RANDOM FOREST TRAINING (Country and Region)
#-------------------------------------------------------------------------------------------------------------------------------#

# --- Train Country Classification Model --- #
set.seed(123)
train_control <- trainControl(
  method = "repeatedcv",
  number = 5,
  repeats = 3,
  verboseIter = TRUE
)

RF_country_classify <- train(
  x = train_data[, -ncol(train_data)],
  y = train_data$Country,
  method = "rf",
  trControl = train_control,
  tuneGrid = data.frame(mtry = 100),
  ntree = 250
)

saveRDS(RF_country_classify, "./RF_country_filtered_model.rds")

# --- Train Region Classification Model --- #
kmer_table_scaled_region <- data.frame(t(kmer_table_scaled))
kmer_table_scaled_region$Region <- metadata$Region

features_region <- kmer_table_scaled_region[, -which(colnames(kmer_table_scaled_region) == "Region")]
target_region <- kmer_table_scaled_region$Region

RF_region_classify <- train(
  x = features_region,
  y = target_region,
  method = "rf",
  trControl = train_control,
  tuneGrid = data.frame(mtry = 30),
  ntree = 250
)

saveRDS(RF_region_classify, "./RF_region_model.rds")


#-------------------------------------------------------------------------------------------------------------------------------#
# STAGE 6: MODEL EVALUATION ON TRAINING DATA
#-------------------------------------------------------------------------------------------------------------------------------#

# --- Country Evaluation --- #
pred_country_train <- predict(RF_country_classify, newdata = train_data[, -ncol(train_data)])
cm_country <- confusionMatrix(pred_country_train, train_data$Country)

# --- Region Evaluation --- #
region_data <- data.frame(t(kmer_table_scaled))
region_data$Region <- metadata$Region
pred_region_train <- predict(RF_region_classify, newdata = region_data[, -ncol(region_data)])
cm_region <- confusionMatrix(pred_region_train, region_data$Region)

# Save Heatmaps
save_conf_matrix_plot <- function(cm_table, title, path, fill_color) {
  png(path, width = 1000, height = 800)
  ggplot(as.data.frame(cm_table), aes(x = Prediction, y = Reference, fill = Freq)) +
    geom_tile(color = "white") +
    geom_text(aes(label = Freq), size = 3) +
    scale_fill_gradient(low = "white", high = fill_color, limits = c(0, 250)) +
    theme_minimal() +
    labs(title = title, x = "Predicted", y = "True")
  dev.off()
}

save_conf_matrix_plot(cm_country$table, "Country Classification Heatmap", "./conf_matrix_country_heatmap.png", "darkred")
save_conf_matrix_plot(cm_region$table, "Region Classification Heatmap", "./conf_matrix_region_heatmap.png", "steelblue")

# Save F1 Score Plots
save_f1_barplot <- function(f1_scores, title, path, color) {
  png(path, width = 1000, height = 600)
  barplot(f1_scores, las = 2, col = color, main = title, ylim = c(0, 1))
  dev.off()
}

save_f1_barplot(cm_country$byClass[, "F1"], "Country F1 Scores", "./f1_country_barplot.png", "lightblue")
save_f1_barplot(cm_region$byClass[, "F1"], "Region F1 Scores", "./f1_region_barplot.png", "skyblue")


#-------------------------------------------------------------------------------------------------------------------------------#
# STAGE 7: FEATURE IMPORTANCE VISUALIZATION
#-------------------------------------------------------------------------------------------------------------------------------#

importance_country <- varImp(RF_country_classify)
importance_region <- varImp(RF_region_classify)

# --- Top 10 Country Features --- #
library(tibble)
library(dplyr)
library(ggplot2)

top10_country <- importance_country$importance %>%
  rownames_to_column("Feature") %>%
  arrange(desc(Overall)) %>%
  head(10)

ggplot(top10_country, aes(x = reorder(Feature, Overall), y = Overall)) +
  geom_bar(stat = "identity", fill = "lightblue") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Top 10 Important Features - Country Model", x = "K-mer", y = "Importance")
ggsave("./top10_country_features.png", width = 8, height = 6, dpi = 300)

# --- Top 10 Region Features --- #
top10_region <- importance_region$importance %>%
  rownames_to_column("Feature") %>%
  arrange(desc(Overall)) %>%
  head(10)

ggplot(top10_region, aes(x = reorder(Feature, Overall), y = Overall)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Top 10 Important Features - Region Model", x = "K-mer", y = "Importance")
ggsave("./top10_region_features.png", width = 8, height = 6, dpi = 300)
