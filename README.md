# Ola Ride-Booking Data Analysis
## Overview
This project analyzes Ola’s ride-booking data for the month of July. Using SQL queries and Power BI visualizations, we extracted insights into booking trends, customer behavior, vehicle performance, payment methods, and cancellation patterns. These findings aim to inform business decisions, enhance customer satisfaction, and optimize operational efficiency.

## Dataset
The dataset consists of 19 columns and 103,024 rows, covering diverse ride-booking details. Key attributes include:

- Pickup_Location, Booking_Time, Ride_Distance, and Booking_Value: Core ride details.
- Booking_Status: Indicates if a booking was successful or canceled.
- Customer_ID and Driver_ID: Unique identifiers for customer and driver analysis.
- Driver_Ratings and Customer_Ratings: Service quality indicators.
- Payment_Method: Specifies the payment mode (e.g., Cash, UPI).
- Canceled_Rides_by_Driver and Canceled_Rides_by_Customer: Cancellation reasons by drivers and customers.

This diverse dataset enabled in-depth analysis of Ola’s business operations.

## Objectives
- Booking Trends: Identify peak demand periods, popular pickup locations, frequent booking hours, and high-completion areas.
- Customer Behavior: Analyze customer segments, spending patterns, average ride distances, and high-value customers.
- Vehicle & Driver Insights: Examine vehicle type usage, driver ratings, and frequent cancellations.
- Distance and Ride Metrics: Determine average successful ride distances and assess the correlation between ride distance and booking value.
- Payment Analysis: Explore the revenue contribution of each payment method and analyze cash vs. cashless payments.
- Cancellation Insights: Discover common cancellation reasons and trends by time and cancellation impact on revenue.
- Advanced Metrics: Investigate correlations between driver and customer ratings for quality assessment.

## Project Structure
- SQL Queries: SQL scripts to create views for various analyses on booking trends, customer behavior, vehicle insights, and cancellation patterns.
- Power BI Dashboard: Visualizations created in Power BI to supplement SQL findings, showcasing booking frequency, top locations, customer segments, and cancellation patterns.

## Power BI Findings
Key findings visualized in Power BI include:

- Booking Trends: Showed peak booking hours and common pickup locations.
- Customer Segmentation: Highlighted frequent and high-spending customers.
- Cancellation Trends: Illustrated high-cancellation hours and reasons.
- Payment Contribution: Displayed the popularity and revenue contribution of each payment method.

## Conclusion
This project uncovered valuable insights into Ola’s operations and customer behavior. Key findings include:

- Peak booking times and high-demand locations, which guide resource allocation.
- Customer segmentation, revealing revenue concentration from frequent and high-spending users.
- Vehicle and cancellation insights that help Ola address common service gaps.

## How to Use
- Clone the Repository:
git clone https://github.com/yourusername/ola-ride-booking-analysis.git
- SQL Analysis:
-- Run the SQL queries provided in the /sql_queries folder on the dataset to generate various insights.
- Power BI Dashboard:
-- Open the Power BI file to view the visualizations for booking trends, customer behavior, and more.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
