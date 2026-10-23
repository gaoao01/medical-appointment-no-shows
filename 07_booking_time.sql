-- Source: SQL documented in the submitted Power BI report.
-- Target: MySQL 8.0 or later. Configure the source table before running.

-- No-show outcomes by booking creation time (ScheduledDay)
-- Extract the hour (12th and 13th characters) from the ISO 8601 string and cast to integer for comparison
SELECT
CASE
WHEN CAST(SUBSTRING(ScheduledDay, 12, 2) AS SIGNED) < 12 THEN '1. Morning (< 12 PM)'
WHEN CAST(SUBSTRING(ScheduledDay, 12, 2) AS SIGNED) >= 12 AND CAST(SUBSTRING(ScheduledDay, 12, 2) AS SIGNED) < 18 THEN '2. Afternoon (12 PM - 6 PM)'
ELSE '3. Evening (>= 6 PM)'
END AS Time_Of_Day,
COUNT(DISTINCT AppointmentID) AS Total_Appointments,
COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) AS No_Show_Appointments,
ROUND(
COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) * 1.0
/ COUNT(DISTINCT AppointmentID),
4
) AS No_Show_Rate
FROM Appointment_No_Show.KaggleV2_May
GROUP BY Time_Of_Day
ORDER BY Time_Of_Day;
