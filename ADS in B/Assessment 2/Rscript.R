#-------------------------------------------------------------------------#
# LOAD LIBRARIES AND DATA
#-------------------------------------------------------------------------#
# Required libraries
library(randomForest)
library(plyr)
library(caret)

# Load data
kmer_table <- read.table("/Users/sahramusse/Downloads/14-18kmerdata.txt", sep="\t", header=TRUE, row.names=1, stringsAsFactors=FALSE, comment.char="")
metadata <- read.table("/Users/sahramusse/Downloads/14-18metadata", sep=",", header=TRUE, row.names=1, stringsAsFactors=TRUE, comment.char="")


#-------------------------------------------------------------------------#
# EXPLORATORY DATA ANALYSIS
#-------------------------------------------------------------------------#
output_file <- "~/EDA_results.txt"
file_conn <- file(output_file, "wt")

writeLines("### EXPLORATORY DATA ANALYSIS ###", file_conn)
writeLines(paste("\nkmer_table dimensions:", paste(dim(kmer_table), collapse=" x ")), file_conn)
writeLines(paste("\nmetadata dimensions:", paste(dim(metadata), collapse=" x ")), file_conn)

str_output <- capture.output(str(metadata))
summary_output <- capture.output(summary(metadata))

writeLines("\nStructure of metadata:", file_conn)
writeLines(str_output, file_conn)
writeLines("\nSummary of metadata:", file_conn)
writeLines(summary_output, file_conn)
close(file_conn)


#-------------------------------------------------------------------------#
# PREPROCESSING METADATA
#-------------------------------------------------------------------------#
metadata$Country <- trimws(as.character(metadata$Country))
metadata$Region  <- trimws(as.character(metadata$Region))
metadata$Country <- droplevels(factor(metadata$Country))
metadata$Region  <- droplevels(factor(metadata$Region))


#-------------------------------------------------------------------------#
# PREPROCESSING KMERS
#-------------------------------------------------------------------------#
kmer_nonzero_counts_before <- apply(kmer_table, 1, function(y) sum(y > 0))

# Plot histogram before filtering
png("/Users/sahramusse/Downloads/kmer_histogram_before_removal.png", width=1000, height=600)
hist(kmer_nonzero_counts_before,
     breaks = 100,
     col = "skyblue",
     main = "Distribution of Non-Zero k-mer Counts (Before Filtering)",
     xlab = "Number of Samples with Non-Zero k-mer",
     ylab = "Frequency")
dev.off()

remove_rare <- function(table, cutoff_pro) {
  row2keep <- c()
  cutoff <- ceiling(cutoff_pro * ncol(table))
  for (i in 1:nrow(table)) {
    if (sum(table[i, ] > 0) > cutoff) {
      row2keep <- c(row2keep, i)
    }
  }
  return(table[row2keep, , drop=FALSE])
}

kmer_table_rare_removed <- remove_rare(kmer_table, cutoff_pro=0.2)

# Count non-zero entries per k-mer AFTER filtering
kmer_nonzero_counts_after <- apply(kmer_table_rare_removed, 1, function(y) sum(y > 0))

# Plot histogram after filtering
png("/Users/sahramusse/Downloads/kmer_histogram_after_removal.png", width=1000, height=600)
hist(kmer_nonzero_counts_after,
     breaks = 100,
     col = "darkgreen",
     main = "Distribution of Non-Zero k-mer Counts (After Filtering)",
     xlab = "Number of Samples with Non-Zero k-mer",
     ylab = "Frequency")
dev.off()

kmer_table_rare_removed_norm <- sweep(kmer_table_rare_removed, 2, colSums(kmer_table_rare_removed), '/') * 100
kmer_table_scaled <- scale(kmer_table_rare_removed_norm, center=TRUE, scale=TRUE)
save(kmer_table_scaled, file = "/Users/sahramusse/Downloads/kmer_table_scaled.RData")

