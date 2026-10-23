-- Optional validation queries added for the portfolio package.
-- Run against the imported source table before interpreting results.
SELECT
    COUNT(*) AS Row_Count,
    COUNT(DISTINCT AppointmentID) AS Unique_Appointments,
    COUNT(DISTINCT PatientId) AS Unique_Patients,
    SUM(CASE WHEN AppointmentID IS NULL THEN 1 ELSE 0 END) AS Missing_Appointment_IDs,
    SUM(CASE WHEN PatientId IS NULL THEN 1 ELSE 0 END) AS Missing_Patient_IDs,
    SUM(CASE WHEN No_show = 'Yes' THEN 1 ELSE 0 END) AS Missed_Appointment_Rows
FROM Appointment_No_Show.KaggleV2_May;

SELECT AppointmentID, COUNT(*) AS Duplicate_Count
FROM Appointment_No_Show.KaggleV2_May
GROUP BY AppointmentID
HAVING COUNT(*) > 1;

SELECT No_show, COUNT(*) AS Row_Count
FROM Appointment_No_Show.KaggleV2_May
GROUP BY No_show;

SELECT MIN(Age) AS Minimum_Age, MAX(Age) AS Maximum_Age
FROM Appointment_No_Show.KaggleV2_May;

SELECT Handcap, COUNT(*) AS Row_Count
FROM Appointment_No_Show.KaggleV2_May
GROUP BY Handcap
ORDER BY Handcap;

SELECT COUNT(*) AS Zero_NoShow_Patients
FROM Appointment_No_Show.v_Patient_Summary
WHERE No_of_NoShows = 0;
-- The last check describes the all-patient SQL view. A no-show-only report
-- table must separately filter No_of_NoShows > 0.
