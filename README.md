# 📚 Bookstore Analytics System

## 📌 Project Overview
The Bookstore Analytics System is a SQL-based analytics project focused on extracting meaningful business insights from a bookstore database. The project simulates real-world business scenarios by analyzing sales performance, customer behavior, inventory trends, and operational metrics using advanced SQL queries.

This project demonstrates strong proficiency in SQL, business intelligence, KPI analysis, and data-driven decision-making.

---

# 🛠 Tech Stack
- SQL (PostgreSQL)
- Relational Database Management System (RDBMS)

---

# 🗂 Database Modules
The database consists of multiple interconnected tables including:

- Customers
- Orders
- Order Items
- Books
- Authors
- Genres
- Publishers
- Shipping

---

# 📊 Business Analytics Performed

## 🔹 Sales & Revenue Analytics
- Total Revenue Generated
- Revenue by Genre
- Monthly Revenue Trend
- Running Revenue Analysis
- Best Sales Month
- Revenue by Country
- Highest Revenue Generating Books
- Top Publisher by Revenue

## 🔹 Customer Analytics
- Total Orders per Customer
- Customer Lifetime Value (CLV)
- High-Value Customers
- Repeat Customers
- Customer Segmentation
- Customer Spending Ranking

## 🔹 Product & Inventory Analytics
- Top 5 Best Selling Books
- Top Selling Author
- Most Popular Genre
- Top 3 Books in Each Genre
- Books Never Ordered
- Low Stock Alert System

## 🔹 Operational Metrics
- Average Order Value (AOV)
- Average Books per Order
- Cancelled Order Percentage
- Daily Sales Performance Ranking

---

# ⚡ Advanced SQL Concepts Used
- JOIN Operations
- Aggregate Functions
- GROUP BY & HAVING
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- CASE Statements
- Ranking Functions
- Date & Time Functions

---

# 📈 Key Insights Generated
- Identified the most profitable books, genres, authors, and publishers
- Analyzed customer purchasing patterns and repeat buying behavior
- Tracked monthly and cumulative revenue growth trends
- Segmented customers based on spending behavior for targeted marketing
- Detected underperforming books and low-stock inventory items
- Evaluated operational efficiency through cancellation analysis
- Analyzed country-wise revenue contribution

---

# 🧠 Sample SQL Queries

## 1️⃣ Total Revenue Generated
```sql
SELECT SUM(subtotal) AS total_revenue
FROM order_items;
```

## 2️⃣ Top 5 Best Selling Books
```sql
SELECT b.title,
       SUM(oi.quantity) AS total_quantity
FROM books b
JOIN order_items oi
ON b.book_id = oi.book_id
GROUP BY b.title
ORDER BY total_quantity DESC
LIMIT 5;
```

## 3️⃣ Customer Lifetime Value (CLV)
```sql
SELECT c.first_name,
       c.last_name,
       SUM(oi.subtotal) AS lifetime_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY lifetime_value DESC;
```

---

# 🎯 Project Objectives
- Perform business-oriented SQL analysis on a relational database
- Generate actionable insights using real-world KPIs
- Strengthen SQL problem-solving and analytical skills
- Simulate practical analytics scenarios used in industry

---

# 🚀 Skills Demonstrated
- SQL Query Writing
- Data Analysis
- Business Intelligence
- KPI Reporting
- Data Exploration
- Analytical Thinking
- Database Management
- Problem Solving

---

# 📌 Project Outcome
This project helped in developing a deeper understanding of how SQL can be used to solve real business problems by transforming raw transactional data into actionable business insights.

It is designed as a portfolio-ready project for:
- Data Analyst Roles
- Business Analyst Roles
- SQL/Data Analytics Internships

---
````

