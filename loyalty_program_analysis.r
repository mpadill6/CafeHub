# CafeHub Customer Loyalty Program Analysis

# Step 1: Data Import
# - Create a new R script file named "loyalty_program_analysis.R".
# - Use the `read.csv()` function to import the customer data from the "customer_data.csv" file and the loyalty program data from the "loyalty_data.csv" file.
# - Assign the imported data to variables named `customer_data` and `loyalty_data`, respectively.
# - Print the first few rows of both datasets using the `head()` function to verify the import.

# Import customer data
customer_data <- read.csv("/Users/mariopadilla/R Projects/CafeHub/customer_data.csv")
loyalty_data <- read.csv("/Users/mariopadilla/R Projects/CafeHub/loyalty_data.csv")

# Print the first few rows of the data
print(head(customer_data))
print(head(loyalty_data))

# Step 2: Data Cleaning and Preprocessing
# - Check for missing values in both datasets using the `is.na()` function.
# - Remove any rows with missing values using the `na.omit()` function.
# - Convert the `Age` column in `customer_data` to numeric using the `as.numeric()` function.
# - Convert the `Purchase.Date` column in `customer_data` to a date format using the `as.Date()` function.
# - Merge the `customer_data` and `loyalty_data` based on the `CustomerID` column using the `merge()` function.

# Check for missing values
sum(is.na(customer_data))
sum(is.na(loyalty_data))

# Remove rows with missing values
customer_data <- na.omit(customer_data)
loyalty_data <- na.omit(loyalty_data)

# Check that missing values are removed
sum(is.na(customer_data))
sum(is.na(loyalty_data))

#Check the class of the Age column
class(customer_data$Age)
# Convert `Age` column to numeric
customer_data$Age <- as.numeric(customer_data$Age)
#Check the class of the Age column after conversion
class(customer_data$Age)

#Check the class of the Purchase.Date column
class(customer_data$Purchase.Date)
# Convert `Purchase.Date` column to date format
customer_data$Purchase.Date <- as.Date(customer_data$Purchase.Date)
#Check the class of the Purchase.Date column after conversion
class(customer_data$Purchase.Date)

# Merge customer_data and loyalty_data
merged_data <- merge(customer_data, loyalty_data, by = "CustomerID")
print(head(merged_data))

# Step 3: Exploratory Data Analysis
# - Calculate the total number of customers using the `nrow()` function.
# - Calculate the average age of customers using the `mean()` function on the `Age` column.
# - Determine the gender distribution by calculating the count of each unique value in the `Gender` column using the `table()` function.
# - Calculate the average purchase amount per customer using the `mean()` function on the `Purchase.Amount` column.
# - Use a `for` loop to iterate over each customer and calculate the total number of purchases and total loyalty points earned.
# - Use conditional statements (`if-else`) to categorize customers into loyalty tiers based on their total loyalty points:
#   - "Bronze" tier for customers with less than 100 points
#   - "Silver" tier for customers with 100 to 499 points
#   - "Gold" tier for customers with 500 or more points
# - Count the number of customers in each loyalty tier using the `table()` function.

# Calculate total number of customers
total_customers <- nrow(merged_data)
print(total_customers)
# Calculate average age of customers
average_age <- mean(merged_data$Age)
print(average_age)
# Determine gender distribution
gender_distribution <- table(merged_data$Gender)
print(gender_distribution)
# Calculate average purchase amount per customer
average_purchase_amount <- mean(merged_data$Purchase.Amount)
print(average_purchase_amount)
# Initialize variables to store customer analysis results
customer_purchases <- numeric(total_customers)
customer_loyalty_points <- numeric(total_customers)
customer_loyalty_tier <- character(total_customers)

# Iterate over each customer
for (i in 1:total_customers) {
  customer_id <- merged_data$CustomerID[i]
  customer_purchases[i] <- sum(merged_data$CustomerID == customer_id)
  customer_loyalty_points[i] <- merged_data$LoyaltyPoints[i]
  
  # Categorize customers into loyalty tiers
  if (customer_loyalty_points[i] < 100) {
    customer_loyalty_tier[i] <- "Bronze"
  } else if (customer_loyalty_points[i] >= 100 && customer_loyalty_points[i] < 500) {
    customer_loyalty_tier[i] <- "Silver"
  } else {
    customer_loyalty_tier[i] <- "Gold"
  }
}

# Count the number of customers in each loyalty tier
loyalty_tier_count <- table(customer_loyalty_tier)
print(loyalty_tier_count)


# Step 4: Summary Report
# - Create a new variable named `summary_report` and assign an empty character vector to it.
# - Use the `paste()` function to concatenate the analysis results into the `summary_report` variable.
# - Include the total number of customers, average age, gender distribution, average purchase amount, and the count of customers in each loyalty tier in the report.
# - Use the `cat()` function to print the `summary_report` to the console.
# - Use the `write()` function to save the `summary_report` to a text file named "loyalty_program_analysis_report.txt".

# Create an empty summary report variable
summary_report <- character()

# Concatenate analysis results into the summary report
summary_report <- c(summary_report, paste("Total Customers:", total_customers))
summary_report <- c(summary_report, paste("Average Age:", round(average_age, 2)))
#summary_report <- c(summary_report, paste("Gender Distribution:", paste(names(gender_distribution), collapse = ", ")))
summary_report <- c(summary_report, paste("Average Purchase Amount:", round(average_purchase_amount, 2)))
summary_report <- c(summary_report, paste("Loyalty Tier Count:", paste(names(loyalty_tier_count), ":", loyalty_tier_count, collapse = ", ")))

# Print the summary report to the console
cat(paste(summary_report, collapse = "\n"))

# Save the summary report to a text file
write(summary_report, "loyalty_program_analysis_report.txt")