-- Source: SQL documented in the submitted Power BI report.
-- Target: MySQL 8.0 or later. Configure the source table before running.

-- Appointment Summary by Day of Week 
SELECT
DAYNAME(AppointmentDay) AS Appointment_DayOfWeek,
WEEKDAY(AppointmentDay) AS DayIndex,
COUNT(AppointmentID) AS Total_Appointments,
COUNT(CASE WHEN No_show = 'Yes' THEN AppointmentID END) AS Total_NoShows,
ROUND(
COUNT(CASE WHEN No_show = 'Yes' THEN AppointmentID END) * 1.0
/ COUNT(AppointmentID),
4
) AS No_Show_Rate
FROM Appointment_No_Show.KaggleV2_May
GROUP BY
DAYNAME(AppointmentDay),
WEEKDAY(AppointmentDay)
ORDER BY
DayIndex;
