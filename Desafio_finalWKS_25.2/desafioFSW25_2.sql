CREATE DATABASE concessionaria;
USE concessionaria;

CREATE TABLE concessionaria (
    id_concessionaria INT PRIMARY KEY AUTO_INCREMENT,
    telefone VARCHAR(20),
    rua VARCHAR(100),
    bairro VARCHAR(50),
    numeroEndereco VARCHAR(10),
    cidade VARCHAR(50),
    uf CHAR(2)
);

CREATE TABLE funcionario (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    id_concessionaria INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    cargo VARCHAR(50),
    telefone VARCHAR(20),
    CONSTRAINT fk_funcionario_concessionaria FOREIGN KEY (id_concessionaria) REFERENCES concessionaria(id_concessionaria)
);

CREATE TABLE veiculo (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    id_concessionaria INT NOT NULL,
    placa VARCHAR(7) UNIQUE NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    categoria VARCHAR(30),
    valorDiaria DECIMAL(10,2) NOT NULL,
    status ENUM('disponível', 'alugado', 'em manutenção') NOT NULL DEFAULT 'disponível',
    CONSTRAINT fk_veiculo_concessionaria FOREIGN KEY (id_concessionaria) REFERENCES concessionaria(id_concessionaria)
);

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    cnpj VARCHAR(14) UNIQUE,
    cnh VARCHAR(12) UNIQUE,
    telefone VARCHAR(20),
    rua VARCHAR(100),
    numero_endereco_cliente VARCHAR(10),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    uf CHAR(2),
    dataCadastro DATE,
    email VARCHAR(100)
);

CREATE TABLE contrato (
    id_contrato INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_veiculo INT NOT NULL,
    dataSaida DATE NOT NULL,
    dataRetorno DATE NOT NULL,
    dataDevolucao DATE,
    valorDiaria DECIMAL(10,2) NOT NULL,
    multa DECIMAL(10,2),
    valorTotal DECIMAL(10,2),
    id_funcionario 	INT NOT NULL,
    status ENUM('ativo', 'finalizado', 'atrasado') NOT NULL DEFAULT 'ativo',
    CONSTRAINT fk_contrato_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_contrato_veiculo FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo),
	CONSTRAINT fk_contrato_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE oficina (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    id_veiculo INT NOT NULL,
    id_funcionario INT NOT NULL,
    entrada DATE NOT NULL,
    saida DATE,
    status VARCHAR(20) NOT NULL,
    custo DECIMAL(10,2),
    descricaoServico VARCHAR(150),
    CONSTRAINT fk_oficina_veiculo FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo),
    CONSTRAINT fk_oficina_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE pagamento(
id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
id_contrato INT NOT NULL,
dataPagamento DATE,
valor DECIMAL(10,2),
metodo VARCHAR(15),
status ENUM('pendente', 'concluído', 'cancelado') NOT NULL DEFAULT 'pendente',
CONSTRAINT fk_pagamento_contrato FOREIGN KEY (id_contrato) REFERENCES contrato(id_contrato)
);

-- ------------------------------- DML ------------------------------- --
INSERT INTO concessionaria (telefone, rua, bairro, numeroEndereco, cidade, uf) VALUES
('8333333333', 'Rua A', 'Bairro 1', '10', 'João Pessoa', 'PB'),
('8333333334', 'Rua B', 'Bairro 2', '20', 'Campina Grande', 'PB'),
('8333333335', 'Rua C', 'Bairro 3', '30', 'Santa Rita', 'PB'),
('8333333336', 'Rua D', 'Bairro 4', '40', 'Bayeux', 'PB'),
('8333333337', 'Rua E', 'Bairro 5', '50', 'Patos', 'PB'),
('8333333338', 'Rua F', 'Bairro 6', '60', 'Sousa', 'PB'),
('8333333339', 'Rua G', 'Bairro 7', '70', 'Cabedelo', 'PB'),
('8333333340', 'Rua H', 'Bairro 8', '80', 'Guarabira', 'PB'),
('8333333341', 'Rua I', 'Bairro 9', '90', 'Mamanguape', 'PB'),
('8333333342', 'Rua J', 'Bairro 10', '100', 'Cajazeiras', 'PB');

INSERT INTO funcionario (id_concessionaria, nome, cpf, cargo, telefone) VALUES
(1, 'Carlos Silva', '12345678901', 'Gerente', '8399999991'),
(2, 'Ana Souza', '12345678902', 'Atendente', '8399999992'),
(3, 'João Santos', '12345678903', 'Mecânico', '8399999993'),
(4, 'Mariana Lima', '12345678904', 'Atendente', '8399999994'),
(5, 'Pedro Alves', '12345678905', 'Gerente', '8399999995'),
(6, 'Luciana Costa', '12345678906', 'Mecânico', '8399999996'),
(7, 'Rafael Dias', '12345678907', 'Atendente', '8399999997'),
(8, 'Patrícia Rocha', '12345678908', 'Gerente', '8399999998'),
(9, 'Bruno Martins', '12345678909', 'Mecânico', '8399999999'),
(10, 'Carla Nunes', '12345678910', 'Atendente', '8399999980');

