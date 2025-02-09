library(plotly)
library(htmlwidgets)

# Load Region-Level Data
region_distribution <- read.csv("/Users/sahramusse/Documents/Applied Data Science in Biology/Semester 2 Assessment/Metadata/STEC_Region_Distribution.csv", header = TRUE)
colnames(region_distribution) <- gsub("^X", "", colnames(region_distribution))

# Convert selected columns (2014 to 2019) into a numeric matrix
region_matrix <- as.matrix(region_distribution[, c("2014", "2015", "2016", "2017", "2018", "2019")])
region_matrix <- apply(region_matrix, 2, as.numeric)  
rownames(region_matrix) <- region_distribution$Regions
colnames(region_matrix) <- c("2014", "2015", "2016", "2017", "2018", "2019")

# Load Country-Level Data
country_distribution <- read.csv("/Users/sahramusse/Documents/Applied Data Science in Biology/Semester 2 Assessment/Metadata/STEC_Countries_Distribution.csv", header = TRUE)
colnames(country_distribution) <- gsub("^X", "", colnames(country_distribution))

# Convert selected columns (2014 to 2019) into a numeric matrix
country_matrix <- as.matrix(country_distribution[, c("2014", "2015", "2016", "2017", "2018", "2019")])
country_matrix <- apply(country_matrix, 2, as.numeric)  
rownames(country_matrix) <- country_distribution$Countries
colnames(country_matrix) <- c("2014", "2015", "2016", "2017", "2018", "2019")

# Statistical calculations for region
stats_region <- data.frame(
  Region = rownames(region_matrix),
  Mean = apply(region_matrix, 1, mean, na.rm = TRUE),
  Median = apply(region_matrix, 1, median, na.rm = TRUE),
  SD = apply(region_matrix, 1, sd, na.rm = TRUE)
)

# Statistical calculations for country
stats_country <- data.frame(
  Country = rownames(country_matrix),
  Mean = apply(country_matrix, 1, mean, na.rm = TRUE),
  Median = apply(country_matrix, 1, median, na.rm = TRUE),
  SD = apply(country_matrix, 1, sd, na.rm = TRUE)
)

# Generate hover text for region
hover_text_region <- matrix("", nrow = nrow(region_matrix), ncol = ncol(region_matrix))
for (i in 1:nrow(region_matrix)) {
  for (j in 1:ncol(region_matrix)) {
    hover_text_region[i, j] <- paste0(
      "(A) Region: ", rownames(region_matrix)[i], "<br>",
      "Year: ", colnames(region_matrix)[j], "<br>",
      "Cases: ", region_matrix[i, j], "<br>",
      "Mean: ", round(stats_region$Mean[i], 2), "<br>",
      "Median: ", round(stats_region$Median[i], 2), "<br>",
      "SD: ", round(stats_region$SD[i], 2)
    )
  }
}

# Generate hover text for country
hover_text_country <- matrix("", nrow = nrow(country_matrix), ncol = ncol(country_matrix))
for (i in 1:nrow(country_matrix)) {
  for (j in 1:ncol(country_matrix)) {
    hover_text_country[i, j] <- paste0(
      "(B) Country: ", rownames(country_matrix)[i], "<br>",
      "Year: ", colnames(country_matrix)[j], "<br>",
      "Cases: ", country_matrix[i, j], "<br>",
      "Mean: ", round(stats_country$Mean[i], 2), "<br>",
      "Median: ", round(stats_country$Median[i], 2), "<br>",
      "SD: ", round(stats_country$SD[i], 2)
    )
  }
}

# Find max value for color scaling
max_val <- max(c(region_matrix, country_matrix), na.rm = TRUE)

# Create region-level heatmap
heatmap_region <- plot_ly(
  z = t(region_matrix),
  x = rownames(region_matrix),
  y = colnames(region_matrix),
  text = t(hover_text_region),
  hoverinfo = "text",
  type = "heatmap",
  colorscale = "Inferno",  # Using "Inferno" for better contrast
  zmin = 0,
  zmax = max_val,
  colorbar = list(title = "Cases (Region)")
) %>% layout(
  title = "(A) Regional Distribution",
  xaxis = list(
    title = "Regions",
    tickangle = 90,  
    tickfont = list(size = 10)
  ),
  yaxis = list(title = "Years"),
  margin = list(t = 30, b = 50, l = 40, r = 40)
)

# Create country-level heatmap
heatmap_country <- plot_ly(
  z = t(country_matrix),
  x = rownames(country_matrix),
  y = colnames(country_matrix),
  text = t(hover_text_country),
  hoverinfo = "text",
  type = "heatmap",
  colorscale = "Inferno",  # Using the same "Inferno" color scale for consistency
  zmin = 0,
  zmax = max_val,
  colorbar = list(title = "Cases (Country)")
) %>% layout(
  title = "(B) Country-Level Distribution",
  xaxis = list(
    title = "Countries",
    tickangle = 90,
    tickfont = list(size = 10)
  ),
  yaxis = list(title = "Years"),
  margin = list(t = 30, b = 50, l = 40, r = 40)
)

# Display both heatmaps separately
heatmap_region
heatmap_country

# Save the region-level heatmap separately
saveWidget(heatmap_region, "/Users/sahramusse/Documents/Applied Data Science in Biology/Semester 2 Assessment/Results/heatmap_region.html")

# Save the country-level heatmap separately
saveWidget(heatmap_country, "/Users/sahramusse/Documents/Applied Data Science in Biology/Semester 2 Assessment/Results/heatmap_country.html")
