Power BI Report

The final analytical results are presented through a four-page Power BI report connected directly to the Databricks Gold layer.
The report is descriptive and focuses on user behavior, card behavior, merchant behavior, and the main evidence-based findings from the analytical workflow.
The interactive Power BI report is provided as credit_card_analytics.pbix.

1. User Behavior
The User Behavior page provides an overview of transaction volume, spending, user-level transaction activity, average transaction amounts, and the distribution of observed user fraud rates.

![User Behavior](./user%20behavior.png)

Key elements include:
- Total users
- Total transactions
- Total spend
- User transaction volume and spending
- Distribution of users across transaction-volume ranges
- Relationship between transaction volume and average transaction amount
- Distribution of observed user fraud rates
The visual analysis is descriptive and does not make causal or predictive claims.

2. Card Behavior
The Card Behavior page compares transaction activity, spending, average transaction amounts, and transaction-weighted fraud rates across card types.

![Card Behavior](./card%20behavior.png)

Key elements include:
- Total cards
- Total transactions
- Total spend
- Transaction volume and spending by card type
- Transaction-weighted average transaction amount
- Transaction-weighted fraud rate by card type
The card analysis uses the project's established aggregation logic. card_id is not interpreted as a unique physical-card identifier.

3. Merchant Behavior
The Merchant Behavior page examines transaction and spending concentration at the merchant level together with online merchant activity.

![Merchant Behavior](./merchant%20behavior.png)

Key elements include:
- Total merchants
- Total transactions
- Total spend
- Merchant transaction concentration
- Merchant spending concentration
- Online merchant activity
The merchant analysis does not interpret merchant_id as a physical geographic location. Merchant-level online activity is presented using transaction-weighted analysis rather than a simple average of merchant-level percentages.

4. Key Findings
The Key Findings page consolidates the strongest descriptive findings from the analytical workflow.

![Key Findings](./key%20findings.png)

The findings include:
- Concentration of transaction activity and spending across users and merchants
- Differences in transaction-weighted fraud rates across card types
- Concentration of online activity among merchants
- Higher recent historical fraud rates associated with observed fraudulent transactions at the user, card, and merchant levels
The historical fraud analysis is descriptive. Historical features are not presented as predictive models and no causal interpretation is made.

Power BI Deliverable

The interactive report is available as credit_card_analytics.pbix.
The report connects directly to the Databricks Gold layer. The underlying 24.4M-row transaction dataset is not stored in the repository.
The screenshots above are provided so that the analytical results can be reviewed directly from the GitHub project without requiring Power BI Desktop.
