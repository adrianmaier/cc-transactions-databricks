/*
    Bronze layer: Ingest prepared user data
    - Read Parquet from Unity Catalog Volume
    - user_id was created from the documented source row position
    - Add ingestion metadata


    ** run the users Streaming Table inside a Lakeflow Declarative Pipeline! **
*/

CREATE OR REFRESH STREAMING TABLE credit_card_project.bronze.users
AS
SELECT
    user_id,
    person,
    CAST(current_age AS SMALLINT) AS current_age,
    CAST(retirement_age AS SMALLINT) AS retirement_age,
    CAST(birth_year AS SMALLINT) AS birth_year,
    CAST(birth_month AS TINYINT) AS birth_month,
    gender,
    address,
    apartment,
    city,
    state,
    zipcode,
    CAST(latitude AS DECIMAL(8,5)) AS latitude,
    CAST(longitude AS DECIMAL(8,5)) AS longitude,
    per_capita_income,
    yearly_income,
    total_debt,
    CAST(fico_score AS SMALLINT) AS fico_score,
    CAST(num_credit_cards AS TINYINT) AS num_credit_cards,
    current_timestamp() AS ingestion_timestamp,
    _metadata.file_path AS source_file

FROM STREAM read_files(
    '/Volumes/credit_card_project/bronze/raw_data/users',
    format => 'parquet'
);
