## GARCH Time Series Forecasting for AUD/JPY Exchange Rate

This repository contains an R script that demonstrates how to use the GARCH(1,1) (Generalized Autoregressive Conditional Heteroskedasticity) model for time series forecasting of the AUD/JPY (Australian Dollar to Japanese Yen) exchange rate. The GARCH(1,1) model is commonly used to analyze and forecast volatility in financial time series data, making it suitable for predicting future volatility of the AUD/JPY exchange rate. This Readme file provides an overview of the script and explains the steps involved in the forecasting process.

## Table of Contents

- [Dependencies](#dependencies)
- [Usage](#usage)
- [Results](#results)
- [License](#license)

## Dependencies

To run the script, you need to have the following R packages installed:

- quantmod
- rugarch

You can install these packages using the install.packages() function in R.

## Usage

1 Clone the repository or download the script file.

2 Open the R environment or an R script editor.

3 Install the required packages if they are not already installed:

install.packages(c("quantmod", "rugarch"))

## Results

The script provides the following functionality:

    Retrieving historical data for the AUD/JPY exchange rate from Yahoo Finance.
    Preprocessing the data and handling missing values using last observation carried forward (LOCF) method.
    Fitting an ARFIMA (AutoRegressive Fractionally Integrated Moving Average) model for forecasting.
    Estimating a GARCH(1,1) model for the closing prices of AUD/JPY exchange rate.
    Generating a 365-day ahead forecast using the GARCH(1,1) model.
    Visualizing the GARCH(1,1) model fit and forecasted volatility using various plots.
    Analyzing the model residuals and performing Ljung-Box test for model adequacy.

Execute the code step by step or run the entire script:

    The script uses the quantmod package to fetch historical data for the AUD/JPY exchange rate from Yahoo Finance.

    The data is preprocessed, and missing values are handled using the na.locf() function.

    An ARFIMA model is fitted to the data for forecasting using the autoarfima() function.

    A GARCH(1,1) model is specified and estimated for the closing prices using the ugarchspec() and ugarchfit() functions, respectively.

    A 365-day ahead forecast is generated using the estimated GARCH(1,1) model and the ugarchforecast() function.

    Various plots are used to visualize the GARCH(1,1) model fit and forecasted volatility.

    The script calculates and displays model information criteria (AIC, BIC, and HQIC) using the infocriteria() function.

    The model residuals are analyzed, and a normal Q-Q plot and Ljung-Box test are performed to assess the adequacy of the GARCH(1,1) model.

The script produces various diagnostic plots and statistical tests to evaluate the performance of the GARCH(1,1) model in forecasting the volatility of the AUD/JPY exchange rate.

## License

This script is released under the MIT License.

Feel free to copy the entire content and use it as a README file in your GitHub repository.
