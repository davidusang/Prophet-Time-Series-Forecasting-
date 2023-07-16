# Load necessary packages
library(quantmod)  # Package for financial econometrics and time series analysis
library(rugarch)   # Package for univariate GARCH modeling

# Retrieve symbols from Yahoo Finance
getSymbols("AUDJPY=X", src = "yahoo", periodicity = "daily")  # Fetch daily AUD/JPY exchange rate data

# Assign 'AUDJPY=X' Close prices to variable 'df'
df <- `AUDJPY=X`  # Store the AUD/JPY exchange rate data in the variable 'df'
print(df)  # Print the dataset to inspect its contents


# Handle Missing Values
sum(is.na(df))  # Count the number of missing values in the dataset

# Fill NA values using the last observation carried forward (na.locf) method
df <- na.locf(df[, 4], fromLast = TRUE)  # Apply last observation carried forward to fill NAs in the Close prices

# Confirm there are no more missing values
sum(is.na(df))  # Ensure that there are no missing values in the dataset


# Forecast Upper Values for the First 5 Observations
fitarfima <- autoarfima(data = df, ar.max = 2, ma.max = 2, 
                        criterion = "AIC", method = "full")  # Automatically fit an ARFIMA model to the data
fitarfima  # Print the ARFIMA model summary


# Define the GARCH(1,1) Model for Closing Prices
garch11closeprice <- ugarchspec(variance.model = list(garchOrder = c(1, 1)), 
                                mean.model = list(armaOrder = c(1, 2)),
                                distribution.model = "norm")  # Specify the GARCH(1,1) model

# Estimate the GARCH(1,1) Model
garch11closepricefit <- ugarchfit(data = df, spec = garch11closeprice)  # Fit the GARCH(1,1) model to the data

# Plot the GARCH(1,1) Model Fit
plot(garch11closepricefit, which = "all")  # Visualize the model fit using various diagnostic plots


# Generate a 365-Day Ahead Forecast Using the GARCH(1,1) Model
f <- ugarchforecast(fitORspec = garch11closepricefit, n.ahead = 252)  # Create a 365-day ahead forecast using the GARCH model

# Plot the Forecast
plot(f)  # Visualize the GARCH forecast
plot(fitted(f))  # Plot the fitted values from the forecast
plot(sigma(f))  # Plot the conditional volatility from the forecast

# Check for Missing Values in the Forecast
sum(is.na(sigma(garch11closepricefit)))  # Count the number of missing values in the conditional volatility


# Use the str Function to Identify the Structure of the Data
str(sigma(garch11closepricefit))  # Display the structure of the conditional volatility data


# Plot the Conditional Volatility
plot(sigma(garch11closepricefit), ylab = "sigma(t)", col = "blue")  # Visualize the conditional volatility


# Calculate Model AIC, BIC, and HQIC Information Criteria
infocriteria(garch11closepricefit)  # Compute the information criteria for the GARCH model


# Obtain Normal Residuals
garchres <- data.frame(residuals(garch11closepricefit))  # Extract the normal residuals from the GARCH model
plot(garchres$residuals)  # Visualize the normal residuals


# Obtain Standardized Residuals
garchres <- data.frame(residuals(garch11closepricefit, standardize = TRUE))  # Extract the standardized residuals
qqnorm(garchres$residuals)  # Create a normal Q-Q plot of the standardized residuals
qqline(garchres$residuals)  # Add a reference line to the Q-Q plot


# Perform Ljung-Box Test on Squared Standardized Residuals
garchres <- data.frame(residuals(garch11closepricefit, standardize = TRUE)^2)  # Obtain squared standardized residuals
Box.test(garchres$residuals, type = "Ljung-Box")  # Perform the Ljung-Box test on the squared residuals


# GARCH Forecasting
garchforecast <- ugarchforecast(fitORspec = garch11closepricefit, n.ahead = 365)  # Generate a GARCH forecast

# Plot the GARCH Forecast
plot(garchforecast)  # Visualize the GARCH forecast
