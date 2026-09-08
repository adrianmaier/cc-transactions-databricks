/*
    Bronze layer: Ingest prepared card data
    - Read Parquet from Unity Catalog Volume
    - user_id + card_id form the logical card key
    - Sensitive Card Number and CVV were excluded during preparation
    - Add ingestion metadata

** run the cards Streaming Table inside a Lakeflow Declarative Pipeline! **
*/

CREATE OR REFRESH STREAMING TABLE credit_card_project.bronze.cards
AS
SELECT
    CAST(user_id AS INT) AS user_id,
    CAST(card_id AS INT) AS card_id,
    card_brand,
    card_type,
    expires,
    has_chip,
    CAST(cards_issued AS TINYINT) AS cards_issued,
    credit_limit,
    acct_open_date,
    CAST(year_pin_last_changed AS SMALLINT) AS year_pin_last_changed,
    card_on_dark_web,
    current_timestamp() AS ingestion_timestamp,
    _metadata.file_path AS source_file

FROM STREAM read_files(
    '/Volumes/credit_card_project/bronze/raw_data/cards',
    format => 'parquet'
);
