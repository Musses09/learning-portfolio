#load caret package
install.packages("caret")
library(caret)

library(tidyverse)

#Load and inspect dataset
file_path <- "/Volumes/Z Slim/Report Project 1B/OneDrive_1_13-01-2025/MacsExpt1_10k_M0.csv"
data <- read.csv(file_path, header = TRUE, stringsAsFactors = FALSE)

# View first few rows
head(data)

#data types for each column
str(data)

#summary statistics
summary(data)

sum(is.na(data))  # Total missing values
colSums(is.na(data))  # Missing values per column

columns_to_remove <- c("Experiment", "Well.ID", "Unique.ID", "Row", "Column", "Field", "Object.Number..per.well.")

# Select only the numeric columns that should be normalized
data_numeric_M0 <- data %>% select(-all_of(columns_to_remove))

#Data Normalisation: Min-Max Scaling
preProc <- preProcess(data_numeric_M0, method = "range")
normalized_data <- predict(preProc, data_numeric_M0)

# Normalize numeric data: Min-max scaling
preProc <- preProcess(data_numeric_M0, method = "range")
normalized_data <- predict(preProc, data_numeric_M0)

# Ensure non-numeric columns are retained correctly
final_data_minmax <- data %>% 
  select(all_of(columns_to_remove)) %>%  # Select categorical columns
  bind_cols(as.data.frame(normalized_data))  # Bind with normalized data

#Data Normalisation: z-score
preProc <- preProcess(data_numeric_M0, method = c("center", "scale"))
standardized_data <- predict(preProc, data_numeric_M0)

# Ensure non-numeric columns are retained correctly
final_data_zscore <- data %>% 
  select(all_of(columns_to_remove)) %>%  # Select categorical columns
  bind_cols(as.data.frame(standardized_data))  # Bind with normalized data

write.csv(final_data_minmax, "/Volumes/Z Slim/Report Project 1B/OneDrive_1_13-01-2025/Normalised data/MacsExpt1_10k_M0_Normalized_minmax.csv", row.names = FALSE)
write.csv(final_data_zscore, "/Volumes/Z Slim/Report Project 1B/OneDrive_1_13-01-2025/Normalised data/MacsExpt1_10k_M0_Normalized_zscore.csv", row.names = FALSE)
