USE fetchdata;

CREATE TABLE users_data(
	user_id varchar(50) PRIMARY KEY,
	active bit NULL,
	created_date datetime NULL,
	last_login_date datetime NULL,
	user_role varchar(20) NULL,
	sign_up_source varchar(20) NULL,
	user_state char(2) NULL
);

BULK INSERT users_data
FROM 'C:\kathy\users_formatted.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM users_data;

CREATE TABLE receipts_main (
    receipt_id VARCHAR(50) PRIMARY KEY,                 
    bonus_points_earned DECIMAL NULL,
    bonus_points_earned_reason NVARCHAR(255) NULL,
    created_date datetime NULL,                
    scanned_date datetime NULL,                
    finished_date datetime NULL,          
    modify_date datetime NULL,            
    points_awarded_date datetime NULL,    
    points_earned FLOAT NULL,
    purchase_date datetime NULL,          
    purchased_item_count INT NULL,
    rewards_receipt_status VARCHAR(50) NOT NULL,
    total_spent DECIMAL(10, 2) NULL,
    user_id VARCHAR(50) NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users_data(user_id)
);

BULK INSERT receipts_main
FROM 'C:\kathy\receipts_formatted.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM receipts_main;

SELECT * FROM brands_data;
CREATE TABLE brands_data(
	brand_id varchar(50) NOT NULL,
	barcode varchar(50) PRIMARY KEY,
	category nvarchar(100) NULL,
	category_code nvarchar(100) NULL,
	cpg_id nvarchar(50) NOT NULL,
	cpg_ref varchar(50) NOT NULL,
	brand_name nvarchar(255) NOT NULL,
	top_brand bit NOT NULL,
	brand_code nvarchar(100) NULL
);

BULK INSERT brands_data
FROM 'C:\kathy\brand_formatted_numeric_csv1.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

CREATE TABLE receipt_items (
    barcode VARCHAR(50),
    item_description VARCHAR(255) NULL,
    finalPrice DECIMAL(10, 2) NULL,
    itemPrice DECIMAL(10, 2) NULL,
    needs_fetch_review BIT,
    partner_item_id INT,  
    prevent_target_gap_points BIT,
    quantity_purchased INT,
    user_flagged_barcode BIGINT NULL, 
    user_flagged_new_item BIT,
    user_flagged_price DECIMAL(10, 2) NULL,
    user_flagged_quantity INT NULL,
	receipt_id VARCHAR(50),
    FOREIGN KEY (receipt_id) REFERENCES receipts_main(receipt_id),
	FOREIGN KEY (barcode) REFERENCES brands_data(barcode)
);

BULK INSERT receipt_items
FROM 'C:\kathy\receipt_items_formatted.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM receipt_items; 

ALTER TABLE receipt_items
ADD receipt_item_id INT IDENTITY(1,1);

ALTER TABLE receipt_items
ADD CONSTRAINT PK_receipt_item_id PRIMARY KEY (receipt_item_id);
