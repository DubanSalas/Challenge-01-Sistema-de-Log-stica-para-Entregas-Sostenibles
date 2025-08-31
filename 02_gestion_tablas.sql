-- ================================
-- LIMPIAR TABLAS Y CLAVES FORÁNEAS DE TODOS LOS ESQUEMAS
-- ================================
BEGIN
    -- Eliminar FKs de Luis
    FOR c IN (
        SELECT constraint_name, table_name
        FROM all_constraints
        WHERE constraint_type = 'R'
          AND owner = 'LUIS'
          AND table_name IN (
              'CUSTOMER', 'ADDRESS_CUSTOMER', 'ORDER_STATUS', 'PRODUCT_CATEGORY', 'PRODUCTS', 'ORDERS', 'ORDER_DETAIL'
          )
    ) LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE LUIS.' || c.table_name || ' DROP CONSTRAINT ' || c.constraint_name;
    END LOOP;

    -- Eliminar FKs de Duban
    FOR c IN (
        SELECT constraint_name, table_name
        FROM all_constraints
        WHERE constraint_type = 'R'
          AND owner = 'DUBAN'
          AND table_name IN ('ROLE', 'USERS')
    ) LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE DUBAN.' || c.table_name || ' DROP CONSTRAINT ' || c.constraint_name;
    END LOOP;

    -- Eliminar FKs de Dayron
    FOR c IN (
        SELECT constraint_name, table_name
        FROM all_constraints
        WHERE constraint_type = 'R'
          AND owner = 'DAYRON'
          AND table_name IN ('VEHICLE', 'DRIVER', 'ROUTE', 'DELIVERY')
    ) LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE DAYRON.' || c.table_name || ' DROP CONSTRAINT ' || c.constraint_name;
    END LOOP;

    -- Eliminar tablas de Luis
    FOR t IN (
        SELECT table_name
        FROM all_tables
        WHERE owner = 'LUIS'
          AND table_name IN ('CUSTOMER', 'ADDRESS_CUSTOMER', 'ORDER_STATUS', 'PRODUCT_CATEGORY', 'PRODUCTS', 'ORDERS', 'ORDER_DETAIL')
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE LUIS.' || t.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;

    -- Eliminar tablas de Duban
    FOR t IN (
        SELECT table_name
        FROM all_tables
        WHERE owner = 'DUBAN'
          AND table_name IN ('ROLE', 'USERS')
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE DUBAN.' || t.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;

    -- Eliminar tablas de Dayron
    FOR t IN (
        SELECT table_name
        FROM all_tables
        WHERE owner = 'DAYRON'
          AND table_name IN ('VEHICLE', 'DRIVER', 'ROUTE', 'DELIVERY')
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE DAYRON.' || t.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/


-- ================================
-- TABLAS LUIS (Ventas)
-- ================================
CREATE TABLE Luis.customer (
    identifier         NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type_customer      VARCHAR2(100),
    name               VARCHAR2(60),
    last_name          VARCHAR2(100),
    business_name      VARCHAR2(100),
    contact_name       VARCHAR2(100),
    phone              CHAR(9),
    email              VARCHAR2(100),
    document_type      CHAR(3),
    document_number    VARCHAR2(20),
    registration_date  DATE,
    status             CHAR(1) DEFAULT 'A' NOT NULL,
    address_customer_identifier NUMBER(5),
    -- Restricciones
    CONSTRAINT chk_customer_status CHECK (status IN ('A','I')),
    CONSTRAINT chk_customer_type CHECK (
        type_customer IN ('Natural','Jurídico')
    ),
    CONSTRAINT chk_customer_phone CHECK (
        phone IS NULL OR REGEXP_LIKE(phone, '^9[0-9]{8}$')
    ),
    CONSTRAINT chk_customer_email CHECK (
        email IS NULL OR REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
    ),
    CONSTRAINT chk_customer_doc_type CHECK (
        document_type IN ('DNI','RUC','CNE') OR document_type IS NULL
    ),
    CONSTRAINT chk_customer_doc_length CHECK (
        document_type IS NULL
        OR (document_type = 'DNI' AND LENGTH(document_number) = 8)
        OR (document_type = 'RUC' AND LENGTH(document_number) = 11)
        OR (document_type = 'CNE' AND LENGTH(document_number) BETWEEN 8 AND 12)
    ),
    CONSTRAINT chk_customer_name CHECK (
        name IS NULL OR REGEXP_LIKE(name, '^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$')
    ),
    CONSTRAINT chk_customer_last_name CHECK (
        last_name IS NULL OR REGEXP_LIKE(last_name, '^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$')
    )
) TABLESPACE TBS_VENTAS;



CREATE TABLE Luis.address_customer (
    identifier          NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_identifier NUMBER(5) NOT NULL,
    street              VARCHAR2(100) NOT NULL,
    number_address      VARCHAR2(10),
    reference           VARCHAR2(150),
    district            VARCHAR2(50),
    city                VARCHAR2(50),
    status              CHAR(1) DEFAULT 'A' NOT NULL,
    CONSTRAINT chk_address_status CHECK (status IN ('A','I')),
    CONSTRAINT uq_address_customer_unique UNIQUE (customer_identifier, street, number_address),
    CONSTRAINT chk_address_street CHECK (REGEXP_LIKE(TRIM(street), '^[A-Za-zÁÉÍÓÚáéíóúÑñ0-9\.\-]+( [A-Za-zÁÉÍÓÚáéíóúÑñ0-9\.\-]+)*$'))
) TABLESPACE TBS_VENTAS;


CREATE TABLE Luis.order_status (
    identifier  NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    status      CHAR(1) DEFAULT 'P' NOT NULL,
    description VARCHAR2(200),
    updated_at  TIMESTAMP,
    CONSTRAINT chk_order_status_values CHECK (status IN ('P','C','X'))
) TABLESPACE TBS_VENTAS;


CREATE TABLE Luis.product_category (
    identifier   NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name         VARCHAR2(50) NOT NULL,
    description  VARCHAR2(200),
    status       CHAR(1) DEFAULT 'A' NOT NULL,
    created_at   TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT uq_product_category_name UNIQUE(name),
    CONSTRAINT chk_product_category_status CHECK (status IN ('A','I'))
) TABLESPACE TBS_VENTAS;

CREATE TABLE Luis.products (
    identifier         NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name               VARCHAR2(50) NOT NULL,
    description        VARCHAR2(250),
    price              NUMBER(10,2) NOT NULL,
    stock              NUMBER(5) DEFAULT 0 NOT NULL,
    unit_measure       VARCHAR2(20),
    status             CHAR(1) DEFAULT 'A' NOT NULL,
    category_identifier NUMBER(5),
    CONSTRAINT chk_products_status CHECK (status IN ('A','I')),
    CONSTRAINT chk_products_price  CHECK (price > 0),
    CONSTRAINT chk_products_stock  CHECK (stock >= 0),
    CONSTRAINT uq_products_name    UNIQUE (name)
) TABLESPACE TBS_VENTAS;

CREATE TABLE Luis.orders (
    identifier             NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_date             DATE NOT NULL,
    payment_method         VARCHAR2(20),
    comments               VARCHAR2(250),
    customer_identifier    NUMBER(5),
    order_status_identifier NUMBER(5),
    users_identifier       NUMBER(5),
    delivery_identifier    NUMBER(5),
    total                  NUMBER(10,2) DEFAULT 0,
    CONSTRAINT chk_orders_total CHECK (total >= 0),
    CONSTRAINT chk_payment_method CHECK (payment_method IS NULL OR payment_method IN ('EFECTIVO','TARJETA','TRANSFERENCIA','YAPE','PLIN'))
) TABLESPACE TBS_VENTAS;

CREATE TABLE Luis.order_detail (
    identifier         NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    products_identifier NUMBER(5) NOT NULL,
    quantity           NUMBER(5) NOT NULL,
    subtotal           NUMBER(10,2) NOT NULL,
    orders_identifier  NUMBER(5) NOT NULL,
    CONSTRAINT uq_order_detail_product_order UNIQUE (orders_identifier, products_identifier),
    CONSTRAINT chk_order_detail_quantity CHECK (quantity > 0),
    CONSTRAINT chk_order_detail_subtotal CHECK (subtotal >= 0)
) TABLESPACE TBS_VENTAS;

-- ================================
-- TABLAS DUBAN (Administración)
-- ================================
CREATE TABLE Duban.role (
    identifier    NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name          VARCHAR2(50) NOT NULL,
    description   VARCHAR2(200),
    status        CHAR(1) DEFAULT 'A' NOT NULL,
    CONSTRAINT uq_role_name UNIQUE(name),
    CONSTRAINT chk_role_status CHECK (status IN ('A','I'))
) TABLESPACE TBS_ADMIN;

CREATE TABLE Duban.users (
    identifier         NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name         VARCHAR2(80)  NOT NULL,
    last_name          VARCHAR2(150) NOT NULL,
    username           VARCHAR2(50)  NOT NULL,
    hash_password      VARCHAR2(150) NOT NULL,
    phone              CHAR(9),
    email              VARCHAR2(150),
    document_type      VARCHAR2(20),
    document_num       VARCHAR2(20),
    date_registration  DATE          NOT NULL,
    status             CHAR(1) DEFAULT 'A' NOT NULL,
    role_identifier    NUMBER(5),
    CONSTRAINT uq_users_username UNIQUE(username),
    CONSTRAINT chk_users_username CHECK (LENGTH(TRIM(username)) >= 4 AND REGEXP_LIKE(username, '^[A-Za-z0-9_]+$')),
    CONSTRAINT chk_users_password CHECK (LENGTH(hash_password) >= 8),
    CONSTRAINT chk_users_phone CHECK (phone IS NULL OR REGEXP_LIKE(phone, '^9[0-9]{8}$')),
    CONSTRAINT chk_users_email CHECK (email IS NULL OR REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')),
    CONSTRAINT chk_users_status CHECK (status IN ('A','I'))
) TABLESPACE TBS_ADMIN;

-- ================================
-- TABLAS DAYRON (Logística)
-- ================================
CREATE TABLE Dayron.vehicle (
    identifier                NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    plate                     VARCHAR2(20),
    vehicle_type              VARCHAR2(50),
    model                     VARCHAR2(50),
    brand                     VARCHAR2(50),
    purchase_date             DATE,
    capacity_kg               NUMBER(6),
    soat_expiration           DATE,
    last_maintenance_date     DATE,
    next_maintenance_date     DATE,
    status                    CHAR(1) DEFAULT 'A' NOT NULL,
    CONSTRAINT uq_vehicle_plate UNIQUE (plate),
    CONSTRAINT chk_vehicle_status CHECK (status IN ('A','I','M','R'))
) TABLESPACE TBS_LOGISTICA;

CREATE TABLE Dayron.driver (
    identifier        NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name        VARCHAR2(100) NOT NULL,
    last_name         VARCHAR2(100) NOT NULL,
    phone             CHAR(9),
    document_number   VARCHAR2(20),
    entry_date        DATE,
    license_number    VARCHAR2(20),
    license_expiration DATE,
    status            CHAR(1) DEFAULT 'A' NOT NULL,
    vehicle_identifier NUMBER(5),
    CONSTRAINT uq_driver_document UNIQUE(document_number),
    CONSTRAINT chk_driver_phone CHECK (phone IS NULL OR REGEXP_LIKE(phone, '^9[0-9]{8}$')),
    CONSTRAINT chk_driver_status CHECK (status IN ('A','I'))
) TABLESPACE TBS_LOGISTICA;

CREATE TABLE Dayron.route (
    identifier           NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_router          DATE,
    distance_km          NUMBER(5,2),
    estimated_time_min   NUMBER(5),
    real_time_min        NUMBER(5),
    status               CHAR(1) DEFAULT 'P' NOT NULL,
    driver_identifier    NUMBER(5),
    CONSTRAINT chk_route_status CHECK (status IN ('P','A','C','F'))
) TABLESPACE TBS_LOGISTICA;

CREATE TABLE Dayron.delivery (
    identifier         NUMBER(5) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    route_identifier   NUMBER(5),
    delivery_datetime  TIMESTAMP,
    registration_date  TIMESTAMP DEFAULT SYSTIMESTAMP,
    status             CHAR(1) DEFAULT 'P' NOT NULL,
    CONSTRAINT chk_delivery_status CHECK (status IN ('P','A','C','F'))
) TABLESPACE TBS_LOGISTICA;



-- ================================
-- RELACIONES Y CLAVES FORÁNEAS
-- ================================
ALTER TABLE Luis.address_customer
    ADD CONSTRAINT fk_address_customer_customer FOREIGN KEY (customer_identifier) REFERENCES Luis.customer(identifier);

ALTER TABLE Luis.products
    ADD CONSTRAINT fk_products_category FOREIGN KEY (category_identifier) REFERENCES Luis.product_category(identifier);

ALTER TABLE Luis.orders
    ADD CONSTRAINT fk_orders_customer FOREIGN KEY (customer_identifier) REFERENCES Luis.customer(identifier);

ALTER TABLE Luis.orders
    ADD CONSTRAINT fk_orders_order_status FOREIGN KEY (order_status_identifier) REFERENCES Luis.order_status(identifier);

ALTER TABLE Luis.orders
    ADD CONSTRAINT fk_orders_users FOREIGN KEY (users_identifier) REFERENCES Duban.users(identifier);

ALTER TABLE Luis.order_detail
    ADD CONSTRAINT fk_order_detail_orders FOREIGN KEY (orders_identifier) REFERENCES Luis.orders(identifier);

ALTER TABLE Luis.order_detail
    ADD CONSTRAINT fk_order_detail_products FOREIGN KEY (products_identifier) REFERENCES Luis.products(identifier);

ALTER TABLE Duban.users
    ADD CONSTRAINT fk_users_role FOREIGN KEY (role_identifier) REFERENCES Duban.role(identifier);

ALTER TABLE Dayron.driver
    ADD CONSTRAINT fk_driver_vehicle FOREIGN KEY (vehicle_identifier) REFERENCES Dayron.vehicle(identifier);

ALTER TABLE Dayron.route
    ADD CONSTRAINT fk_route_driver FOREIGN KEY (driver_identifier) REFERENCES Dayron.driver(identifier);

ALTER TABLE Dayron.delivery
    ADD CONSTRAINT fk_delivery_route FOREIGN KEY (route_identifier) REFERENCES Dayron.route(identifier);


-- ================================
-- ÍNDICES
-- ================================
CREATE INDEX Luis.idx_orders_customer ON Luis.orders(customer_identifier);
CREATE INDEX Luis.idx_orders_status ON Luis.orders(order_status_identifier);
CREATE INDEX Luis.idx_order_detail_order ON Luis.order_detail(orders_identifier);
CREATE INDEX Luis.idx_products_category ON Luis.products(category_identifier);

