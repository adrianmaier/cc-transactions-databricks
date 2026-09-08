/* 
    Bronze layer: Ingest raw transaction data from parquet files
    - Read from UC Volume using Auto Loader
    - Rename columns to lowercase with underscores as spaces are not allowed
    - Add metadata columns for tracking
*/

CREATE OR REFRESH STREAMING TABLE credit_card_project.bronze.transactions
AS
SELECT
    `User` AS user_id,
    `Card` AS card_id,
    `Year` AS year,
    `Month` AS month,
    `Day` AS day,
    `Time` AS time,
    `Amount` AS amount,
    `Use Chip` AS use_chip,
    `Merchant Name` AS merchant_name,
    `Merchant City` AS merchant_city,
    `Merchant State` AS merchant_state,
    `Zip` AS zip,
    `MCC` AS mcc,
    `Errors?` AS errors,
    `Is Fraud?` AS is_fraud,
    current_timestamp() AS ingestion_timestamp,
    _metadata.file_path AS source_file
FROM STREAM read_files(
    '/Volumes/credit_card_project/bronze/raw_data',
    format => 'parquet'
);
