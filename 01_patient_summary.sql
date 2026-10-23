-- Source: SQL documented in the submitted Power BI report.
-- Target: MySQL 8.0 or later. Configure the source table before running.

-- Create Master Patient Summary
CREATE OR REPLACE VIEW Appointment_No_Show.v_Patient_Summary AS
WITH PatientSummary AS (
SELECT
PatientId,
COUNT(DISTINCT AppointmentID) AS No_of_Appointments,
COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) AS No_of_NoShows,
ROUND(
COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) * 1.0
/ COUNT(DISTINCT AppointmentID),
4
) AS No_Show_Rate,
CASE
WHEN COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) >= 5 THEN '5+'
WHEN COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) = 4 THEN '4'
WHEN COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) = 3 THEN '3'
WHEN COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) = 2 THEN '2'
WHEN COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) = 1 THEN '1'
ELSE '0'
END AS No_Show_Group,
CASE
WHEN (COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) * 1.0 / COUNT(DISTINCT AppointmentID)) > 0.9 THEN '90%+'
WHEN (COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) * 1.0 / COUNT(DISTINCT AppointmentID)) > 0.6 THEN '(60%, 90%]'
WHEN (COUNT(DISTINCT CASE WHEN No_show = 'Yes' THEN AppointmentID END) * 1.0 / COUNT(DISTINCT AppointmentID)) > 0.3 THEN '(30%, 60%]'
ELSE '[0%, 30%]'
END AS No_Show_Rate_Group
FROM Appointment_No_Show.KaggleV2_May
GROUP BY PatientId
),
-- Add a new CTE to give a order for the patients' records
LatestPatientRecord AS (
SELECT
PatientId,
Gender,
Age,
Neighbourhood,
Scholarship,
Hipertension,
Diabetes,
Alcoholism,
Handcap,
ROW_NUMBER() OVER(PARTITION BY PatientId ORDER BY AppointmentDay DESC) AS rn
FROM Appointment_No_Show.KaggleV2_May
)
SELECT
p.PatientId,
r.Gender,
r.Age,
r.Neighbourhood,
r.Scholarship,
r.Hipertension,
r.Diabetes,
r.Alcoholism,
r.Handcap,
p.No_of_Appointments,
p.No_of_NoShows,
p.No_Show_Rate,
p.No_Show_Group,
p.No_Show_Rate_Group
FROM PatientSummary p
-- LEFT join two tables and set rn = 1 to get the latest record
LEFT JOIN LatestPatientRecord r
ON p.PatientId = r.PatientId
AND r.rn = 1;