metadata <- metadata[colnames(kmer_table_scaled), ]
kmer_table_scaled <- kmer_table_scaled[, rownames(metadata)]


#-------------------------------------------------------------------------#
# REMOVE SINGLETON COUNTRY CLASSES
#-------------------------------------------------------------------------#
country_counts <- table(metadata$Country)
valid_countries <- names(country_counts[country_counts > 1])
metadata_filtered <- metadata[metadata$Country %in% valid_countries, ]
kmer_filtered <- kmer_table_scaled[, rownames(metadata_filtered)]

train_data <- data.frame(t(kmer_filtered))
train_data$Country <- droplevels(metadata_filtered$Country)

# Step 1: Frequency table of all countries in the original metadata
country_counts <- table(metadata$Country)

# Step 2: Extract countries that appeared only once (singletons)
singleton_countries <- names(country_counts[country_counts == 1])

# Step 3: View or print them
print(singleton_countries)

writeLines(singleton_countries, "/Users/sahramusse/Downloads/singleton_countries_removed.txt")
# Convert to data frame
singleton_countries_df <- data.frame(Country = singleton_countries)

# Save as CSV (recommended for clean table formatting)
write.csv(singleton_countries_df, "/Users/sahramusse/Downloads/singleton_countries_removed_table.csv", row.names = FALSE)

