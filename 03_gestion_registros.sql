-- ================================
-- 1. Duban.role
-- ================================
INSERT INTO Duban.role (name, description, status) VALUES ('ADMIN', 'Administrador del sistema', 'A');
INSERT INTO Duban.role (name, description, status) VALUES ('VENDEDOR', 'Gestión de ventas', 'A');
INSERT INTO Duban.role (name, description, status) VALUES ('LOGISTICO', 'Gestión logística', 'A');
INSERT INTO Duban.role (name, description, status) VALUES ('CLIENTE', 'Cliente registrado', 'A');
INSERT INTO Duban.role (name, description, status) VALUES ('AUDITOR', 'Revisión de operaciones', 'I');

-- ================================
-- 2. Duban.users
-- ================================
INSERT INTO Duban.users (first_name,last_name,username,hash_password,phone,email,document_type,document_num,date_registration,status,role_identifier)
VALUES ('Carlos','Ramirez','carlosr','password123','987654321','carlos@example.com','DNI','12345678',SYSDATE,'A',1);

INSERT INTO Duban.users (first_name,last_name,username,hash_password,phone,email,document_type,document_num,date_registration,status,role_identifier)
VALUES ('Ana','Lopez','analo','password123','987111222','ana@example.com','DNI','87654321',SYSDATE,'A',2);

INSERT INTO Duban.users (first_name,last_name,username,hash_password,phone,email,document_type,document_num,date_registration,status,role_identifier)
VALUES ('Luis','Perez','lperez','password123','999888777','luis@example.com','RUC','12345678901',SYSDATE,'A',3);

INSERT INTO Duban.users (first_name,last_name,username,hash_password,phone,email,document_type,document_num,date_registration,status,role_identifier)
VALUES ('Maria','Gomez','mgomez','password123','922333444','maria@example.com','DNI','11223344',SYSDATE,'A',4);

INSERT INTO Duban.users (first_name,last_name,username,hash_password,phone,email,document_type,document_num,date_registration,status,role_identifier)
VALUES ('Jorge','Castro','jcastro','password123','955666777','jorge@example.com','DNI','44332211',SYSDATE,'I',5);

-- ================================
-- 3. Luis.customer
-- ================================
INSERT INTO Luis.customer (type_customer,name,last_name,business_name,contact_name,phone,email,document_type,document_number,registration_date,status)
VALUES ('Natural','Pedro','Suarez',NULL,NULL,'999111222','pedro@example.com','DNI','56781234',SYSDATE,'A');

INSERT INTO Luis.customer (type_customer,name,last_name,business_name,contact_name,phone,email,document_type,document_number,registration_date,status)
VALUES ('Natural','Lucia','Torres',NULL,NULL,'988777444','lucia@example.com','DNI','87651234',SYSDATE,'A');

INSERT INTO Luis.customer (type_customer,name,last_name,business_name,contact_name,phone,email,document_type,document_number,registration_date,status)
VALUES ('Jurídico',NULL,NULL,'Tech Solutions SAC','Juan Perez','977888999','ventas@tech.com','RUC','20123456789',SYSDATE,'A');

INSERT INTO Luis.customer (type_customer,name,last_name,business_name,contact_name,phone,email,document_type,document_number,registration_date,status)
VALUES ('Natural','Diego','Martinez',NULL,NULL,'955444111','diego@example.com','DNI','99887766',SYSDATE,'A');

INSERT INTO Luis.customer (type_customer,name,last_name,business_name,contact_name,phone,email,document_type,document_number,registration_date,status)
VALUES ('Jurídico',NULL,NULL,'AgroImport SAC','Maria Lopez','944555666','contacto@agro.com','RUC','20987654321',SYSDATE,'I');

-- ================================
-- 4. Luis.address_customer
-- ================================
INSERT INTO Luis.address_customer (customer_identifier,street,number_address,reference,district,city,status)
VALUES (1,'Av. Siempre Viva','123','Frente al parque','Lima','Lima','A');

INSERT INTO Luis.address_customer (customer_identifier,street,number_address,reference,district,city,status)
VALUES (2,'Jr. Los Olivos','456','Cerca al colegio','Los Olivos','Lima','A');

INSERT INTO Luis.address_customer (customer_identifier,street,number_address,reference,district,city,status)
VALUES (3,'Av. Industrial','789','Altura Km 12','Ate','Lima','A');

INSERT INTO Luis.address_customer (customer_identifier,street,number_address,reference,district,city,status)
VALUES (4,'Calle Central','101','Costado del mercado','Comas','Lima','A');

INSERT INTO Luis.address_customer (customer_identifier,street,number_address,reference,district,city,status)
VALUES (5,'Av. Principal','202','Frente al estadio','San Miguel','Lima','I');

