source("preload.R")

library(ggplot2)  # This package contains the diamonds dataset

# Load the diamonds dataset
data(diamonds)

# Use subset because HC3 standard errors are slow to calculate
diamonds <- diamonds[1:5000,]

# Create an arbitrary clustering variable based on diamond color
diamonds$color_group <- as.factor(diamonds$color)

# Define five models
model1 <- lm(price ~ carat, data = diamonds)
model2 <- lm(price ~ carat + cut, data = diamonds)
model3 <- lm(price ~ carat + cut + x + y + z, data = diamonds)
model4 <- lm(price ~ carat + cut + depth, data = diamonds)
model5 <- lm(price ~ carat + cut + depth + table, data = diamonds)

# Create a list of models
table1_models <- list(model1, model2, model3, model4, model5)

# Calculate clustered standard errors and p-values
table1_se <- clustered(table1_models, 2, ~ color_group)
table1_p <- clustered(table1_models, 4, ~ color_group)

# Create the table using the tt function
table1 <- tt(table1_models,
             override.se = table1_se,
             override.pvalues = table1_p,
             caption = "Regression Models for Diamond Prices",
             custom.gof.rows = list(
                                    "Outcome" = rep("Price", length(table1_models)),
                                    "Model" = rep("OLS", length(table1_models))
                                    ),
             custom.header = list("Baseline models" = 1:3, "Extended models" = 4:5)

)

# NOTE: I recommend using a coefficient map (custom.coef.map)
# It works like this:
# my_map <- list(
#   "name_in_model" = "Output name",
#   ...
# )

# Save the table to a .tex file
save_to("tex", table1)