#-------------------------------------------------------------------------#
# RANDOM FOREST TRAINING (Country)
#-------------------------------------------------------------------------#
set.seed(123)
train_control <- trainControl(
  method = "repeatedcv",
  number = 5,
  repeats = 3,
  classProbs = FALSE,
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

saveRDS(RF_country_classify, file = "/Users/sahramusse/Downloads/RF_country_filtered_model.rds")
print(RF_country_classify)


#-------------------------------------------------------------------------#
# RANDOM FOREST TRAINING (Region)
#-------------------------------------------------------------------------#
kmer_table_scaled_region <- data.frame(t(kmer_table_scaled))
kmer_table_scaled_region$Region <- metadata$Region

features_region <- kmer_table_scaled_region[, !(colnames(kmer_table_scaled_region) %in% "Region")]
target_region <- kmer_table_scaled_region$Region

RF_region_classify <- train(
  x = features_region,
  y = target_region,
  method = "rf",
  trControl = train_control,
  tuneGrid = data.frame(mtry = 30),
  ntree = 250
)

saveRDS(RF_region_classify, file = "/Users/sahramusse/Downloads/RF_region_model.rds")
print(RF_region_classify)

#-------------------------------------------------------------------------#
# Assessing Class Balance Before and After Prediction
#-------------------------------------------------------------------------#
# COUNTRY – Actual
png("/Users/sahramusse/Downloads/train_country_actual.png", width=1000, height=600)
barplot(table(train_data$Country), las=2, main="Training Set Class Distribution (Country)")
dev.off()

# COUNTRY – Predicted
pred_country_train <- predict(RF_country_classify, newdata = train_data[, -ncol(train_data)])
png("/Users/sahramusse/Downloads/train_country_predicted.png", width=1000, height=600)
barplot(table(pred_country_train), las=2, main="Predicted Class Distribution (Country - Training)")
dev.off()

# REGION – Actual
region_data <- data.frame(t(kmer_table_scaled))
region_data$Region <- metadata$Region
png("/Users/sahramusse/Downloads/train_region_actual.png", width=1000, height=600)
barplot(table(region_data$Region), las=2, main="Training Set Class Distribution (Region)")
dev.off()

# REGION – Predicted
pred_region_train <- predict(RF_region_classify, newdata = region_data[, -ncol(region_data)])
png("/Users/sahramusse/Downloads/train_region_predicted.png", width=1000, height=600)
barplot(table(pred_region_train), las=2, main="Predicted Class Distribution (Region - Training)")
dev.off()


#-------------------------------------------------------------------------#
# Extracting and visualising Feature Importance
#-------------------------------------------------------------------------#

# COUNTRY model
importance_country <- varImp(RF_country_classify)
print(importance_country)

# REGION model
importance_region <- varImp(RF_region_classify)
print(importance_region)

# Country - Top 10 features
plot(importance_country, top = 10, main = "Top 10 Important Features - Country Model")

# Region - Top 10 features
plot(importance_region, top = 10, main = "Top 10 Important Features - Region Model")

# Save Country plot
png("/Users/sahramusse/Downloads/importance_country_top10.png", width=800, height=600)
plot(importance_country, top = 10, main = "Top 10 Important Features - Country Model")
dev.off()

# Save Region plot
png("/Users/sahramusse/Downloads/importance_region_top10.png", width=800, height=600)
plot(importance_region, top = 10, main = "Top 10 Important Features - Region Model")
dev.off()

# -------------------------------------------------------------------------#
# Internal Model Evaluation on Training Data (Pre-2019 Prediction)
# -------------------------------------------------------------------------#

# Load required libraries
library(caret)
library(ggplot2)
library(reshape2)

# --- COUNTRY Predictions & Confusion Matrix ---
pred_country_train <- predict(RF_country_classify, newdata = train_data[, -ncol(train_data)])
cm_country <- confusionMatrix(pred_country_train, train_data$Country)
print(cm_country)

# --- REGION Predictions & Confusion Matrix ---
region_data <- data.frame(t(kmer_table_scaled))
region_data$Region <- metadata$Region
pred_region_train <- predict(RF_region_classify, newdata = region_data[, -ncol(region_data)])
cm_region <- confusionMatrix(pred_region_train, region_data$Region)
print(cm_region)

# -------------------------------#
# REGION Confusion Matrix Heatmap - Save to PNG (Fixed Max Scale = 250)
# -------------------------------#
cm_table_region <- as.data.frame(cm_region$table)
png("/Users/sahramusse/Downloads/conf_matrix_region_heatmap.png", width=1000, height=800)
ggplot(data = cm_table_region, aes(x = Prediction, y = Reference, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Freq), size = 3) +
  scale_fill_gradient(low = "white", high = "steelblue", limits = c(0, 250), name = "Frequency") +
  theme_minimal() +
  labs(title = "Confusion Matrix Heatmap - Region Classification",
       x = "Predicted Region", y = "True Region")
dev.off()

# -------------------------------#
# REGION F1 Score Barplot - Save to PNG
# -------------------------------#
f1_scores_region <- cm_region$byClass[, "F1"]
png("/Users/sahramusse/Downloads/f1_region_barplot.png", width=1000, height=600)
barplot(f1_scores_region, las=2, main="F1 Score per Class - Region", col="skyblue", ylim=c(0,1))
dev.off()

# -------------------------------#
# COUNTRY Confusion Matrix Heatmap - Save to PNG (Fixed Max Scale = 250)
# -------------------------------#
cm_table_country <- as.data.frame(cm_country$table)
png("/Users/sahramusse/Downloads/conf_matrix_country_heatmap.png", width=1000, height=1000)
ggplot(data = cm_table_country, aes(x = Prediction, y = Reference, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Freq), size = 2) +  # Smaller font for 47 classes
  scale_fill_gradient(low = "white", high = "darkred", limits = c(0, 250), name = "Frequency") +
  theme_minimal() +
  labs(title = "Confusion Matrix Heatmap - Country Classification",
       x = "Predicted Country", y = "True Country")
dev.off()

# -------------------------------#
# COUNTRY F1 Score Barplot - Save to PNG
# -------------------------------#
f1_scores_country <- cm_country$byClass[, "F1"]
png("/Users/sahramusse/Downloads/f1_country_barplot.png", width=1000, height=600)
barplot(f1_scores_country, las=2, main="F1 Score per Class - Country", col="lightblue", ylim=c(0,1))
dev.off()


# -------------------------------
# Extracting and Saving Summary & Full Evaluation Metrics
# -------------------------------

# --- Define class names for summary ---
dominant_country <- "N"
rare_country     <- "Cyprus"

dominant_region  <- "UK"
rare_region      <- "Australasia"

# --- Get class levels (order used in byClass) ---
country_classes <- levels(train_data$Country)
region_classes  <- levels(region_data$Region)

# --- Find index of the dominant and rare classes ---
dominant_country_index <- which(country_classes == dominant_country)
rare_country_index     <- which(country_classes == rare_country)

dominant_region_index  <- which(region_classes == dominant_region)
rare_region_index      <- which(region_classes == rare_region)

# --- Extract relevant class metrics using index ---
country_subset <- cm_country$byClass[c(dominant_country_index, rare_country_index), c("Precision", "Recall", "F1")]
region_subset  <- cm_region$byClass[c(dominant_region_index, rare_region_index), c("Precision", "Recall", "F1")]

# Label the rows with class names
rownames(country_subset) <- c(dominant_country, rare_country)
rownames(region_subset)  <- c(dominant_region, rare_region)

# --- Extract overall (macro average) metrics ---
overall_country <- colMeans(cm_country$byClass[, c("Precision", "Recall", "F1")], na.rm = TRUE)
overall_region  <- colMeans(cm_region$byClass[, c("Precision", "Recall", "F1")], na.rm = TRUE)

# --- Display Summary Table in Console ---
cat("=== SUMMARY TABLE ===\n\n")
summary_table <- rbind(
  cbind(Model = "Country", Class = rownames(country_subset), round(country_subset, 2)),
  cbind(Model = "Region",  Class = rownames(region_subset),  round(region_subset, 2)),
  cbind(Model = "Country", Class = "Overall", t(round(overall_country, 2))),
  cbind(Model = "Region",  Class = "Overall", t(round(overall_region, 2)))
)
# Save the summary table to a .txt file
sink("/Users/sahramusse/Downloads/summary_model_metrics.txt")
cat("=== SUMMARY TABLE ===\n\n")
print(summary_table)
sink()


# -------------------------------
# Save full per-class metrics for Appendix
# -------------------------------

# Prepare and export to CSV
country_metrics_df <- data.frame(Class = country_classes,
                                 round(cm_country$byClass[, c("Precision", "Recall", "F1")], 3))

region_metrics_df <- data.frame(Class = region_classes,
                                round(cm_region$byClass[, c("Precision", "Recall", "F1")], 3))

write.csv(country_metrics_df, "/Users/sahramusse/Downloads/appendix_country_metrics.csv", row.names = FALSE)
write.csv(region_metrics_df, "/Users/sahramusse/Downloads/appendix_region_metrics.csv", row.names = FALSE)

#-------------------------------------------------------------------------#
# STAGE 2: PREDICTING 2019 TEST DATA (Country & Region)
#-------------------------------------------------------------------------#

# Load 2019 test data
kmer19_table <- read.table("/Users/sahramusse/Downloads/19kmerdata.txt", sep="\t", header=TRUE, row.names=1, stringsAsFactors=FALSE, comment.char="")
metadata19 <- read.table("/Users/sahramusse/Downloads/19metadata.csv", sep=",", header=TRUE, row.names=1, stringsAsFactors=TRUE)

# Preprocess metadata to match training format
metadata19$Country <- trimws(as.character(metadata19$Country))
metadata19$Region <- trimws(as.character(metadata19$Region))
metadata19$Country <- factor(metadata19$Country)
metadata19$Region <- factor(metadata19$Region)

# Remove singleton classes from 2019 data to match training exclusions
trained_classes_country <- levels(train_data$Country)
metadata19 <- metadata19[metadata19$Country %in% trained_classes_country, ]
kmer19_table <- kmer19_table[, rownames(metadata19)]

# Filter k-mers to match training features (from rare-feature filtering)
common_kmers <- intersect(rownames(kmer_table_rare_removed), rownames(kmer19_table))
kmer19_filtered <- kmer19_table[common_kmers, , drop = FALSE]

# Normalize and scale using training parameters
kmer19_norm <- sweep(kmer19_filtered, 2, colSums(kmer19_filtered), '/') * 100
missing_kmers <- setdiff(rownames(kmer_table_scaled), rownames(kmer19_norm))
if (length(missing_kmers) > 0) {
  zero_matrix <- matrix(0, nrow = length(missing_kmers), ncol = ncol(kmer19_norm),
                        dimnames = list(missing_kmers, colnames(kmer19_norm)))
  kmer19_norm <- rbind(kmer19_norm, zero_matrix)
}
kmer19_norm_aligned <- kmer19_norm[rownames(kmer_table_scaled), , drop = FALSE]
kmer19_scaled <- scale(t(kmer19_norm_aligned),
                       center = attr(kmer_table_scaled, "scaled:center"),
                       scale = attr(kmer_table_scaled, "scaled:scale"))

# ------------------ COUNTRY MODEL PREDICTION ------------------ #
pred_country_2019 <- predict(RF_country_classify, newdata = kmer19_scaled)
metadata19$pred_country <- pred_country_2019

# Confusion matrix and performance
cm_country_2019 <- confusionMatrix(pred_country_2019, metadata19$Country)
print(cm_country_2019)

# Save confusion matrix heatmap
png("/Users/sahramusse/Downloads/conf_matrix_country_2019.png", width=1000, height=800)
cm_table <- as.data.frame(cm_country_2019$table)
ggplot(data = cm_table, aes(x = Prediction, y = Reference, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Freq), size = 3) +
  scale_fill_gradient(low = "white", high = "darkred", limits = c(0, 250)) +
  theme_minimal() +
  labs(title = "Confusion Matrix - Country Classification (2019)", x = "Predicted", y = "True")
dev.off()

# F1 barplot
png("/Users/sahramusse/Downloads/f1_country_2019.png", width=1000, height=600)
barplot(cm_country_2019$byClass[,'F1'], las=2, main="F1 Score per Class - Country (2019)", col="lightblue", ylim=c(0,1))
dev.off()

# ------------------ REGION MODEL PREDICTION ------------------ #
pred_region_2019 <- predict(RF_region_classify, newdata = kmer19_scaled)
metadata19$pred_region <- pred_region_2019

# Confusion matrix and performance
cm_region_2019 <- confusionMatrix(pred_region_2019, metadata19$Region)
print(cm_region_2019)

# Save confusion matrix heatmap
png("/Users/sahramusse/Downloads/conf_matrix_region_2019.png", width=1000, height=800)
cm_table_region <- as.data.frame(cm_region_2019$table)
ggplot(data = cm_table_region, aes(x = Prediction, y = Reference, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Freq), size = 3) +
  scale_fill_gradient(low = "white", high = "steelblue", limits = c(0, 250)) +
  theme_minimal() +
  labs(title = "Confusion Matrix - Region Classification (2019)", x = "Predicted", y = "True")
dev.off()

# F1 barplot
png("/Users/sahramusse/Downloads/f1_region_2019.png", width=1000, height=600)
barplot(cm_region_2019$byClass[,'F1'], las=2, main="F1 Score per Class - Region (2019)", col="skyblue", ylim=c(0,1))
dev.off()

# Save performance metrics
write.csv(data.frame(Class = levels(metadata19$Country), round(cm_country_2019$byClass[, c("Precision", "Recall", "F1")], 3)),
          "/Users/sahramusse/Downloads/appendix_country_metrics_2019.csv", row.names = FALSE)

write.csv(data.frame(Class = levels(metadata19$Region), round(cm_region_2019$byClass[, c("Precision", "Recall", "F1")], 3)),
          "/Users/sahramusse/Downloads/appendix_region_metrics_2019.csv", row.names = FALSE)


