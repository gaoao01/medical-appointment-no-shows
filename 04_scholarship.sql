-- Source: SQL documented in the submitted Power BI report.
-- Target: MySQL 8.0 or later. Configure the source table before running.

-- Appointments by Scholarship
SELECT
CASE
WHEN Scholarship = 1 THEN 'Received Benefits'
ELSE 'No Benefits'
END AS Scholarship_Status,
COUNT(DISTINCT PatientId) AS Total_Patients,

COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN PatientId END) AS No_Show_Patients,

ROUND(
COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN PatientId END) * 1.0
/ COUNT(DISTINCT PatientId),
4
) AS Patient_No_Show_Rate,
COUNT(AppointmentID) AS Total_Appointments,
COUNT(CASE WHEN No_show = 'Yes' THEN AppointmentID END) AS Total_NoShows,
ROUND(
COUNT(CASE WHEN No_show = 'Yes' THEN AppointmentID END) * 1.0
/ COUNT(AppointmentID),
4
) AS No_Show_Rate
FROM Appointment_No_Show.KaggleV2_May
GROUP BY
Scholarship;