INSERT INTO veiculo (id_concessionaria, placa, modelo, marca, ano, categoria, valorDiaria, status) VALUES
(1, 'ABC1234', 'Gol', 'Volkswagen', 2020, 'Hatch', 100.00, 'disponível'),
(2, 'DEF5678', 'Civic', 'Honda', 2019, 'Sedan', 150.00, 'disponível'),
(3, 'GHI9012', 'Corolla', 'Toyota', 2021, 'Sedan', 160.00, 'alugado'),
(4, 'JKL3456', 'Onix', 'Chevrolet', 2020, 'Hatch', 110.00, 'disponível'),
(5, 'MNO7890', 'Renegade', 'Jeep', 2022, 'SUV', 200.00, 'em manutenção'),
(6, 'PQR2345', 'HB20', 'Hyundai', 2021, 'Hatch', 120.00, 'disponível'),
(7, 'STU6789', 'Fiesta', 'Ford', 2018, 'Hatch', 90.00, 'alugado'),
(8, 'VWX0123', 'Tracker', 'Chevrolet', 2021, 'SUV', 180.00, 'disponível'),
(9, 'YZA4567', 'Kicks', 'Nissan', 2020, 'SUV', 170.00, 'disponível'),
(10,'BCD8901', 'HB20S', 'Hyundai', 2019, 'Sedan', 110.00, 'em manutenção');

INSERT INTO cliente (nome, cpf, cnpj, cnh, telefone, rua, numero_endereco_cliente, bairro, cidade, uf, dataCadastro, email) VALUES
('Lucas Almeida', '11122233344', NULL, 'AB123456', '8398888881', 'Rua 1', '10', 'Bairro A', 'João Pessoa', 'PB', '2025-01-10', 'lucas@email.com'),
('Mariana Silva', '22233344455', NULL, 'BC234567', '8398888882', 'Rua 2', '20', 'Bairro B', 'Campina Grande', 'PB', '2025-02-15', 'mariana@email.com'),
('Pedro Santos', '33344455566', NULL, 'CD345678', '8398888883', 'Rua 3', '30', 'Bairro C', 'Santa Rita', 'PB', '2025-03-20', 'pedro@email.com'),
('Ana Costa', '44455566677', NULL, 'DE456789', '8398888884', 'Rua 4', '40', 'Bairro D', 'Bayeux', 'PB', '2025-04-25', 'ana@email.com'),
('Rafael Lima', '55566677788', NULL, 'EF567890', '8398888885', 'Rua 5', '50', 'Bairro E', 'Patos', 'PB', '2025-05-30', 'rafael@email.com'),
('Carla Rocha', '66677788899', NULL, 'FG678901', '8398888886', 'Rua 6', '60', 'Bairro F', 'Sousa', 'PB', '2025-06-05', 'carla@email.com'),
('Bruno Martins', '77788899900', NULL, 'GH789012', '8398888887', 'Rua 7', '70', 'Bairro G', 'Cabedelo', 'PB', '2025-07-10', 'bruno@email.com'),
('Patrícia Nunes', '88899900011', NULL, 'HI890123', '8398888888', 'Rua 8', '80', 'Bairro H', 'Guarabira', 'PB', '2025-08-15', 'patricia@email.com'),
('Felipe Alves', '99900011122', NULL, 'IJ901234', '8398888889', 'Rua 9', '90', 'Bairro I', 'Mamanguape', 'PB', '2025-09-20', 'felipe@email.com'),
('Juliana Dias', '00011122233', NULL, 'JK012345', '8398888890', 'Rua 10', '100', 'Bairro J', 'Cajazeiras', 'PB', '2025-10-25', 'juliana@email.com');

INSERT INTO contrato (id_cliente, id_veiculo, dataSaida, dataRetorno, dataDevolucao, valorDiaria, multa, valorTotal, id_funcionario, status) VALUES
(1, 1, '2025-09-01', '2025-09-05', NULL, 100.00, 0, NULL, 1, 'ativo'),
(2, 2, '2025-09-02', '2025-09-06', NULL, 150.00, 0, NULL, 2, 'ativo'),
(3, 3, '2025-09-03', '2025-09-07', '2025-09-08', 160.00, 50.00, 810.00, 3, 'finalizado'),
(4, 4, '2025-09-04', '2025-09-08', NULL, 110.00, 0, NULL, 4, 'ativo'),
(5, 5, '2025-09-05', '2025-09-10', NULL, 200.00, 0, NULL, 5, 'ativo'),
(6, 6, '2025-09-06', '2025-09-09', '2025-09-10', 120.00, 30.00, 390.00, 6, 'finalizado'),
(7, 7, '2025-09-07', '2025-09-11', NULL, 90.00, 0, NULL, 7, 'ativo'),
(8, 8, '2025-09-08', '2025-09-12', NULL, 180.00, 0, NULL, 8, 'ativo'),
(9, 9, '2025-09-09', '2025-09-13', NULL, 170.00, 0, NULL, 9, 'ativo'),
(10, 10, '2025-09-10', '2025-09-14', NULL, 110.00, 0, NULL, 10, 'ativo');

