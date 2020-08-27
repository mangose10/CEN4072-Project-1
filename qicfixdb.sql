drop database qicfixdb;

create database qicfixdb;

use qicfixdb;

CREATE TABLE user_type(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE user(
  email VARCHAR(100) PRIMARY KEY,
  user_type_id INT NOT NULL,
  password VARCHAR(15) NOT NULL,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  phone VARCHAR(25),
  street_address VARCHAR(255),
  city VARCHAR(255),
  state VARCHAR(255),
  zipcode VARCHAR(15),
  dob DATETIME,
  blocked VARCHAR(100),
  CONSTRAINT fk_user_type_id_user FOREIGN KEY (user_type_id) REFERENCES user_type (id)
);

CREATE TABLE application(
  id INT PRIMARY KEY,
  name VARCHAR(255),
  url VARCHAR (255)
);

CREATE TABLE has_permission(
  user_type_id INT,
  application_id INT,
  PRIMARY KEY(user_type_id, application_id)
);

CREATE TABLE client(
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(100),
  CONSTRAINT fk_email_client FOREIGN KEY (email) REFERENCES user (email)
);

CREATE TABLE tower(
  id INT AUTO_INCREMENT PRIMARY KEY,
  company_name VARCHAR(100),
  email VARCHAR(100),
  permit_number VARCHAR(100),
  latitude DOUBLE,
  longitude DOUBLE,
  price_mile DOUBLE,
  CONSTRAINT fk_email_tower FOREIGN KEY (email) REFERENCES user (email)
);

CREATE TABLE service(
  id INT AUTO_INCREMENT PRIMARY KEY,
  client_id INT NOT NULL,
  creation_date TIMESTAMP,
  start_date DATETIME,
  end_date DATETIME,
  cancel_date DATETIME,
  cost DOUBLE,
  latitude_pickup DOUBLE,
  longitude_pickup DOUBLE,
  latitude_destination DOUBLE,
  longitude_destination DOUBLE,
  street_address_pickup VARCHAR(255),
  city_pickup VARCHAR(255),
  state_pickup VARCHAR(15),
  zipcode_pickup VARCHAR(15),
  street_address_destination VARCHAR(255),
  city_destination VARCHAR(255),
  state_destination VARCHAR(15),
  zipcode_destination VARCHAR(15),
  client_description VARCHAR(1000),
  tower_description VARCHAR(1000),
  CONSTRAINT fk_client_id_service FOREIGN KEY (client_id) REFERENCES client (id)
);

CREATE TABLE has_tower(
  service_id INT,
  tower_id INT,
  client_aprroved_date DATETIME,
  tower_accept_date DATETIME,
  tower_decline_date DATETIME,
  client_rating INT,
  client_comment VARCHAR(255),
  tower_rating INT,
  tower_comment VARCHAR(255),
  PRIMARY KEY (service_id, tower_id),
  CONSTRAINT fk_service_id_has_tower FOREIGN KEY (service_id) REFERENCES service (id),
  CONSTRAINT fk_tower_id_has_tower FOREIGN KEY (tower_id) REFERENCES tower (id)
);

CREATE TABLE payment(
  id INT AUTO_INCREMENT PRIMARY KEY,
  service_id INT,
  date DATETIME,
  amount DOUBLE,
  credit_card_last VARCHAR(4),
  paypal_autho VARCHAR(255),
  CONSTRAINT fk_service_id_payment FOREIGN KEY (service_id) REFERENCES service (id)
);

INSERT INTO user_type (name) VALUES ('client');
INSERT INTO user_type (name) VALUES ('tower');

INSERT INTO user (email, password, fname, lname, user_type_id) VALUES ('user1@email.com', 'user1', 'Freny', 'Patel', 1);
INSERT INTO user (email, password, fname, lname, user_type_id) VALUES ('user2@email.com', 'user2', 'Anjli', 'Chhatwani', 2);
INSERT INTO user (email, password, fname, lname, user_type_id) VALUES ('user3@email.com', 'user3', 'Dionny', 'Santiago', 2);
INSERT INTO user (email, password, fname, lname, user_type_id) VALUES ('user4@email.com', 'user4', 'Steve', 'Foo', 1);
INSERT INTO user (email, password, fname, lname, user_type_id) VALUES ('user5@email.com', 'user5', 'Maral', 'Kargar', 1);
INSERT INTO user (email, password, fname, lname, user_type_id) VALUES ('user6@email.com', 'user6', 'Gregory', 'Jean-Baptiste', 2);

INSERT INTO client (email) VALUES ('user1@email.com');

INSERT INTO tower (email, latitude, longitude, price_mile) VALUES ('user2@email.com', 25.770083, -80.339905, 20);
INSERT INTO tower (email, latitude, longitude, price_mile) VALUES ('user3@email.com', 25.701735, -80.345054, 5);

INSERT INTO service (client_id, tower_description, start_date, end_date, cost, street_address_pickup, city_pickup, state_pickup, zipcode_pickup, client_description, latitude_pickup, longitude_pickup, latitude_destination, longitude_destination, street_address_destination, city_destination, state_destination, zipcode_destination) VALUES (1,'The car was delivered', '2016-02-05', '2016-02-05', 80.00, '11200 SW 8th St', 'Miami', 'FL', '33199', 'Near ECS Building', 25.759361, -80.373731, 25.694021, -80.310819, '8250 SW 72nd Ct', 'Miami', 'FL', '33199');

INSERT INTO service (client_id, tower_description, start_date, end_date, cost, street_address_pickup, city_pickup, state_pickup, zipcode_pickup, client_description, latitude_pickup, longitude_pickup, latitude_destination, longitude_destination, street_address_destination, city_destination, state_destination, zipcode_destination) VALUES (1,'The car was delivered', '2016-02-05', '2016-02-05', 80.00, '11200 SW 8th St', 'Miami', 'FL', '33199', 'Near ECS Building', 25.759361, -80.373731, 25.694022, -80.310819, '8251 SW 72nd Ave', 'Miami', 'FL', '33143');

INSERT INTO service (client_id, tower_description, start_date, end_date, cost, street_address_pickup, city_pickup, state_pickup, zipcode_pickup, client_description, latitude_pickup, longitude_pickup, latitude_destination, longitude_destination, street_address_destination, city_destination, state_destination, zipcode_destination) VALUES (1,'', '2016-02-05', '2016-02-05', 80.00, '11200 SW 8th St', 'Miami', 'FL', '33199', 'Near ECS Building', 25.759361, -80.373731, 25.694023, -80.310819, '8252 SW 72nd St', 'Miami', 'FL', '33143');

INSERT INTO has_tower (service_id, tower_id, client_aprroved_date, tower_accept_date) VALUES (1, 1, '2016-02-05', '2016-02-05');
INSERT INTO has_tower (service_id, tower_id, client_aprroved_date) VALUES (1, 2, '2016-02-05');

INSERT INTO has_tower (service_id, tower_id, client_aprroved_date) VALUES (2, 1, '2016-02-05');
INSERT INTO has_tower (service_id, tower_id, client_aprroved_date) VALUES (2, 2, '2016-02-05');

INSERT INTO has_tower (service_id, tower_id, client_aprroved_date) VALUES (3, 1, '2016-02-05');
INSERT INTO has_tower (service_id, tower_id, client_aprroved_date) VALUES (3, 2, '2016-02-05');

INSERT INTO application (id, name, url) VALUES (1, 'Profile', 'profileClient.jsp');
INSERT INTO application (id, name, url) VALUES (2, 'Profile', 'profileTower.jsp');
INSERT INTO application (id, name, url) VALUES (3, 'Request Service', 'requestService.jsp');
INSERT INTO application (id, name, url) VALUES (4, 'List Tower', 'listTower.jsp');
INSERT INTO application (id, name, url) VALUES (5, 'List Services', 'listService.jsp');
INSERT INTO application (id, name, url) VALUES (6, 'List Available Services', 'listAvailableService.jsp');
INSERT INTO application (id, name, url) VALUES (7, 'List Active Service', 'listActiveService.jsp');
INSERT INTO application (id, name, url) VALUES (8, 'List Finished Services', 'listFinishService.jsp');

INSERT INTO has_permission (user_type_id, application_id) VALUES (1,1);
INSERT INTO has_permission (user_type_id, application_id) VALUES (1,3);
INSERT INTO has_permission (user_type_id, application_id) VALUES (1,4);
INSERT INTO has_permission (user_type_id, application_id) VALUES (1,5);
INSERT INTO has_permission (user_type_id, application_id) VALUES (2,2);
INSERT INTO has_permission (user_type_id, application_id) VALUES (2,6);
INSERT INTO has_permission (user_type_id, application_id) VALUES (2,7);
INSERT INTO has_permission (user_type_id, application_id) VALUES (2,8);