-- ================================
-- 5. Luis.order_status
-- ================================
INSERT INTO Luis.order_status (status,description,updated_at) VALUES ('P','Pendiente',SYSTIMESTAMP);
INSERT INTO Luis.order_status (status,description,updated_at) VALUES ('C','Completado',SYSTIMESTAMP);
INSERT INTO Luis.order_status (status,description,updated_at) VALUES ('X','Cancelado',SYSTIMESTAMP);
INSERT INTO Luis.order_status (status,description,updated_at) VALUES ('P','Pendiente de pago',SYSTIMESTAMP);
INSERT INTO Luis.order_status (status,description,updated_at) VALUES ('C','Confirmado',SYSTIMESTAMP);

-- ================================
-- 6. Luis.product_category
-- ================================
INSERT INTO Luis.product_category (name,description,status) VALUES ('Electrónica','Artículos electrónicos','A');
INSERT INTO Luis.product_category (name,description,status) VALUES ('Ropa','Prendas de vestir','A');
INSERT INTO Luis.product_category (name,description,status) VALUES ('Alimentos','Productos alimenticios','A');
INSERT INTO Luis.product_category (name,description,status) VALUES ('Muebles','Artículos de hogar','A');
INSERT INTO Luis.product_category (name,description,status) VALUES ('Libros','Material de lectura','I');

-- ================================
-- 7. Luis.products
-- ================================
INSERT INTO Luis.products (name,description,price,stock,unit_measure,status,category_identifier)
VALUES ('Laptop HP','Laptop 15 pulgadas',2500.00,10,'unidad','A',1);

INSERT INTO Luis.products (name,description,price,stock,unit_measure,status,category_identifier)
VALUES ('Camisa Azul','Camisa manga larga',80.00,50,'unidad','A',2);

INSERT INTO Luis.products (name,description,price,stock,unit_measure,status,category_identifier)
VALUES ('Arroz 5kg','Saco de arroz',25.00,100,'saco','A',3);

INSERT INTO Luis.products (name,description,price,stock,unit_measure,status,category_identifier)
VALUES ('Silla Madera','Silla comedor',120.00,20,'unidad','A',4);

INSERT INTO Luis.products (name,description,price,stock,unit_measure,status,category_identifier)
VALUES ('Libro SQL','Manual SQL',60.00,15,'unidad','I',5);

-- ================================
-- 8. Luis.orders
-- ================================
INSERT INTO Luis.orders (order_date,payment_method,comments,customer_identifier,order_status_identifier,users_identifier,total)
VALUES (SYSDATE,'EFECTIVO','Compra inicial',1,1,1,2600.00);

INSERT INTO Luis.orders (order_date,payment_method,comments,customer_identifier,order_status_identifier,users_identifier,total)
VALUES (SYSDATE,'TARJETA','Pedido online',2,2,2,100.00);

INSERT INTO Luis.orders (order_date,payment_method,comments,customer_identifier,order_status_identifier,users_identifier,total)
VALUES (SYSDATE,'TRANSFERENCIA','Pago bancario',3,1,3,500.00);

INSERT INTO Luis.orders (order_date,payment_method,comments,customer_identifier,order_status_identifier,users_identifier,total)
VALUES (SYSDATE,'YAPE','Pedido express',4,1,4,50.00);

INSERT INTO Luis.orders (order_date,payment_method,comments,customer_identifier,order_status_identifier,users_identifier,total)
VALUES (SYSDATE,'PLIN','Compra rápida',5,3,5,75.00);

-- ================================
-- 9. Luis.order_detail
-- ================================
INSERT INTO Luis.order_detail (products_identifier,quantity,subtotal,orders_identifier) VALUES (1,1,2500.00,1);
INSERT INTO Luis.order_detail (products_identifier,quantity,subtotal,orders_identifier) VALUES (2,1,80.00,1);
INSERT INTO Luis.order_detail (products_identifier,quantity,subtotal,orders_identifier) VALUES (3,2,50.00,2);
INSERT INTO Luis.order_detail (products_identifier,quantity,subtotal,orders_identifier) VALUES (4,1,120.00,3);
INSERT INTO Luis.order_detail (products_identifier,quantity,subtotal,orders_identifier) VALUES (5,1,60.00,4);

-- ================================
-- 10. Dayron.vehicle
-- ================================
INSERT INTO Dayron.vehicle (plate,vehicle_type,model,brand,purchase_date,capacity_kg,soat_expiration,last_maintenance_date,next_maintenance_date,status)
VALUES ('ABC-123','Camioneta','Hilux','Toyota',SYSDATE-1000,1000,SYSDATE+200,SYSDATE-30,SYSDATE+60,'A');

INSERT INTO Dayron.vehicle (plate,vehicle_type,model,brand,purchase_date,capacity_kg,soat_expiration,last_maintenance_date,next_maintenance_date,status)
VALUES ('XYZ-987','Furgón','Sprinter','Mercedes',SYSDATE-800,2000,SYSDATE+100,SYSDATE-60,SYSDATE+90,'A');

