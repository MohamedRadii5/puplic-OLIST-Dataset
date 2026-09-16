# Brazilian E-Commerce Public Dataset Analysis (Olist)

## 📌 Project Overview & About

An end-to-end exploratory analysis and data modeling project based on the **Olist E-Commerce Public Dataset**. This repository contains code for data cleaning, exploratory data analysis (EDA), geospatial visualization, and machine learning models applied to **100k anonymized commercial orders** from Brazilian marketplaces between 2016 and 2018.

---

## ✨ Key Features & Overview

* **Dataset Scope:** 100,000 real e-commerce orders collected across multiple dimensions including order status, pricing, freight performance, customer demographics, payment types, product metrics, and customer reviews.
* **Anonymization Note:** All company and logistics partner references within customer review texts have been masked using names of *Game of Thrones* great houses.
* **Geolocation:** Includes a mapped zip-code-to-coordinate dataset linking customer and seller locations across Brazil.

---

## 🗄️ Data Architecture & Schema

The data is structured into **8 interconnected relational tables** forming a Star Schema:

```text
                     olist_sellers
                          │
                          ▼
olist_customers ──► olist_orders ──► olist_order_items ──► olist_products
                          │                  │
                          ├─► reviews        └─► geolocation
                          └─► payments
``` 
## 📋 Table Descriptions

- **`olist_orders_dataset`**: Core table connecting customer IDs, order status, and timestamps.
- **`olist_customers_dataset`**: Customer location and unique customer identifiers for repurchase tracking.
- **`olist_order_items_dataset`**: Details on individual items purchased, freight calculations, and assigned sellers.
- **`olist_order_payments_dataset`**: Payment methods (credit card, boleto, vouchers) and installment details.
- **`olist_order_reviews_dataset`**: Review ratings (1 to 5 stars) and customer satisfaction comments.
- **`olist_products_dataset`**: Physical attributes (weight, dimensions) and product categories.
- **`olist_sellers_dataset`**: Seller location and logistics fulfillment metadata.
- **`olist_geolocation_dataset`**: ZIP code prefix mappings to latitude and longitude coordinates.

## 🎯 Potential Use Cases & Project Goals

### 🚚 Delivery Performance & Logistics
- Analyze shipping delays and delivery performance.
- Compare estimated vs. actual delivery dates.
- Identify regional logistics patterns and potential route optimization opportunities.

### 😊 Customer Satisfaction — NLP & Classification
- Process customer review text using NLP techniques.
- Predict low ratings (1–2 stars).
- Identify factors associated with poor customer satisfaction and potential churn.

### 📈 Sales Forecasting
- Perform time-series analysis on order volume and revenue.
- Forecast future sales trends.
- Analyze sales performance across different product categories.

### 👥 Customer Segmentation & LTV
- Perform **RFM (Recency, Frequency, Monetary)** analysis.
- Segment customers based on purchasing behavior.
- Analyze customer lifetime value (LTV).
- Identify high-value and at-risk customer segments.

## 🛠️ Technologies Used

- **Languages:** Python, SQL
