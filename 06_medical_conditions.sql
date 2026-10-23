-- Source: SQL documented in the submitted Power BI report.
-- Target: MySQL 8.0 or later. Configure the source table before running.

-- Appointments by Medical Conditions (Unpivoted for Visualization)
WITH ConditionUnpivot AS (
SELECT PatientId, AppointmentID, No_show, 'Hipertension' AS Condition_Type
FROM Appointment_No_Show.KaggleV2_May WHERE Hipertension = 1
UNION ALL
SELECT PatientId, AppointmentID, No_show, 'Diabetes' AS Condition_Type
FROM Appointment_No_Show.KaggleV2_May WHERE Diabetes = 1
UNION ALL
SELECT PatientId, AppointmentID, No_show, 'Alcoholism' AS Condition_Type
FROM Appointment_No_Show.KaggleV2_May WHERE Alcoholism = 1
UNION ALL
SELECT PatientId, AppointmentID, No_show, 'Handcap' AS Condition_Type
FROM Appointment_No_Show.KaggleV2_May WHERE Handcap = 1
)

SELECT
Condition_Type,
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
FROM ConditionUnpivot
GROUP BY Condition_Type
ORDER BY Total_Patients DESC;