INSERT INTO Dayron.vehicle (plate,vehicle_type,model,brand,purchase_date,capacity_kg,soat_expiration,last_maintenance_date,next_maintenance_date,status)
VALUES ('QWE-456','Camión','FMX','Volvo',SYSDATE-1200,8000,SYSDATE+300,SYSDATE-90,SYSDATE+120,'A');

INSERT INTO Dayron.vehicle (plate,vehicle_type,model,brand,purchase_date,capacity_kg,soat_expiration,last_maintenance_date,next_maintenance_date,status)
VALUES ('JKL-321','Moto','XR150','Honda',SYSDATE-400,150,SYSDATE+150,SYSDATE-15,SYSDATE+45,'A');

INSERT INTO Dayron.vehicle (plate,vehicle_type,model,brand,purchase_date,capacity_kg,soat_expiration,last_maintenance_date,next_maintenance_date,status)
VALUES ('MNO-555','Camioneta','Ranger','Ford',SYSDATE-500,1200,SYSDATE+250,SYSDATE-20,SYSDATE+70,'I');

-- ================================
-- 11. Dayron.driver
-- ================================
INSERT INTO Dayron.driver (first_name,last_name,phone,document_number,entry_date,license_number,license_expiration,status,vehicle_identifier)
VALUES ('Jose','Quispe','987654123','44556677',SYSDATE-500,'B12345',SYSDATE+200,'A',1);

INSERT INTO Dayron.driver (first_name,last_name,phone,document_number,entry_date,license_number,license_expiration,status,vehicle_identifier)
VALUES ('Raul','Sanchez','912345678','55667788',SYSDATE-400,'C67890',SYSDATE+150,'A',2);

INSERT INTO Dayron.driver (first_name,last_name,phone,document_number,entry_date,license_number,license_expiration,status,vehicle_identifier)
VALUES ('Luis','Chavez','934567890','66778899',SYSDATE-300,'A12345',SYSDATE+100,'A',3);

INSERT INTO Dayron.driver (first_name,last_name,phone,document_number,entry_date,license_number,license_expiration,status,vehicle_identifier)
VALUES ('Marco','Diaz','945678901','77889900',SYSDATE-200,'B67890',SYSDATE+90,'A',4);

INSERT INTO Dayron.driver (first_name,last_name,phone,document_number,entry_date,license_number,license_expiration,status,vehicle_identifier)
VALUES ('Hugo','Rojas','956789012','88990011',SYSDATE-100,'C12345',SYSDATE+60,'I',5);

-- ================================
-- 12. Dayron.route
-- ================================
INSERT INTO Dayron.route (date_router,distance_km,estimated_time_min,real_time_min,status,driver_identifier)
VALUES (SYSDATE,15.5,30,35,'A',1);

INSERT INTO Dayron.route (date_router,distance_km,estimated_time_min,real_time_min,status,driver_identifier)
VALUES (SYSDATE,25.0,50,55,'P',2);

INSERT INTO Dayron.route (date_router,distance_km,estimated_time_min,real_time_min,status,driver_identifier)
VALUES (SYSDATE,40.0,80,85,'C',3);

INSERT INTO Dayron.route (date_router,distance_km,estimated_time_min,real_time_min,status,driver_identifier)
VALUES (SYSDATE,10.0,20,22,'F',4);

INSERT INTO Dayron.route (date_router,distance_km,estimated_time_min,real_time_min,status,driver_identifier)
VALUES (SYSDATE,60.0,120,125,'A',5);

-- ================================
-- 13. Dayron.delivery
-- ================================
INSERT INTO Dayron.delivery (route_identifier,delivery_datetime,status) VALUES (1,SYSTIMESTAMP,'A');
INSERT INTO Dayron.delivery (route_identifier,delivery_datetime,status) VALUES (2,SYSTIMESTAMP,'P');
INSERT INTO Dayron.delivery (route_identifier,delivery_datetime,status) VALUES (3,SYSTIMESTAMP,'C');
INSERT INTO Dayron.delivery (route_identifier,delivery_datetime,status) VALUES (4,SYSTIMESTAMP,'F');
INSERT INTO Dayron.delivery (route_identifier,delivery_datetime,status) VALUES (5,SYSTIMESTAMP,'A');

-- ==========================================
-- REVISIÓN DE DATOS - GREENDELIVERY
-- ==========================================

-- ================================
-- SCHEMA LUIS (Ventas)
-- ================================
SELECT * FROM Luis.customer;
SELECT * FROM Luis.address_customer;
SELECT * FROM Luis.product_category;
SELECT * FROM Luis.products;
SELECT * FROM Luis.order_status;
SELECT * FROM Luis.orders;
SELECT * FROM Luis.order_detail;

-- ================================
-- SCHEMA DUBAN (Administración)
-- ================================
SELECT * FROM Duban.role;
SELECT * FROM Duban.users;

-- ================================
-- SCHEMA DAYRON (Logística)
-- ================================
SELECT * FROM Dayron.vehicle;
SELECT * FROM Dayron.driver;
SELECT * FROM Dayron.route;
SELECT * FROM Dayron.delivery;
