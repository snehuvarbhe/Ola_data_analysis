--Here’s a deeper set of analytical questions to extract insights from the dataset:

--Booking Trends

--1. Count the total number of bookings for July.
CREATE VIEW entry_count AS
SELECT COUNT(*) AS Total_bookings_in_july 
FROM ola 
WHERE EXTRACT(MONTH FROM "Date")=7;

SELECT * FROM entry_count

--2. Identify the top 3 most common pickup locations.
CREATE VIEW common_pickup_loc AS
SELECT "Pickup_Location",
       COUNT(*) AS frequency_of_rides 
FROM ola 
GROUP BY "Pickup_Location"
ORDER BY COUNT(*) DESC LIMIT 3;

SELECT * FROM common_pickup_loc;

--3. Retrieve all successful bookings:
CREATE VIEW succesful_booking_data AS
SELECT * 
FROM ola 
WHERE "Booking_Status"='Success';

SELECT * FROM succesful_booking_data;

--4. Identify the most frequent booking hours and their average booking value.
CREATE VIEW frequent_booking_hour AS
SELECT EXTRACT(HOUR FROM "Time") AS Booking_hour,
       COUNT(*) AS Booking_frequency,
	   ROUND(avg("Booking_Value")::numeric,2) AS Avg_booking_value
FROM ola
GROUP BY Booking_hour
ORDER BY Booking_frequency DESC;

SELECT * FROM frequent_booking_hour;

--5. Which locations have the highest ride completion rates?
CREATE VIEW highest_ride_location AS
SELECT "Pickup_Location",
       COUNT(*) AS ride_frequency
FROM ola
WHERE "Booking_Status" like 'Success'
GROUP BY "Pickup_Location"
ORDER BY ride_frequency DESC
limit 1;

SELECT * FROM highest_ride_location;

-----------------------------------------------------------------------------------------------------------------------------

--Customer Behavior

--1. Which customers have completed the most bookings, and how much revenue do they generate?
CREATE VIEW customer_with_most_booking AS
SELECT "Customer_ID",COUNT(*) AS number_of_bookings,
       SUM("Booking_Value") AS revenue 
FROM ola 
WHERE "Booking_Status"='Success' 
GROUP BY "Customer_ID"
ORDER BY COUNT(*) DESC,SUM("Booking_Value") DESC;

SELECT * FROM customer_with_most_booking;

--2. What is the average distance and value of rides for each customer?
CREATE VIEW average_distance_and_revenue_per_customer AS
SELECT "Customer_ID",
       AVG("Ride_Distance") AS average_distance,
	   AVG("Booking_Value") AS average_revenue
FROM ola 
WHERE "Booking_Status"='Success'
GROUP BY "Customer_ID"
ORDER BY average_distance DESC,average_revenue DESC;

SELECT * FROM average_distance_and_revenue_per_customer;

---3. Which customer segment generates the most revenue (e.g., frequent, high-spending customers)?

CREATE VIEW customer_segment_revenue AS
SELECT 
    "Customer_ID",
    COUNT(*) AS number_of_bookings,  -- Count the number of bookings
    SUM("Booking_Value") AS total_revenue,  -- Sum the booking values for total revenue
    AVG("Booking_Value") AS avg_booking_value,  -- Calculate average spending per booking
    CASE
        WHEN COUNT(*) >= 5 THEN 'Frequent'
        WHEN SUM("Booking_Value") >= 1000 THEN 'High-Spending'
        ELSE 'Other'
    END AS customer_segment
FROM ola
WHERE "Booking_Status" = 'Success'  -- Filter for successful bookings
GROUP BY "Customer_ID"
ORDER BY total_revenue DESC, number_of_bookings DESC;

SELECT * FROM customer_segment_revenue;

-----------------------------------------------------------------------------------------------------------------------------

--Vehicle and Driver Insights

--1. List distinct vehicle types used in July.
CREATE VIEW distinct_vehicle_list AS
SELECT DISTINCT "Vehicle_Type" 
FROM ola;
SELECT * FROM distinct_vehicle_list;

--2. Find the average ride distance for each vehicle type:
CREATE VIEW avg_ride_per_vehicle  AS
SELECT "Vehicle_Type",
       avg("Ride_Distance") AS avg_distance
FROM ola
GROUP BY "Vehicle_Type"
ORDER BY avg_distance 

SELECT * FROM avg_ride_per_vehicle

--3. Find the maximum and minimum driver ratings for Prime Sedan bookings.
CREATE VIEW rating_for_sedan AS
SELECT "Vehicle_Type",
       MAX("Driver_Ratings") AS max_rating_by_driver,
	   MIN("Driver_Ratings") AS min_rating_by_driver
FROM ola 
WHERE "Vehicle_Type" LIKE 'Prime Sedan'
GROUP BY "Vehicle_Type";

SELECT * FROM rating_for_sedan;

--4. Retrieve all rides where payment was made using UPI:
CREATE VIEW rides_by_upi AS
SELECT * 
FROM ola
WHERE "Payment_Method" LIKE 'UPI';

SELECT * FROM rides_by_upi;

