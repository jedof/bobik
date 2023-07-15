-- Active: 1686116508594@@127.0.0.1@3306
CREATE TABLE users (
  user_id INTEGER, 
  first_name text NOT NULL, 
  last_name TEXT, 
  user_name TEXT, 
  level_id INTEGER REFERENCES levels (level_id) ON DELETE CASCADE, 
  job_id INTEGER REFERENCES jobs (job_id) ON DELETE CASCADE,
  balance INTEGER
);
CREATE TABLE categories (
  category_id INTEGER PRIMARY key, 
  category_name VARCHAR(255), 
  category_path VARCHAR(255)
);
CREATE TABLE products (
  product_id INTEGER PRIMARY key, 
  product_name VARCHAR(255), 
  category_id INTEGER REFERENCES categories (category_id) ON DELETE 
  SET 
    NULL
);
CREATE TABLE product_attributes (
  attribute_id INTEGER PRIMARY KEY, 
  attribute_name VARCHAR(255), 
  product_id INTEGER REFERENCES products (product_id) ON DELETE CASCADE, 
  attribute_value VARCHAR(255)
);
CREATE TABLE product_sizes (
  size_id INTEGER PRIMARY KEY, 
  size_name VARCHAR(255), 
  product_id INTEGER REFERENCES products (product_id) ON DELETE CASCADE, 
  price INTEGER
);
CREATE TABLE restaurants (
  restaurant_id INTEGER PRIMARY KEY, 
  restaurant_name VARCHAR(255)
);
CREATE TABLE food_categories(
  category_id INTEGER PRIMARY KEY, 
  category_name VARCHAR(255)
);
CREATE TABLE restaurant_menu (
  position_id INTEGER PRIMARY KEY, 
  restaurant_id INTEGER REFERENCES restaurants (restaurant_id) ON DELETE CASCADE, 
  food_category_id INTEGER REFERENCES food_categories (category_id) ON DELETE 
  SET 
    NULL, 
    position_name VARCHAR(255), 
    position_size VARCHAR(255), 
    position_calories INTEGER, 
    position_price INTEGER
);
CREATE TABLE ingredients (
  ingredient_id INTEGER PRIMARY KEY, 
  ingredient_name VARCHAR(255)
);
CREATE TABLE compositions (
  composition_id INTEGER PRIMARY KEY, 
  position_id INTEGER REFERENCES restaurant_menu (position_id) ON DELETE CASCADE, 
  ingredient_id INTEGER REFERENCES ingredients (ingredient_id) ON DELETE CASCADE
);
CREATE TABLE levels (
  level_id INTEGER PRIMARY KEY, level_number INTEGER, 
  level_entry_score INTEGER
);
CREATE TABLE jobs (
  job_id INTEGER PRIMARY KEY, 
  job_name VARCHAR(255), 
  job_description VARCHAR(255), 
  job_salary INTEGER
);
CREATE TABLE jobs_levels (
  id INTEGER PRIMARY KEY, 
  level_id INTEGER REFERENCES levels (level_id) ON DELETE CASCADE, 
  job_id INTEGER REFERENCES jobs (job_id) ON DELETE CASCADE
);

CREATE TABLE player_attributes (
  attribute_id INTEGER PRIMARY KEY,
  user_id INTEGER REFERENCES users (user_id) ON DELETE CASCADE,
  balance INTEGER DEFAULT 0,
  score INTEGER DEFAULT 0,
  food INTEGER DEFAULT 2100,
  stamina INTEGER DEFAULT 100
);

ALTER TABLE users drop COLUMN score;

ALTER TABLE users ADD score INTEGER;
ALTER TABLE levels RENAME COLUMN level_entry_score to next_level_entry_score;

SELECT u.user_name, u.balance, u.job_id, u.level_id, j.job_name, j.job_salary FROM users u LEFT JOIN jobs j ON u.job_id = j.job_id;
SELECT 
	u.user_name, 
    u.balance, u.job_id, u.level_id, u.score, l.level_number as level, l.next_level_entry_score, (l.next_level_entry_score - u.score) as to_level 
FROM 
	users u 
LEFT JOIN levels l ON 
	u.level_id = l.level_id;

SELECT DISTINCT fc.category_name
FROM restaurant_menu rm
LEFT JOIN food_categories fc ON rm.food_category_id = fc.category_id
LEFT JOIN restaurants r ON rm.restaurant_id = r.restaurant_id
WHERE r.restaurant_name = "Бургер и запятая";