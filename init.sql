-- CREATE TABLE USERS (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     userName VARCHAR(100) NOT NULL,
--     userPassword VARCHAR(100) NOT NULL
-- );

CREATE DATABASE CHATAPP;
GO
USE CHATAPP;
GO

CREATE TABLE `USERS` (
  `id` int AUTO_INCREMENT NOT NULL,
  `userName` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `rooms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `roomName` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(300) NOT NULL,
  `date` varchar(45) NOT NULL,
  `idRoom` int NOT NULL,
  `idUser` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `idRoom_idx` (`idRoom`),
  KEY `idUser_idx` (`idUser`),
  CONSTRAINT `idRoom` FOREIGN KEY (`idRoom`) REFERENCES `rooms` (`id`),
  CONSTRAINT `idUser` FOREIGN KEY (`idUser`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci