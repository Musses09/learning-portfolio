# Dice Project

# 1. Define the dice and rolling function
# Define the die as a vector of numbers
die <- 1:6

# Function to roll two dice and return their sum
roll_dice <- function() {
  dice <- sample(die, size = 2, replace = TRUE) # Roll two dice with replacement
  sum(dice) # Return the sum of the two dice
}

# 2. Simulate multiple rolls
# Simulate rolling dice 1000 times and store results
set.seed(123) # Set seed for reproducibility
roll_results <- replicate(1000, roll_dice())

# 3. Analyze Results
# View the first few results
head(roll_results)

# Summary statistics
summary(roll_results)

# Frequency table of results
roll_table <- table(roll_results)
roll_table

# 4. Visualization
# Load ggplot2 for enhanced visualization
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
library(ggplot2)

# Convert table to data frame for plotting
roll_df <- as.data.frame(roll_table)
colnames(roll_df) <- c("Sum", "Frequency")

# Plot the frequency of dice sums
ggplot(roll_df, aes(x = as.numeric(Sum), y = Frequency)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Frequency of Dice Sums", x = "Sum of Dice", y = "Frequency") +
  theme_minimal()

# 5. Advanced: Customizing the Dice
# Roll custom dice
custom_roll <- function(bones = 1:6, rolls = 1000) {
  dice_sums <- replicate(rolls, sum(sample(bones, size = 2, replace = TRUE)))
  return(dice_sums)
}

# Simulate custom rolls (e.g., 12-sided dice)
custom_results <- custom_roll(bones = 1:12, rolls = 1000)

# Summary and visualization for custom dice
summary(custom_results)

# Plot custom dice results
custom_table <- table(custom_results)
custom_df <- as.data.frame(custom_table)
colnames(custom_df) <- c("Sum", "Frequency")

ggplot(custom_df, aes(x = as.numeric(Sum), y = Frequency)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(title = "Frequency of Custom Dice Sums", x = "Sum of Dice", y = "Frequency") +
  theme_minimal()

