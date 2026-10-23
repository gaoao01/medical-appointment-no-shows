# Dataset source

Dataset: **Medical Appointment No Shows**.

Publisher account: **joniarroba** on Kaggle.

Source: https://www.kaggle.com/datasets/joniarroba/noshowappointments

Download the CSV from the source page. Refer to the source page for the dataset description, current attribution requirements, and usage terms. No new license is assigned to the dataset by this repository. The original CSV is omitted as a separate file, but the Power BI report contains imported data.

The CSV uses `No-show`, where `Yes` means the appointment was missed and `No` means it was attended. The documented MySQL queries use the renamed field `No_show`.

The source field spellings `Hipertension` and `Handcap` are retained in SQL for compatibility. Use clear display labels in the report and check the source definitions before interpreting categories.

This repository contains a transformed analysis and a report, not a new collection of patient records. Do not add private patient data, a private employer dataset, database passwords, or Kaggle API credentials.
