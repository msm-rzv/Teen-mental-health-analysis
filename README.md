# Teen Mental Health & Social Media
### A Data Analysis Case Study

> *How does social media usage impact the development of teenagers, and what can schools and parents do about it?*

---

## Overview

This project analyses a dataset of **1,200 teenagers aged 13–19** to explore whether social media usage is associated with measurable changes in anxiety, stress, academic performance, sleep, and depression. The goal is not only to identify patterns but to draw conclusions that could inform practical action by parents, schools, and policymakers.

| | |
|---|---|
| **Dataset** | 1,200 students, 13 variables |
| **Tools** | PostgreSQL, Power BI |
| **Language** | SQL |
| **Duration** | May 2025 |

---

## The Average Teen in This Dataset

| Metric | Value |
|---|---|
| Average Age | 15.9 years |
| Social Media Hours / Day | 4.02 hours |
| Sleep Hours / Night | 7.38 hours |
| Screen Time Before Bed | 1.72 hours |
| Average GPA | 3.91 / 4.0 |
| Depression Rate | 17.6% |

---

## Key Findings

- **Social media use doubles with age** — from 2.61h/day at 13 to 5.52h/day at 19, with depression rates nearly tripling over the same period
- **High users have double the anxiety** — teens using 5h+ score 3.13 on anxiety vs 1.55 for low users (out of 10)
- **Screen time steals sleep** — heavy bedtime screen users lose 1.49 hours of sleep per night compared to minimal users
- **Grades decline with usage** — high users average a GPA of 3.79 vs 3.99 for low users
- **The highest risk combination** — teens with high social media use AND poor sleep have a 42.9% depression rate, more than three times the 13.4% baseline
- **Exercise nearly halves depression risk** — from 29.7% for inactive teens to 15.1% for active ones

---

## Repository Structure

```
├── README.md
├── queries.sql                              # All SQL queries used in the analysis
├── Teen_Mental_Health_Dataset_Realistic.csv # Dataset
└── Teen_Mental_Health_Case_Study_Final.pdf  # Full written report
```

---

## How to Run the Queries

### Prerequisites
- PostgreSQL installed (version 14+)
- pgAdmin or any SQL client

### Setup

**1. Create the database and table**
```sql
CREATE DATABASE teen_mental_health;

CREATE TABLE "teen_mental_health" (
    id SERIAL PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    daily_social_media_hours NUMERIC(4,1),
    platform_usage VARCHAR(20),
    sleep_hours NUMERIC(4,1),
    screen_time_before_sleep NUMERIC(4,1),
    academic_performance NUMERIC(4,2),
    physical_activity NUMERIC(4,1),
    social_interaction_level VARCHAR(10),
    stress_level INT,
    anxiety_level INT,
    addiction_level INT,
    depression_label INT
);
```

**2. Import the CSV**
```sql
COPY "teen_mental_health"(age, gender, daily_social_media_hours, platform_usage,
    sleep_hours, screen_time_before_sleep, academic_performance,
    physical_activity, social_interaction_level, stress_level,
    anxiety_level, addiction_level, depression_label)
FROM '/your/path/Teen_Mental_Health_Dataset_Realistic.csv'
DELIMITER ','
CSV HEADER;
```

**3. Run the queries**

Open `queries.sql` in pgAdmin and run each query individually by highlighting it and pressing **F5**.

---

## Analysis Structure

The analysis is divided into four sections:

**Section 1 — Social Media Habits**
- How does usage vary across age groups?
- Does high usage correlate with higher anxiety, stress, and addiction?

**Section 2 — Academic & Physical Impact**
- Does high usage affect academic performance?
- Does screen time before bed affect sleep?

**Section 3 — Mental Health Outcomes**
- Do depressed teens show higher social media engagement?
- Does poor sleep combined with high usage increase depression risk?

**Section 4 — Protective Factors**
- Does physical activity protect against depression?
- Are younger or older teens more vulnerable?

---

## Recommendations

| Intervention | Evidence | Approach |
|---|---|---|
| **Reduce social media use** | Anxiety doubles from low to high usage | Phone-free school hours for younger teens; data-led conversations for older teens |
| **Improve sleep** | Depression rate drops 3× with healthy sleep | No screens 1h before bed; frame sleep as a performance tool for older teens |
| **Increase physical activity** | Active teens have 49% lower depression rate | Mandatory PE for younger teens; social sports for older teens |

---

## Note on Correlation vs Causation

This study demonstrates **correlation, not causation**. The data cannot prove that social media directly causes depression or anxiety — only that they consistently appear together. The patterns are strong enough across every metric to warrant serious attention, but should be interpreted with appropriate caution.

---

## Full Report

The complete case study — including the data dictionary, all SQL queries with results tables, written interpretations, and dashboard screenshots — is available as a PDF in this repository.

---

*© 2026 Masooma Rizvi*
