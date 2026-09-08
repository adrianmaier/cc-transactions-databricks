/* 
    Cleaned data by:
    - renaming and type casting columns
    - adding derived columns
    - enforce: A transaction must be associated with a user and card
    - enforce: Every transaction needs a valid date/time
    - enforce: Every transaction needs a usable monetary value
    - enforce: The dataset provides a fraud label for each transaction
*/



CREATE OR REFRESH STREAMING TABLE credit_card_project.silver.cleaned_transactions
(
    CONSTRAINT valid_user_card
        EXPECT (user_id IS NOT NULL AND card_id IS NOT NULL),

    CONSTRAINT valid_timestamp
        EXPECT (transaction_timestamp IS NOT NULL),

    CONSTRAINT valid_amount
        EXPECT (amount IS NOT NULL),

    CONSTRAINT valid_fraud_flag
        EXPECT (is_fraud IS NOT NULL)
)
AS
SELECT
    user_id,
    card_id,
    CAST(year AS SMALLINT) AS transaction_year,
    CAST(month AS TINYINT) AS transaction_month,
    CAST(day AS TINYINT) AS transaction_day,
    TRIM(time) AS transaction_time,
    to_timestamp(
        concat(
            year, '-',
            lpad(month, 2, '0'), '-',
            lpad(day, 2, '0'), ' ',
            TRIM(time)
        )
    ) AS transaction_timestamp,
    CAST(
        REGEXP_REPLACE(amount, '[$,]', '')
        AS DECIMAL(18,2)
    ) AS amount,
    CASE
        WHEN CAST(
            REGEXP_REPLACE(amount, '[$,]', '')
            AS DECIMAL(18,2)
        ) < 0
        THEN TRUE
        ELSE FALSE
    END AS is_negative_amount,
    TRIM(use_chip) AS payment_method,
    merchant_name AS merchant_id,
    TRIM(merchant_city) AS merchant_city,
    NULLIF(TRIM(merchant_state), '') AS merchant_state,
    zip  AS merchant_zip,
    CAST(mcc AS INT) AS merchant_category_code,
    NULLIF(TRIM(errors), '') AS error,
    CASE
        WHEN LOWER(TRIM(is_fraud)) = 'yes' THEN TRUE
        WHEN LOWER(TRIM(is_fraud)) = 'no' THEN FALSE
        ELSE NULL
    END AS is_fraud,
    CASE
        WHEN LOWER(TRIM(use_chip)) LIKE '%online%'
            OR UPPER(TRIM(merchant_city)) = 'ONLINE'
        THEN TRUE
        ELSE FALSE
    END AS is_online,
    ingestion_timestamp,
    source_file

FROM STREAM(credit_card_project.bronze.transactions);


