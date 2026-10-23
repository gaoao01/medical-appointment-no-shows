# Medical Appointment No Show Analysis

An independent Power BI and MySQL portfolio project exploring missed medical appointments in a public Kaggle dataset. The report combines appointment-level analysis with patient summaries to support questions about appointment capacity and patient follow-up.

**Tools:** Power BI Desktop, MySQL, SQL.

**Project type:** Exploratory analysis and dashboard design. The report has not been deployed in a healthcare organization, and no operational improvement is claimed.

**Latest report update:** 23 October 2026. See the [change log](CHANGELOG.md).

## Open the report

Download [Medical_Appointment_No_Shows.pbix](powerbi/Medical_Appointment_No_Shows.pbix) and open it in Power BI Desktop. The saved report contains imported data. Refreshing it requires configuring your own data sources; the author's local database is not provided.

For a quick review, start with **Overview Page 1**, then explore **Overview Page 2**, **Patient Detail & Follow-up**, and **Insights & Actions**. SQL documentation and a profile tooltip page are also included.

## Business questions

- Which weekdays and neighborhoods have more missed appointments, and how do their rates compare?
- How do attendance patterns differ by SMS status, booking time, scholarship status, and recorded medical condition?
- Which patients have repeated missed appointments, and how much appointment history supports that finding?
- What further analysis or small pilot could test a useful follow-up action?

## What I built

- Two overview pages with appointment and patient indicators, counts, rates, and demographic breakdowns.
- A neighborhood scatter chart combining appointment volume, missed appointments, and the no-show rate.
- Patient detail drillthrough and profile tooltips for investigation.
- SQL patient summaries using common table expressions (CTEs: named query steps) and `ROW_NUMBER()` to select a recent patient record.
- Medical-condition summaries using `UNION ALL` to place the condition columns into a common category structure.
- Separate appointment-based and patient-based measures, with definitions and limitations documented.

## Selected findings

Rounded values in the saved report indicate a higher observed no-show rate in the SMS group (about 28%) than the group without SMS (about 17%). This comparison does not establish that SMS reminders are ineffective; the groups may differ in other ways.

The report also indicates rates of about 22% for afternoon and evening bookings, compared with about 19% for morning bookings. These are **booking creation times**, not visit times. The appointment timestamps do not contain useful within-day visit times.

High neighborhood counts need to be considered alongside booking demand. A patient with one missed appointment out of one booking has a 100% personal no-show rate, which should not be interpreted in the same way as repeated missed appointments over a longer history.

These figures describe the saved report's findings and may change with filters. They are not independently reproduced by the SQL files in this package.

## Metric definitions

| Metric | Definition |
| --- | --- |
| Total appointments | Appointment count; use unique AppointmentID values if duplicate source rows exist |
| Missed appointments | Appointments with `No_show = 'Yes'` |
| Appointment no-show rate | Missed appointments / total appointments |
| No-show patients | Unique patients with at least one missed appointment in the study period |
| Patients with a missed appointment (%) | No-show patients / unique patients in the relevant group |
| Personal no-show rate | A patient's missed appointments / that patient's total appointments |

## Repository contents

| Path | Contents |
| --- | --- |
| `powerbi/` | The submitted Power BI report, renamed for sharing |
| `sql/` | Seven documented analysis queries and additional data checks |
| `docs/SETUP.md` | Data preparation, report refresh, and query-to-table mapping |
| `docs/METRICS_AND_LIMITATIONS.md` | Calculation levels, assumptions, and interpretation limits |
| `docs/INSIGHTS_AND_ACTIONS.md` | The report's insights text in a readable format |
| `docs/SCREENSHOTS.md` | How to add genuine report screenshots to this page |
| `data/README.md` | Dataset source and field naming notes |

## Data and scope

Source: [Medical Appointment No Shows by joniarroba on Kaggle](https://www.kaggle.com/datasets/joniarroba/noshowappointments).

The original CSV is not included as a separate repository file. The PBIX contains imported data and therefore also redistributes dataset content. Credit and usage terms remain with the original source; this repository does not relicense the dataset. See [data notes](data/README.md).

This is a personal portfolio project using historical public data. It is not associated with a healthcare employer. The analysis supports further investigation; it is not a validated prediction model or a basis for automatic booking restrictions.
