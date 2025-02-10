# Load necessary packages
install.packages("caret", dependencies = TRUE)
install.packages("tidyverse", dependencies = TRUE)
library(caret)
library(tidyverse)

# Function to normalize a dataset
normalize_dataset <- function(file_path) {
  
  # Load the dataset
  data <- read.csv(file_path, header = TRUE, stringsAsFactors = FALSE)
  
  # Print the dataset details
  cat("\n Processing File:", file_path, "\n")
  print(head(data))
  print(str(data))
  print(summary(data))
  
  # Check for missing values
  missing_counts <- colSums(is.na(data))
  total_missing <- sum(missing_counts)
  cat("\nTotal Missing Values:", total_missing, "\n")
  
  # Handle missing values
  missing_threshold <- 0.05 * nrow(data)  # 5% of rows
  if (total_missing > 0) {
    if (total_missing < missing_threshold) {
      cat("\n Removing rows with missing values (Less than 5%)...\n")
      data <- na.omit(data)
    } else {
      cat("\n Imputing missing values using median...\n")
      preProc_missing <- preProcess(data, method = "medianImpute")
      data <- predict(preProc_missing, data)
    }
  } else {
    cat("\n No missing values detected!\n")
  }
  
  # Identify categorical and non-normalised columns to remove
  columns_to_remove <- c("Experiment", "Well.ID", "Unique.ID", "Row", "Column", "Field", "Object.Number..per.well.")
  
  # Select numeric columns for normalization
  data_numeric <- data %>% select(-any_of(columns_to_remove))
  
  # Normalize using Min-Max Scaling
  cat("\n Applying Min-Max Scaling...\n")
  preProc_minmax <- preProcess(data_numeric, method = "range")
  normalized_data_minmax <- predict(preProc_minmax, data_numeric)
  
  # Normalize using Z-Score Standardization
  cat("\n Applying Z-Score Standardization...\n")
  preProc_zscore <- preProcess(data_numeric, method = c("center", "scale"))
  normalized_data_zscore <- predict(preProc_zscore, data_numeric)
  
  # Reattach categorical and non-normalised columns
  final_data_minmax <- data %>%
    select(any_of(columns_to_remove)) %>%
    bind_cols(as.data.frame(normalized_data_minmax))
  
  final_data_zscore <- data %>%
    select(any_of(columns_to_remove)) %>%
    bind_cols(as.data.frame(normalized_data_zscore))
  
  # Define output directory
  output_dir <- "/Volumes/Z Slim/Report Project 1B/OneDrive_1_13-01-2025/Normalised data/"
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  # Extract original file name (without extension)
  file_name <- tools::file_path_sans_ext(basename(file_path))
  
  # Save the normalized datasets
  minmax_file <- paste0(output_dir, "Normalized_", file_name, "_minmax.csv")
  zscore_file <- paste0(output_dir, "Normalized_", file_name, "_zscore.csv")
  
  write.csv(final_data_minmax, minmax_file, row.names = FALSE)
  write.csv(final_data_zscore, zscore_file, row.names = FALSE)
  
  cat("\n Normalization Complete! Files saved as:\n", minmax_file, "\n", zscore_file, "\n")
}

# Loop to allow the user to normalize multiple datasets
repeat {
  # Let user choose a file
  file_path <- file.choose()
  
  # Check if user pressed "Cancel" (file_path will be empty)
  if (file_path == "") {
    cat("\n No file selected. Exiting the process...\n")
    break
  }
  
  # Run normalization function on selected file
  normalize_dataset(file_path)
  
  # Ask if the user wants to process another file
  choice <- readline("\n Do you want to normalize another dataset? (yes/no): ")
  
  if (tolower(choice) != "yes") {
    cat("\n All selected datasets have been processed. Exiting...\n")
    break
  }
}
