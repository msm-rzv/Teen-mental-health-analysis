/*
================================================
  TEEN MENTAL HEALTH & SOCIAL MEDIA
  SQL Analysis Queries
  Tool: PostgreSQL
  Author: Masooma Rizvi
  Date: May 2025
================================================
*/


/*------------------------------------------------
  TABLE SETUP
------------------------------------------------*/

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

COPY "teen_mental_health"(age, gender, daily_social_media_hours, platform_usage,
    sleep_hours, screen_time_before_sleep, academic_performance,
    physical_activity, social_interaction_level, stress_level,
    anxiety_level, addiction_level, depression_label)
FROM '/your/path/Teen_Mental_Health_Dataset_Realistic.csv'
DELIMITER ','
CSV HEADER;


/*------------------------------------------------
  SUMMARY STATISTICS
  Overview of the full dataset
------------------------------------------------*/

SELECT
    COUNT(*) AS total_students,
    ROUND(AVG(age), 1) AS avg_age,
    ROUND(AVG(daily_social_media_hours), 2) AS avg_sm_hours,
    ROUND(AVG(sleep_hours), 2) AS avg_sleep_hours,
    ROUND(AVG(academic_performance), 2) AS avg_gpa,
    ROUND(AVG(depression_label) * 100, 1) AS depression_rate_pct
FROM "teen_mental_health";


/*------------------------------------------------
  SECTION 1 — SOCIAL MEDIA HABITS
------------------------------------------------*/

/* Q1. How does social media usage vary across age groups?
   Shows whether older or younger teens spend more time online */

SELECT
    age,
    ROUND(AVG(daily_social_media_hours), 2) AS avg_sm_hours
FROM "teen_mental_health"
GROUP BY age
ORDER BY age;


/* Q2. Does high social media usage correlate with higher anxiety, stress and addiction?
   Splits teens into usage groups and compares mental health scores (all on a 1-10 scale) */

SELECT
    CASE
        WHEN daily_social_media_hours >= 5 THEN 'High Usage (5h+)'
        WHEN daily_social_media_hours BETWEEN 3 AND 5 THEN 'Medium Usage (3-5h)'
        ELSE 'Low Usage (<3h)'
    END AS usage_group,
    ROUND(AVG(anxiety_level), 2) AS avg_anxiety,
    ROUND(AVG(stress_level), 2) AS avg_stress,
    ROUND(AVG(addiction_level), 2) AS avg_addiction
FROM "teen_mental_health"
GROUP BY usage_group
ORDER BY avg_anxiety DESC;


/*------------------------------------------------
  SECTION 2 — ACADEMIC & PHYSICAL IMPACT
------------------------------------------------*/

/* Q3. Does high social media usage affect academic performance?
   Compares average GPA across low, medium and high usage groups */

SELECT
    CASE
        WHEN daily_social_media_hours >= 5 THEN 'High Usage (5h+)'
        WHEN daily_social_media_hours BETWEEN 3 AND 5 THEN 'Medium Usage (3-5h)'
        ELSE 'Low Usage (<3h)'
    END AS usage_group,
    ROUND(AVG(academic_performance), 2) AS avg_gpa
FROM "teen_mental_health"
GROUP BY usage_group
ORDER BY avg_gpa DESC;


/* Q4. Does screen time before bed affect how much sleep teens get?
   Groups teens by bedtime screen habits and compares average sleep hours */

SELECT
    CASE
        WHEN screen_time_before_sleep < 1 THEN 'Minimal (<1h)'
        WHEN screen_time_before_sleep BETWEEN 1 AND 2 THEN 'Moderate (1-2h)'
        ELSE 'Heavy (>2h)'
    END AS bedtime_screen,
    ROUND(AVG(sleep_hours), 2) AS avg_sleep
FROM "teen_mental_health"
GROUP BY bedtime_screen
ORDER BY avg_sleep DESC;


/*------------------------------------------------
  SECTION 3 — MENTAL HEALTH OUTCOMES
------------------------------------------------*/

