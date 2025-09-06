create database DESAFIO;
use DESAFIO;

create table veiculos(
id_veiculo int primary key auto_increment,
placa varchar(7) not null,
marca varchar(20) not null,
modelo varchar(20) not null
);

create table clientes(
id_cliente int primary key auto_increment,
cpf varchar(12) not null unique,
nome varchar(50) not null,
cnh varchar (11) not null unique,
contato varchar(12) not null
);

create table locacoes (
    id_locacao int primary key auto_increment,
    id_cliente int not null,
    id_veiculo int not null,
    data_locacao date not null,
    foreign key (id_cliente) references clientes(id_cliente),
    foreign key (id_veiculo) references veiculos(id_veiculo)
);

INSERT INTO veiculos (placa, marca, modelo) VALUES
('ABC1234', 'Fiat', 'Uno'),
('XYZ9876', 'Volkswagen', 'Gol'),
('JKL4321', 'Chevrolet', 'Onix'),
('MNO6543', 'Ford', 'Ka'),
('PQR7890', 'Toyota', 'Corolla'),
('STU3210', 'Honda', 'Civic'),
('DEF5678', 'Hyundai', 'HB20'),
('GHI8765', 'Renault', 'Kwid'),
('VWX1357', 'Nissan', 'March'),
('LMN2468', 'Peugeot', '208');

insert into clientes (cpf, nome, cnh, contato) values
('12345678901', 'Carlos Silva', '98765432101', '83986123456'),
('23456789012', 'Maria Oliveira', '87654321012', '83987234567'),
('34567890123', 'João Souza', '76543210923', '83988345678'),
('45678901234', 'Ana Costa', '65432109834', '83989456789'),
('56789012345', 'Pedro Santos', '54321098745', '83990567890'),
('67890123456', 'Juliana Lima', '43210987656', '83991678901'),
('78901234567', 'Ricardo Pereira', '32109876567', '83992789012'),
('89012345678', 'Fernanda Rocha', '21098765478', '83993890123'),
('90123456789', 'Lucas Almeida', '10987654389', '83994901234'),
('01234567890', 'Camila Fernandes', '09876543290', '83995012345');

insert into locacoes (id_cliente, id_veiculo, data_locacao) values
(2, 1, '2025-09-01'),
(3, 2, '2025-09-02'),
(4, 3, '2025-09-02'),
(5, 4, '2025-09-03'),
(6, 5, '2025-09-03'),
(7, 6, '2025-09-04'),
(8, 7, '2025-09-04'),
(9, 8, '2025-09-05'),
(10, 9, '2025-09-05'),
(2, 10, '2025-09-06');

-- --------------- DML --------------- --
delete from clientes where cpf = '12345678901';

-- --------------- DQL --------------- --
select 
    c.nome as cliente,
    COUNT(l.id_locacao) as total_locacoes,
    MAX(l.data_locacao) as ultima_locacao,
    MIN(l.data_locacao) as primeira_locacao
from clientes c
join locacoes l on c.id_cliente = l.id_cliente
group by c.nome, c.id_cliente;