--5. What are the ratings distribution for each vehicle type?
CREATE VIEW vehicle_rating_summary AS
SELECT "Vehicle_Type",
       COUNT(*) AS Total_Bookings,
       ROUND(AVG("Driver_Ratings")::numeric, 2) AS average_driver_rating,
       ROUND(AVG("Customer_Rating")::numeric, 2) AS average_customer_rating,
	   COUNT(CASE WHEN "Driver_Ratings">=4 THEN 1 END ) AS count_of_driver_rating_above_4,
	   COUNT(CASE WHEN "Customer_Rating">=4 THEN 1 END ) AS count_of_customer_rating_above_4,
	   COUNT(CASE WHEN "Driver_Ratings"<4 THEN 1 END ) AS count_of_driver_rating_below_4,
	   COUNT(CASE WHEN "Customer_Rating"<4 THEN 1 END ) AS count_of_customer_rating_below_4
FROM ola
GROUP BY "Vehicle_Type"
ORDER BY "Vehicle_Type";

SELECT * FROM vehicle_rating_summary;

--6. Which vehicle type has the highest frequency of cancellations?
CREATE VIEW most_cancelled_vehicle AS
SELECT "Vehicle_Type",
       COUNT(*) As count_of_cancellations
FROM ola 
WHERE "Booking_Status" like 'Canceled%'
GROUP BY "Vehicle_Type"
ORDER BY count_of_cancellations DESC
limit 1;

SELECT * FROM most_cancelled_vehicle;

------------------------------------------------------------------------------------------------------------------------------

--Distance and ride metrics

--1. Find the average ride distance for successful bookings.
CREATE VIEW  avg_sucess_bookingno AS
SELECT AVG("Ride_Distance") AS average_ride_distance 
FROM ola 
WHERE "Booking_Status"='Success';

SELECT * FROM avg_sucess_bookingno;

--2. What is the relationship between ride distance and booking value?
CREATE VIEW distance_value_correlation AS
SELECT CORR("Ride_Distance", "Booking_Value") AS correlation_coefficient
FROM ola
WHERE "Booking_Status" = 'Success';

SELECT * FROM distance_value_correlation;

------------------------------------------------------------------------------------------------------------------------------

--Payment Analysis

--1. Calculate the total revenue for rides with a Payment_Method of "Cash".
CREATE VIEW total_revenue_bycash AS
SELECT SUM("Booking_Value") AS Total_revenue_by_cash 
FROM ola 
WHERE "Payment_Method"='Cash';

SELECT * FROM total_revenue_bycash;

--2. What is the revenue contribution of each payment method?
CREATE VIEW payment_contribution AS
SELECT "Payment_Method",
       SUM("Booking_Value") AS Revenue_contribution
FROM ola
WHERE "Booking_Status" like 'Success'
GROUP BY "Payment_Method"
ORDER by Revenue_contribution;

SELECT * FROM payment_contribution;

-----------------------------------------------------------------------------------------------------------------------------

--Cancellation Insights

--1. Analyze the cancellation trends by determining the top reasons for cancellations by customers and drivers.
--FOR DRIVERS
CREATE VIEW rider_cancellation_reason AS
SELECT "Canceled_Rides_by_Driver",COUNT(*) AS frequency 
FROM ola
WHERE "Booking_Status"
like 'Canceled by Driver'
GROUP BY "Canceled_Rides_by_Driver"
ORDER BY COUNT(*) DESC;

SELECT * FROM rider_cancellation_reason;

--FOR CUSTOMERS
CREATE VIEW customer_cancellation_reason AS
SELECT "Canceled_Rides_by_Customer",count(*) AS frequency 
FROM ola 
WHERE "Booking_Status" 
LIKE 'Canceled by Customer'
GROUP BY "Canceled_Rides_by_Customer"
ORDER BY COUNT(*) DESC;

SELECT * FROM customer_cancellation_reason;

---2. Get the total number of cancelled rides by customers:
CREATE VIEW count_of_ride_cancelled_by_customer AS
SELECT COUNT(*) AS canceled_rides
FROM ola
WHERE "Booking_Status" LIKE 'Canceled by Customer';

SELECT * FROM count_of_ride_cancelled_by_customer;

---3. Get the number of rides cancelled by drivers due to personal and car-related issues:
CREATE VIEW canceled_by_driver_personel_car_issue AS
SELECT COUNT(*) AS cancelled_ride
FROM ola
WHERE "Booking_Status" LIKE 'Canceled by Driver'
AND "Canceled_Rides_by_Driver" LIKE 'Personal & Car related issue' ;

SELECT * FROM canceled_by_driver_personel_car_issue;

---4. Identify patterns in cancellations based on time of day.
CREATE VIEW cencellation_pattern_per_hour AS
SELECT EXTRACT(HOUR FROM "Time") AS dt,
       COUNT(*) AS cancelation_count
FROM ola
WHERE "Booking_Status" LIKE 'Canceled%'
GROUP BY EXTRACT(HOUR FROM "Time")
ORDER BY COUNT(*) DESC;

SELECT * FROM cencellation_pattern_per_hour;

---5. What is the impact of incomplete rides on total revenue?
CREATE VIEW incomplete_ride_revenue AS
SELECT SUM("Booking_Value") AS revenue_sum
FROM ola
WHERE "Booking_Status" LIKE 'Can%';

SELECT * FROM incomplete_ride_revenue;

-----------------------------------------------------------------------------------------------------------------------------

--Advanced Metrics

--1. Determine the correlation between Driver_Ratings and Customer_Rating for successful rides.
CREATE VIEW rating_corr AS
SELECT CORR("Driver_Ratings","Customer_Rating") as correlation_coefficient 
FROM ola 
WHERE "Booking_Status"='Success';

SELECT * FROM rating_corr;



