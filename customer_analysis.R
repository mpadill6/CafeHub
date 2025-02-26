
# Step 1: Data Import
# Import customer data from a CSV file
customer_data <- read.csv("/Users/juanpadilla/CafeHub/customer_data.csv")

# Display the first few rows of the customer data
#head(customer_data,3)
#print(head(customer_data))

# Step 2: Data Cleaning and Preprocessing

# Check for missing values in the entire dataframe
missing_values <- is.na(customer_data)
# Print the total number of missing values
#print(sum(missing_values))

# - Remove any rows with missing values using the `na.omit()` function.
#customer_data <- na.omit(customer_data)
#print(customer_data)

# Convert `Age` column to numeric
customer_data$Age <- as.numeric(customer_data$Age)
# Print the structure of the dataframe to confirm the change
#str(customer_data)

# Convert the Purchase.Date column to Date format
customer_data$Purchase.Date <- as.Date(customer_data$Purchase.Date)
# Print the structure of the dataframe to confirm the change
#str(customer_data)


# Step 3: Exploratory Data Analysis

# - Calculate the total number of customers using the `nrow()` function.
total_customers <- nrow(customer_data)
#print(total_customers)

# - Calculate the average age of customers using the `mean()` function on the `Age` column.
# Calculate average age of customers
average_age <- mean(customer_data$Age)
#print(average_age)

# - Determine the gender distribution by calculating the count of each unique value in the `Gender` column using the `table()` function.
gender_distribution <- table(customer_data$Gender)
#print(gender_distribution)

# - Calculate the average purchase amount per customer using the `mean()` function on the 
average_purchase_amount <- mean(customer_data$Purchase.Amount)
print(average_purchase_amount)

# - Identify the top 5 most frequently purchased products using the `table()` function on the `Product` column and selecting the top 5 using the `head()` function.
top_products <- head(sort(table(customer_data$Product), decreasing = TRUE), 5)
print(top_products)    