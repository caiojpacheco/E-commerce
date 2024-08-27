-- SQL de criação das tabelas
CREATE TABLE funcionarios (
	id SERIAL PRIMARY KEY,
	nome VARCHAR (100) NOT NULL,
	cpf VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE clientes (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	usuario VARCHAR(50) NOT NULL UNIQUE,
	email VARCHAR(100) NOT NULL UNIQUE,
	cpf VARCHAR(15) NOT NULL UNIQUE,
	data_nascimento DATE NOT NULL
);

CREATE TABLE telefones (
	id SERIAL PRIMARY KEY,
	telefone BIGINT NOT NULL,
	id_cliente INTEGER REFERENCES clientes(id)
);

CREATE TABLE endereco (
	id SERIAL PRIMARY KEY,
	logradouro VARCHAR (200) NOT NULL,
	complemento VARCHAR(50),
	bairro VARCHAR(50) NOT NULL,
	cidade VARCHAR(150) NOT NULL,
	uf VARCHAR(2) NOT NULL,
	cep VARCHAR(10) NOT NULL,
	id_cliente INTEGER REFERENCES clientes(id) UNIQUE
);

CREATE TABLE pedidos (
	id SERIAL PRIMARY KEY,
	data DATE NOT NULL DEFAULT CURRENT_DATE,
	id_funcionario INTEGER REFERENCES funcionarios(id),
	id_cliente INTEGER REFERENCES clientes(id)
);

CREATE TABLE categorias (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL UNIQUE,
	descricao TEXT
);

CREATE TABLE produtos (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL UNIQUE,
	descricao TEXT,
	data_fabricacao DATE NOT NULL,
	preco DECIMAL NOT NULL,
	id_categoria INTEGER REFERENCES categorias(id)	
);

CREATE TABLE pedidos_produtos (
	id_pedido INTEGER REFERENCES pedidos(id),
	id_produto INTEGER REFERENCES produtos(id),
	quantidade INTEGER NOT NULL,
	PRIMARY KEY (id_pedido, id_produto)	
);

CREATE TABLE estoque (
	id SERIAL PRIMARY KEY,
	id_produto INTEGER REFERENCES produtos(id) UNIQUE,
	quantidade INTEGER
);

-- SQL de inserção de dados nas tabelas (pelo menos 5 registros em cada uma)

INSERT INTO categorias (nome, descricao) VALUES 
('Eletrônicos', 'Produtos eletrônicos diversos'),
('Vestuário', 'Roupas e acessórios'),
('Alimentos', 'Produtos alimentícios'),
('Livros', 'Diversos tipos de livros'),
('Móveis', 'Móveis e decorações'),
('Brinquedos', 'Brinquedos e jogos para crianças'),
('Beleza', 'Produtos de beleza e cuidados pessoais'),
('Esportes', 'Equipamentos e roupas esportivas');

INSERT INTO produtos (nome, descricao, data_fabricacao, preco, id_categoria) VALUES 
('Smartphone', 'Celular com 128GB de armazenamento', '2023-05-12', 1500.00, 1),
('Camisa Polo', 'Camisa polo azul tamanho M', '2024-01-01', 75.00, 2),
('Café', 'Pacote de café torrado e moído 500g', '2024-06-25', 12.00, 3),
('Livro de Ficção', 'Romance de ficção científica', '2022-08-20', 45.00, 4),
('Sofá 3 Lugares', 'Sofá de couro sintético', '2023-04-10', 1200.00, 5),
('Boneca', 'Boneca de pano com vestido', '2022-12-15', 30.00, 6),
('Creme Facial', 'Creme hidratante para o rosto', '2023-02-22', 25.00, 7),
('Bola de Futebol', 'Bola oficial de futebol tamanho 5', '2024-03-30', 100.00, 8),
('Notebook', 'Notebook com 16GB RAM e 512GB SSD', '2024-02-10', 3500.00, 1),
('Jaqueta de Couro', 'Jaqueta de couro legítimo preta tamanho G', '2023-11-15', 450.00, 2),
('Chocolate Amargo', 'Barra de chocolate amargo 70% cacau', '2024-03-01', 10.00, 3),
('Enciclopédia de História', 'Livro enciclopédia de história mundial', '2023-05-05', 200.00, 4),
('Mesa de Jantar', 'Mesa de jantar de madeira para 6 pessoas', '2023-09-15', 800.00, 5),
('Carrinho de Controle Remoto', 'Carrinho de controle remoto com bateria recarregável', '2024-04-10', 150.00, 6),
('Shampoo para Cabelos Secos', 'Shampoo hidratante para cabelos secos 300ml', '2023-08-08', 18.00, 7),
('Tênis de Corrida', 'Tênis de corrida leve e confortável', '2024-01-20', 250.00, 8),
('Tablet', 'Tablet com tela de 10 polegadas e 128GB de armazenamento', '2024-02-18', 1200.00, 1),
('Vestido de Festa', 'Vestido de festa longo vermelho tamanho M', '2024-05-12', 300.00, 2);

INSERT INTO estoque (quantidade, id_produto) VALUES 
(50, 1),
(200, 2),
(100, 3),
(30, 4),
(10, 5),
(80, 6),
(150, 7),
(60, 8);

INSERT INTO clientes (nome, usuario, email, cpf, data_nascimento) VALUES 
('João Silva', 'joaos', 'joao@example.com', '12345678900', '1990-05-15'),
('Maria Oliveira', 'mariao', 'maria@example.com', '23456789001', '1988-09-22'),
('Carlos Pereira', 'carlosp', 'carlos@example.com', '34567890102', '1985-12-05'),
('Ana Costa', 'anac', 'ana@example.com', '45678901203', '1995-02-14'),
('Rafael Souza', 'rafaels', 'rafael@example.com', '56789012304', '1992-07-30'),
('Fernanda Lima', 'fernandal', 'fernanda@example.com', '67890123405', '1998-03-21'),
('Bruno Rocha', 'brunor', 'bruno@example.com', '78901234506', '1983-10-11'),
('Luciana Martins', 'lucianam', 'luciana@example.com', '89012345607', '1991-04-09');

INSERT INTO endereco (logradouro, complemento, bairro, cidade, uf, cep, id_cliente) VALUES 
('Rua A', 'Apt 101', 'Centro', 'São Paulo', 'SP', '01000-000', 1),
('Rua B', 'Casa 5', 'Jardim', 'Rio de Janeiro', 'RJ', '20000-000', 2),
('Rua C', 'Bloco 2', 'Vila', 'Belo Horizonte', 'MG', '30000-000', 3),
('Rua D', 'Sala 1', 'Industrial', 'Curitiba', 'PR', '40000-000', 4),
('Rua E', '', 'Comercial', 'Porto Alegre', 'RS', '50000-000', 5),
('Rua F', 'Cobertura', 'Residencial', 'Salvador', 'BA', '60000-000', 6),
('Rua G', 'Galpão', 'Rural', 'Florianópolis', 'SC', '70000-000', 7),
('Rua H', 'Andar 4', 'Urbano', 'Fortaleza', 'CE', '80000-000', 8);

INSERT INTO telefones (telefone, id_cliente) VALUES 
(11987654321, 1),
(21987654322, 2),
(31987654323, 3),
(41987654324, 4),
(51987654325, 5),
(61987654326, 6),
(71987654327, 7),
(81987654328, 8),
(21986984216, 1),
(21987524689, 2),
(21986125489, 3),
(21982354897, 4);

INSERT INTO funcionarios (nome, cpf) VALUES 
('Pedro Albuquerque', '90123456789'),
('Juliana Fernandes', '12345678911'),
('Fernando Costa', '23456789012'),
('Amanda Souza', '34567890123'),
('Lucas Silva', '45678901234'),
('Mariana Ribeiro', '56789012345'),
('Thiago Lima', '67890123456'),
('Carla Santos', '78901234567');

INSERT INTO pedidos (data, id_funcionario, id_cliente) VALUES 
('2024-08-01', 1, 1),
('2024-08-02', 2, 2),
('2024-08-03', 3, 3),
('2024-08-04', 4, 4),
('2024-08-05', 5, 5),
('2024-08-06', 6, 6),
('2024-08-07', 7, 7),
('2024-08-08', 8, 8);

INSERT INTO pedidos_produtos (id_pedido, id_produto, quantidade) VALUES 
(1, 1, 2),
(1, 5, 1),
(1, 7, 1),
(1, 6, 7),
(2, 2, 2),
(2, 4, 4),
(2, 5, 1),
(2, 6, 1),
(2, 7, 2),
(3, 3, 15),
(3, 1, 1),
(3, 2, 3),
(3, 5, 1),
(3, 8, 5),
(4, 4, 1),
(4, 3, 5),
(4, 5, 1),
(5, 5, 1),
(6, 6, 3),
(6, 1, 2),
(7, 7, 3),
(7, 2, 5),
(8, 8, 20),
(8, 4, 2);

--Um comando SQL de atualização em algum registro em uma tabela
UPDATE telefones SET telefone = '21987654328' WHERE id = 8;
UPDATE estoque SET quantidade = 23 WHERE id = 4;

--Um comando SQL de exclusão de algum registro em uma tabela
DELETE FROM pedidos_produtos WHERE id_pedido = 5

--Pelo menos 2 com algum tipo de junção
--pedido/cliente/funcionario/data

SELECT pedidos.id AS pedido_id, clientes.nome AS cliente, funcionarios.nome AS funcionario, pedidos.data
FROM pedidos 
JOIN clientes ON pedidos.id_cliente = clientes.id
JOIN funcionarios ON pedidos.id_funcionario = funcionarios.id;

--Consulta de Produtos por Categoria--
SELECT produtos.nome AS produto, categorias.nome AS categoria, produtos.preco
FROM produtos
JOIN categorias ON produtos.id_categoria = categorias.id;

--Quantidade de Produtos em Cada Categoria--
SELECT categorias.nome AS categoria, COUNT(produtos.id) AS quantidade_produtos
FROM produtos
JOIN categorias ON produtos.id_categoria = categorias.id
GROUP BY categorias.nome;

--Consulta de Estoque de Produtos--
SELECT produtos.nome AS produto, estoque.quantidade
FROM estoque
JOIN produtos ON estoque.id_produto = produtos.id;

--Pelo menos 1 com usando count() e group by()
SELECT string_agg(produtos.nome, ', ') AS produtos, categorias.nome AS categoria, COUNT(produtos.id) AS quantidade
FROM produtos
INNER JOIN categorias
ON produtos.id_categoria = categorias.id
GROUP BY categorias.nome

--Trigger de verificação de estoque
CREATE OR REPLACE FUNCTION verifica_estoque_func()
RETURNS TRIGGER AS $$
DECLARE
    quantidade_estoque INT;
BEGIN
    -- Obtém a quantidade disponível no estoque para o produto que está sendo inserido
    SELECT quantidade INTO quantidade_estoque
    FROM estoque
    WHERE id_produto = NEW.id_produto;

    -- Verifica se a quantidade disponível é suficiente
    IF quantidade_estoque IS NULL OR quantidade_estoque < NEW.quantidade THEN
        RAISE EXCEPTION 'Quantidade insuficiente no estoque';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verifica_estoque
BEFORE INSERT ON pedidos_produtos
FOR EACH ROW
EXECUTE FUNCTION verifica_estoque_func();