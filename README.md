<<<<<<< HEAD
# Pricing-Subscription-Plan-Analysis
SQL analysis of subscription plans and user behavior to measure conversion, revenue, and churn trends for product decision-making.
=======
# Application Subscription Trend Analysis and Churn Prediction

This project aims to analyze Application subscription trends and predict churn using machine learning models. We explore key features influencing customer retention and develop a predictive model to identify customers who are likely to churn. The repository contains the Python code for the machine learning model as well as a Tableau dashboard visualizing key trends.

## 1. Project Overview

Customer churn prediction is essential for subscription-based businesses to maintain customer retention and minimize revenue loss. This project leverages customer data to build a predictive model for identifying at-risk customers and explores patterns and trends in customer subscriptions.

### Key Objectives:
- **Analyze customer subscription trends** to identify patterns that may indicate churn.
- **Build a machine learning model** to predict whether a customer will churn.
- **Visualize insights** from the data using Tableau for a clear understanding of customer behavior.

## 2. Features and Approach

### 2.1 Data Preparation
The data includes various features such as:
- **User Demographics** (Age, Gender, Country)
- **Subscription Details** (Subscription Type, Monthly Revenue, Plan Duration)
- **Payment History** (Join Date, Last Payment Date)

### 2.2 Feature Engineering
We applied feature engineering to improve model performance:
- **Subscription Tenure**: Calculated the tenure from the **Join Date** to the **Last Payment Date** to measure how long each customer has been subscribed.
- **Total Revenue Generated**: Created by multiplying the **Subscription Tenure** by the **Monthly Revenue**, providing insight into customer value.
- **Device Usage & Geography**: Categorical variables were transformed using one-hot encoding for better predictive power.

### 2.3 Model Building
A decision tree-based classification model was developed to predict customer churn. Additionally, oversampling via **SMOTE** was applied to balance the dataset and improve performance for predicting churned customers.

### Key Model Results:
- After feature engineering and SMOTE, the model’s precision, recall, and accuracy improved significantly, with the final accuracy reaching **70%**.

## 3. Files in This Repository

### 3.1 Python ML Code (`Application_Subscription_Trend_Analysis_and_Churn_Prediction.ipynb`)
This Python script contains the full code for:
- Data preprocessing and feature engineering.
- Model building, training, and evaluation (including SMOTE).
- Model performance metrics such as accuracy, precision, recall, and F1-score.

You can run the code to reproduce the results and experiment with different models and parameters.

### 3.2 Tableau Dashboard (`Dashboard.png`)
This is a screenshot of the Tableau dashboard that visualizes key customer insights, such as:
- Subscription trends across different demographics.
- Churn rates by subscription type, device, and region.
- Total revenue distribution across customer segments.

### 3.3 Dataset (Application_Userbase.csv)
This file contains the dataset used for the project. To use this file, upload it to your own Google Colab environment and update the file path in the Python code to point to the location of this dataset. This will allow you to run the analysis seamlessly on your own setup.

The dashboard provides a clear visualization of customer behavior and key drivers of churn.

## 4. Getting Started

### Prerequisites
- Python 3.x
- Required libraries: `pandas`, `numpy`, `sklearn`, `imblearn`, `matplotlib`, etc.
- Tableau for visualizations

## 5. Results and Conclusion

- **Model Performance**: The model achieved a **70% accuracy** after feature engineering and balancing the dataset.
- **Insights**: The model highlighted that subscription tenure, total revenue, and subscription type were key factors influencing customer churn.
- **Visualizations**: Tableau dashboard provides a detailed view of customer segments and churn behavior, allowing business users to interpret trends easily.

## 6. Future Work
- **Model Improvements**: Further model tuning can be done to improve recall for churned customers.
- **New Features**: Explore additional features such as customer engagement metrics to enhance predictions.
- **Deployment**: Implement model deployment using Flask or Django for real-time churn prediction.
>>>>>>> 37d58bce883821df502b8592cb593531782af204
