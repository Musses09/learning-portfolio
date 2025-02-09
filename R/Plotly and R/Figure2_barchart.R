# Install necessary packages
install.packages("devtools")
devtools::install_github("coolbutuseless/ggpattern")

# Load required libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)
library(stringr)
library(patchwork)  # for side-by-side plots
library(ggpattern)

# Read the CSV file
df <- read.csv("/Users/sahramusse/Documents/Applied Data Science in Biology/Semester 2 Assessment/Metadata/XX50235metadata.csv")

# Convert blank or "-" values in Stx and PT to "Unclassified"
df <- df %>%
  mutate(Stx = ifelse(Stx == "" | Stx == " -", "Missing or Unclassified", Stx),
         PT = ifelse(PT == "" | PT == " untypable" | PT == "#N/A", "Missing or Unclassified", PT))

# Ensure "Year" is treated as a numeric column
df$Year <- as.numeric(df$Year)

# Separate multiple values in "Stx" into separate rows while keeping "Missing or Unclassified" intact
df_long <- df %>%
  mutate(Stx = str_replace_all(Stx, "Missing or Unclassified", "Missing_or_Unclassified")) %>%
  mutate(Stx = str_squish(Stx)) %>%  # Remove extra spaces
  separate_rows(Stx, sep = " ") %>%  # Split multi-value Stx
  mutate(Stx = str_replace_all(Stx, "Missing_or_Unclassified", "Missing or Unclassified"))  # Restore label

# Count occurrences of each Stx type and PT type per year
stx_counts <- df_long %>%
  group_by(Year, Type = "Stx", Value = Stx) %>%
  summarise(count = n(), .groups = "drop")

pt_counts <- df_long %>%
  group_by(Year, Type = "PT", Value = PT) %>%
  summarise(count = n(), .groups = "drop")

# Combine both datasets into a single dataframe
combined_counts <- bind_rows(stx_counts, pt_counts)

# Check for missing years and exclude them
years_present <- unique(combined_counts$Year)

# Create a list of datasets for each year
yearly_data <- lapply(years_present, function(y) {
  combined_counts %>% filter(Year == y)
})

names(yearly_data) <- as.character(years_present)  # Assign year labels

# Create plot labels (for now, we'll use the year labels)
plot_labels <- as.character(years_present)

# Function to create a bar plot with annotations for highest PT and STX bars (excluding "Missing or Unclassified")
plot_yearly_counts_with_labels <- function(df, year, label) {
  # Filter out "Missing or Unclassified" from both Stx and PT
  df_filtered <- df %>% filter(!Value %in% c("Missing or Unclassified"))
  
  # Clean and ensure the "Value" column for PT is properly formatted (no extra spaces, unexpected characters)
  df_filtered <- df_filtered %>%
    mutate(Value = str_trim(Value))  # Remove leading/trailing spaces from PT and Stx values
  
  # Identify the highest count for STX and PT and create a new column for highlighting
  df_filtered <- df_filtered %>%
    group_by(Type) %>%
    mutate(highlight = ifelse(count == max(count), "Highest", "Other"))
  
  # Create STX plot
  stx_plot <- ggplot(df_filtered %>% filter(Type == "Stx"), aes(x = Value, y = count, fill = highlight, text = paste("Type:", Value, "<br>Count:", count))) +
    geom_bar(stat = "identity", position = position_dodge(width = 0.7), width = 0.6) +
    geom_text(aes(label = count), vjust = -0.3, size = 3) +  # Add text labels to bars
    theme_minimal() +
    labs(title = paste(label, "STX", year),
         x = "Shiga Toxin Type",
         y = "Number of cases",
         fill = "Category") +
    theme(
      axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 1, size = 8),
      axis.title.x = element_text(margin = margin(t = 10)),  # Move x-axis label further from the axis
      axis.title.y = element_text(margin = margin(r = 10)),  # Move y-axis label further from the axis
      plot.title = element_text(size = 12, hjust = 0)  # Title aligned left
    ) +
    scale_fill_manual(values = c("Highest" = "red", "Other" = "blue"))  # Colour for highest vs others
  
  # Create PT plot
  pt_plot <- ggplot(df_filtered %>% filter(Type == "PT"), aes(x = Value, y = count, fill = highlight, text = paste("Type:", Value, "<br>Count:", count))) +
    geom_bar(stat = "identity", position = position_dodge(width = 0.7), width = 0.6) +
    geom_text(aes(label = count), vjust = -0.3, size = 3) +  # Add text labels to bars
    theme_minimal() +
    labs(title = paste(label, "PT", year),
         x = "Phage Type",
         y = "Number of Cases",
         fill = "Category") +
    theme(
      axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 1, size = 8),
      axis.title.x = element_text(margin = margin(t = 10)),  # Move x-axis label further from the axis
      axis.title.y = element_text(margin = margin(r = 10)),  # Move y-axis label further from the axis
      plot.title = element_text(size = 12, hjust = 0)  # Title aligned left
    ) +
    scale_fill_manual(values = c("Highest" = "red", "Other" = "green"))  # Colour for highest vs others
  
  # Return the list of the two plots
  list(stx_plot, pt_plot)
}

# Generate interactive plots for each year with annotations for the highest values
interactive_plots <- mapply(function(year, label) {
  df <- yearly_data[[as.character(year)]]
  if (nrow(df) > 0) {  # Ensure there is data before plotting
    plots <- plot_yearly_counts_with_labels(df, year, label)
    return(plots)
  } else {
    NULL
  }
}, years_present, plot_labels, SIMPLIFY = FALSE)

# Flatten the list (since each year generates two plots, we get a list of lists)
interactive_plots <- unlist(interactive_plots, recursive = FALSE)

# Save all plots to a single PDF file
output_file <- "/Users/sahramusse/Documents/Applied Data Science in Biology/Semester 2 Assessment/all_plots.pdf"

# Open the PDF device to save plots
pdf(output_file, width = 8, height = 6)

# Loop through and save each plot
for (plot in interactive_plots) {
  print(plot)  # Display and save each plot to the PDF
}

# Close the PDF device to finalise the file
dev.off()

cat("All plots have been saved to", output_file)
