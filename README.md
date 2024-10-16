# Fetch Rewards Coding Exercise - Analytics Engineer

## Overview
This repository contains the solution for the Fetch Rewards Coding Exercise. 
Demonstrated how to work with unstructured JSON data, transform it into a structured relational model, generate SQL queries to answer business questions, identify data quality issues, and communicate findings with stakeholders.

**Note**: The entire methodology and process followed for this exercise is thoroughly explained in the `methodology.docs` file. Please refer to that document for a detailed explanation of each step.

## Exercise Breakdown

### 1. Review Existing Unstructured Data and Diagram a New Structured Relational Data Model

- **Data Files**: Three JSON files are provided (`receipts.json`, `users.json`, `brands.json`).
- **Objective**: Review the structure of the JSON files and create a normalized relational model.
- **ER Diagram**: I created an ER diagram to represent the relational structure of the data, which includes the following tables:
  - **Users**: Contains user-specific information.
  - **Brands**: Contains brand-specific information.
  - **Receipts_main**: Contains general information about each receipt.
  - **Receipts_items**: Contains item-level data for each receipt, normalized from `rewardsReceiptItemList`.

The ER diagram can be found in the `diagrams` directory.

### 2. Data Ingestion Process

- **Python Script**: I used Python to process and transform the JSON files into CSVs. Specifically:
  - normalizer.ipynb file is used to split The `receipts.json` file into two json files (to Normalize receipts table) namely `receipts_main.json` and `receipts_items.json`.
  - dataformatter.ipynb file is used to format the datatypes, handle missing values.

The .pynb files and the input and output data files can be found in the `Question3_DataCleaning` directory.

### 3. Writing Queries to Answer Business Questions

- **Top 5 Brands by Receipts Scanned**: I wrote a SQL query to determine the top 5 brands based on the number of receipts scanned for the most recent month.
- **Comparison of Top Brands Between Two Months**: I generated a second query that compares the ranking of the top 5 brands from the most recent month with the previous month.
  
The SQL scripts for these queries are located in the `Question2_sql_queries` directory.

### 4. Evaluating Data Quality Issues

- **Data Quality Evaluation**: Using Python, I evaluated the dataset for potential issues such as:
  - Missing or `NULL` values.
  - Duplicates.
  - Inconsistent data formatting (e.g., date formats).
  - Presence of delimiters in data values.

The findings from this evaluation can be found in the `Question3_DataCleaning` directory, where I detail the issues discovered and steps taken to resolve them.

### 5. Communicating with Stakeholders

- **Business Message**: I drafted a concise message to a business stakeholder (such as a product manager), explaining the data model and the insights derived from the SQL queries. This demonstrates how I communicate technical details in an understandable way for non-technical stakeholders.

The draft message can be found in the `Question4_email` directory.

## Files and Directories

- **/Question1_ERdiagram**: Contains the ER diagram and schema visualizations.
- **/Question2_sql_queries**: Contains SQL scripts for answering business questions along with queries to create and import data. Also contains detailed documentation of the queries with explanations, outputs, and inferences.
- **/Question3_DataCleaning**: Contains the code used for data cleaning and data quality evaluation.
- **/Question4_email**: Contains the message for business stakeholders.

## Contact

If you have any questions or require further clarification on the submission, feel free to reach out to me kpaul23@wisc.edu.