/* Q5. Do depressed teens have a higher connection to social apps?
   Compares social media hours, addiction and screen time
   between depressed and non-depressed teens */

SELECT
    depression_label,
    ROUND(AVG(daily_social_media_hours), 2) AS avg_sm_hours,
    ROUND(AVG(addiction_level), 2) AS avg_addiction,
    ROUND(AVG(screen_time_before_sleep), 2) AS avg_screen_before_bed
FROM "teen_mental_health"
GROUP BY depression_label
ORDER BY depression_label DESC;


/* Q6a. Does social media negatively affect real social interactions?
   Compares average social media hours by social interaction level */

SELECT
    social_interaction_level,
    ROUND(AVG(daily_social_media_hours), 2) AS avg_sm_hours
FROM "teen_mental_health"
GROUP BY social_interaction_level
ORDER BY avg_sm_hours DESC;


/* Q6b. Anxiety and stress by social interaction level (1-10 scale) */

SELECT
    social_interaction_level,
    ROUND(AVG(anxiety_level), 2) AS avg_anxiety,
    ROUND(AVG(stress_level), 2) AS avg_stress
FROM "teen_mental_health"
GROUP BY social_interaction_level
ORDER BY avg_anxiety DESC;


/* Q6c. Depression rate by social interaction level */

SELECT
    social_interaction_level,
    ROUND(AVG(depression_label) * 100, 1) AS depression_rate_pct
FROM "teen_mental_health"
GROUP BY social_interaction_level
ORDER BY depression_rate_pct DESC;


/* Q7. Does poor sleep combined with high social media use increase depression risk?
   Creates four risk profiles combining SM usage and sleep quality */

SELECT
    CASE
        WHEN daily_social_media_hours >= 5 AND sleep_hours < 6
            THEN 'High SM + Poor Sleep'
        WHEN daily_social_media_hours >= 5 AND sleep_hours >= 6
            THEN 'High SM + OK Sleep'
        WHEN daily_social_media_hours < 5 AND sleep_hours < 6
            THEN 'Low SM + Poor Sleep'
        ELSE 'Low SM + OK Sleep'
    END AS risk_profile,
    ROUND(AVG(depression_label) * 100, 1) AS depression_rate_pct
FROM "teen_mental_health"
GROUP BY risk_profile
ORDER BY depression_rate_pct DESC;


/*------------------------------------------------
  SECTION 4 — PROTECTIVE FACTORS
------------------------------------------------*/

/* Q8a. Does physical activity protect against depression?
   Compares depression rates across low, moderate and high activity levels */

SELECT
    CASE
        WHEN physical_activity < 1 THEN 'Low (<1h)'
        WHEN physical_activity BETWEEN 1 AND 2 THEN 'Moderate (1-2h)'
        ELSE 'High (>2h)'
    END AS activity_level,
    ROUND(AVG(depression_label) * 100, 1) AS depression_rate_pct
FROM "teen_mental_health"
GROUP BY activity_level
ORDER BY depression_rate_pct DESC;


/* Q8b. Anxiety and stress by activity level (1-10 scale) */

SELECT
    CASE
        WHEN physical_activity < 1 THEN 'Low (<1h)'
        WHEN physical_activity BETWEEN 1 AND 2 THEN 'Moderate (1-2h)'
        ELSE 'High (>2h)'
    END AS activity_level,
    ROUND(AVG(anxiety_level), 2) AS avg_anxiety,
    ROUND(AVG(stress_level), 2) AS avg_stress
FROM "teen_mental_health"
GROUP BY activity_level
ORDER BY avg_anxiety DESC;


/* Q9a. Addiction and anxiety by age (1-10 scale) */

SELECT
    age,
    ROUND(AVG(addiction_level), 2) AS avg_addiction,
    ROUND(AVG(anxiety_level), 2) AS avg_anxiety
FROM "teen_mental_health"
GROUP BY age
ORDER BY age;


/* Q9b. Depression rate by age */

SELECT
    age,
    ROUND(AVG(depression_label) * 100, 1) AS depression_rate_pct
FROM "teen_mental_health"
GROUP BY age
ORDER BY age;
