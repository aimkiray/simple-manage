CREATE TABLE user
(
  user_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  user_name VARCHAR(100),
  user_password VARCHAR(100),
  email VARCHAR(100)
);
CREATE UNIQUE INDEX user_user_id_uindex ON user (user_id);

CREATE TABLE customer
(
  id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  name VARCHAR(100),
  email VARCHAR(100),
  tax VARCHAR(25),
  phone VARCHAR(15),
  site VARCHAR(100)
);
CREATE UNIQUE INDEX customer_id_uindex ON customer (id);