#  Data Preparation and Exploration

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Load data from CSV or SQL database
data = pd.read_csv('agriculture_data.csv')

# Explore data
print(data.head())
print(data.info())
print(data.describe())

# Handle missing values
data.fillna(method='ffill', inplace=True)

# Visualize data
sns.pairplot(data)
plt.show()

#  Feature Engineering

# Create new features
data['Temperature_Category'] = pd.cut(data['Temperature'], bins=[0, 15, 25, 35, 100], labels=['Cold', 'Mild', 'Warm', 'Hot'])
data['Rainfall_Category'] = pd.cut(data['Rainfall'], bins=[0, 10, 20, 30, 100], labels=['Low', 'Medium', 'High', 'Very High'])

# Encode categorical features
data = pd.get_dummies(data, columns=['Temperature_Category', 'Rainfall_Category', 'FertilizerName'])

# Model Selection and Training

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score

# Split data into training and testing sets
X = data.drop('Yield', axis=1)
y = data['Yield']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Create and train models
linear_model = LinearRegression()
rf_model = RandomForestRegressor(n_estimators=100, random_state=42)

linear_model.fit(X_train, y_train)
rf_model.fit(X_train, y_train)

# Make predictions
y_pred_linear = linear_model.predict(X_test)
y_pred_rf = rf_model.predict(X_test)

# Evaluate models
print('Linear Regression:')
print('Mean Squared Error:', mean_squared_error(y_test, y_pred_linear))
print('R-squared:', r2_score(y_test, y_pred_linear))

print('\nRandom Forest Regression:')
print('Mean Squared Error:', mean_squared_error(y_test, y_pred_rf))
print('R-squared:', r2_score(y_test, y_pred_rf))

# API-Based Deployment

from flask import Flask, request, jsonify
import joblib

app = Flask(__name__)
model = joblib.load('model.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    # Preprocess data
    # Make prediction using the model
    prediction = model.predict([data])
    return jsonify({'prediction': prediction[0]})

if __name__ == '__main__':
    app.run(debug=True)

