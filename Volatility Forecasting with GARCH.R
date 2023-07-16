# Dataset and package loading

# Load necessary packages
library(quantmod)
library(rugarch)

# Retrieve symbols from Yahoo Finance
getSymbols("AUDJPY=X", src = "yahoo", periodicity = "daily")

# Assign 'AUDJPY=X' Close prices to variable 'df'
df <- `AUDJPY=X`
print(df)


# Handle missing values
sum(is.na(df))

# Fill NA values using last observation carried forward (na.locf) method
df <- na.locf(df[, 4], fromLast = TRUE)

# Confirm NAs
sum(is.na(df))

# Forecast upper values for the first 5 observations
fitarfima <- autoarfima(data = df, ar.max = 2, ma.max = 2, 
                        criterion = "AIC", method = "full")
fitarfima


# Define the GARCH(1,1) model for closing prices
garch11closeprice <- ugarchspec(variance.model = list(garchOrder = c(1, 1)), 
                                mean.model = list(armaOrder = c(1, 2)),
                                distribution.model = "norm")

# Estimate the GARCH(1,1) model
garch11closepricefit <- ugarchfit(data = df, spec = garch11closeprice)

# Plot the GARCH(1,1) model fit
plot(garch11closepricefit, which = "all")

# Generate a 365-day ahead forecast using the GARCH(1,1) model
f <- ugarchforecast(fitORspec = garch11closepricefit, n.ahead = 252)

# Plot the forecast
plot(f)
plot(fitted(f))
plot(sigma(f))

#Check for missing values
sum(is.na(sigma(garch11closepricefit)))

# Use the str function to identify the structure of the data
str(sigma(garch11closepricefit))

# Plot the conditional volatility
plot(sigma(garch11closepricefit), ylab = "sigma(t)", col = "blue")


# Plot the conditional volatility
#plot.ts(sigma(garch11closepricefit), ylab = "sigma(t)", col = "blue")

# Calculate model AIC, BIC, and HQIC information criteria
infocriteria(garch11closepricefit)

# Obtain normal residuals
garchres <- data.frame(residuals(garch11closepricefit))  
plot(garchres$residuals)

# Obtain standardized residuals
garchres <- data.frame(residuals(garch11closepricefit, standardize = TRUE)) 

# Create normal Q-Q plot
qqnorm(garchres$residuals)
qqline(garchres$residuals)

# Perform Ljung-Box test on squared standardized residuals
garchres <- data.frame(residuals(garch11closepricefit, standardize = TRUE)^2) 
Box.test(garchres$residuals, type = "Ljung-Box")

# GARCH forecasting
garchforecast <- ugarchforecast(fitORspec = garch11closepricefit, n.ahead = 365)

# Plot the GARCH forecast
plot(garchforecast)
