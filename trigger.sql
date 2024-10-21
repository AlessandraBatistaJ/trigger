CREATE DATABASE LojaJogos;
USE LojaJogos;

CREATE TABLE Clientes (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Email VARCHAR(100),
    DataCadastro DATE
);

CREATE TABLE Jogos (
    JogoID INT AUTO_INCREMENT PRIMARY KEY,
    NomeJogo VARCHAR(100),
    Plataforma VARCHAR(50),
    Preco DECIMAL(10, 2)
);

CREATE TABLE Compras (
    CompraID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    JogoID INT,
    DataCompra DATE,
    Quantidade INT,
    Total DECIMAL(10, 2),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (JogoID) REFERENCES Jogos(JogoID)
);

DELIMITER $$

CREATE TRIGGER AtualizaTotal BEFORE INSERT ON Compras
FOR EACH ROW
BEGIN
    DECLARE precoJogo DECIMAL(10, 2);
    SELECT Preco INTO precoJogo FROM Jogos WHERE JogoID = NEW.JogoID;
    SET NEW.Total = precoJogo * NEW.Quantidade;
END$$

DELIMITER ;

INSERT INTO Clientes (Nome, Email, DataCadastro) 
VALUES ('João da Silva', 'joao@gmail.com', '2024-01-01');

INSERT INTO Clientes (Nome, Email, DataCadastro) 
VALUES ('Maria Oliveira', 'maria@gmail.com', '2024-01-10');


INSERT INTO Jogos (NomeJogo, Plataforma, Preco) 
VALUES ('The Last of Us', 'PS5', 250.00);

INSERT INTO Jogos (NomeJogo, Plataforma, Preco) 
VALUES ('Cyberpunk 2077', 'PC', 200.00);


INSERT INTO Compras (ClienteID, JogoID, DataCompra, Quantidade) 
VALUES (1, 1, '2024-10-15', 2);

INSERT INTO Compras (ClienteID, JogoID, DataCompra, Quantidade) 
VALUES (2, 2, '2024-10-15', 1);


SELECT * FROM Compras;