INSERT INTO oficina (id_veiculo, id_funcionario, entrada, saida, status, custo, descricaoServico) VALUES
(1, 3, '2025-08-01', '2025-08-03', 'finalizado', 150.00, 'Troca de óleo'),
(2, 6, '2025-08-02', '2025-08-04', 'finalizado', 200.00, 'Alinhamento'),
(3, 9, '2025-08-03', '2025-08-05', 'finalizado', 500.00, 'Revisão completa'),
(4, 3, '2025-08-04', '2025-08-06', 'finalizado', 180.00, 'Troca de pneus'),
(5, 6, '2025-08-05', '2025-08-07', 'finalizado', 350.00, 'Suspensão'),
(6, 9, '2025-08-06', '2025-08-08', 'finalizado', 120.00, 'Troca de bateria'),
(7, 3, '2025-08-07', '2025-08-09', 'finalizado', 250.00, 'Freios'),
(8, 6, '2025-08-08', '2025-08-10', 'finalizado', 400.00, 'Troca de correia'),
(9, 9, '2025-08-09', '2025-08-11', 'finalizado', 300.00, 'Troca de amortecedor'),
(10, 3, '2025-08-10', '2025-08-12', 'finalizado', 100.00, 'Limpeza interna');

INSERT INTO pagamento (id_contrato, dataPagamento, valor, metodo, status) VALUES
(1, '2025-09-02', 100.00, 'Cartão', 'concluído'),
(2, '2025-09-03', 150.00, 'Dinheiro', 'concluído'),
(3, '2025-09-04', 810.00, 'PIX', 'concluído'),
(4, '2025-09-05', 110.00, 'Cartão', 'concluído'),
(5, '2025-09-06', 200.00, 'PIX', 'pendente'),
(6, '2025-09-07', 390.00, 'Dinheiro', 'concluído'),
(7, '2025-09-08', 90.00, 'Cartão', 'pendente'),
(8, '2025-09-09', 180.00, 'PIX', 'pendente'),
(9, '2025-09-10', 170.00, 'Cartão', 'pendente'),
(10, '2025-09-11', 110.00, 'Dinheiro', 'concluído');

UPDATE contrato SET dataDevolucao = NULL, multa = 0, valorTotal = NULL, status = 'ativo' WHERE id_contrato = 3;
UPDATE contrato SET dataDevolucao = NULL, multa = 0, valorTotal = NULL, status = 'ativo' WHERE id_contrato = 6;

SELECT * FROM contrato;

UPDATE veiculo SET status = 'alugado' WHERE id_veiculo = 1;
UPDATE veiculo SET status = 'alugado' WHERE id_veiculo = 2;
UPDATE veiculo SET status = 'alugado' WHERE id_veiculo = 4;
UPDATE veiculo SET status = 'alugado' WHERE id_veiculo = 5;
UPDATE veiculo SET status = 'alugado' WHERE id_veiculo = 6;
UPDATE veiculo SET status = 'alugado' WHERE id_veiculo = 8;
UPDATE veiculo SET status = 'alugado' WHERE id_veiculo = 9;
UPDATE veiculo SET status = 'alugado' WHERE id_veiculo = 10;

SELECT * FROM veiculo;

-- ------------------------------- DQL ------------------------------- --
SELECT uf, COUNT(*) AS quantidade
FROM concessionaria
GROUP BY uf;

SELECT cargo, COUNT(*) AS quantidade
FROM funcionario
GROUP BY cargo;

SELECT categoria, AVG(valorDiaria) As media
FROM veiculo
GROUP BY categoria;

SELECT uf, COUNT(cpf) AS cpf, COUNT(cnpj) AS cnpj
FROM cliente
group by uf;

SELECT AVG(DATEDIFF(dataRetorno, dataSaida)) AS 'média de dias contratados'
FROM contrato;

SELECT f.nome, AVG(DATEDIFF(o.saida, o.entrada)) AS 'média de dias trabalhando no carro'
FROM oficina o
INNER JOIN funcionario f ON o.id_funcionario = f.id_funcionario
GROUP BY f.nome;

SELECT YEAR(dataPagamento) AS ano, MONTH(dataPagamento) AS mes, SUM(valor) AS 'total em pagamentos'
FROM pagamento
GROUP BY YEAR(dataPagamento), MONTH(dataPagamento)
ORDER BY ano, mes;

SELECT f.nome AS nome, 
       COUNT(c.id_contrato) AS 'nºcontratos feitos'
FROM contrato c
INNER JOIN funcionario f ON c.id_funcionario = f.id_funcionario
GROUP BY f.nome;

