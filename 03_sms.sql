-- Source: SQL documented in the submitted Power BI report.
-- Target: MySQL 8.0 or later. Configure the source table before running.

-- Appointments by SMS received 
SELECT
CASE
WHEN SMS_received = 1 THEN 'SMS Received'
ELSE 'No SMS'
END AS SMS_Status,
COUNT(AppointmentID) AS Total_Appointments,
COUNT(CASE WHEN No_show = 'Yes' THEN AppointmentID END) AS Total_NoShows,
ROUND(
COUNT(CASE WHEN No_show = 'Yes' THEN AppointmentID END) * 1.0
/ COUNT(AppointmentID),
4
) AS No_Show_Rate
FROM Appointment_No_Show.KaggleV2_May
GROUP BY
SMS_received;
