DROP DATABASE IF EXISTS licores;
CREATE DATABASE licores CHARACTER SET utf8mb4;
USE licores;

create table productos(
idProductos int primary key auto_increment not null,
nombre varchar(100),
precio int(10),
stock int(10),
imagen varchar(100)
);