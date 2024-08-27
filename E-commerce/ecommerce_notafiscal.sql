/* NOTA FISCAL
nome cliente
cpf cliente
telefone
cidade pra qual vai o pedido (endereco)
nome funcionario
id funcionario (?)
data da compra
pedido/produtos
nome produto
quantidade
preco total
preco unitario (?)
categoria(?)
*/

CREATE OR REPLACE VIEW nota_fiscal AS
SELECT pedidos_produtos.id_pedido AS num_pedido, 
clientes.nome, 
clientes.cpf, 
STRING_AGG(telefones.telefone::text, ', ') AS telefones, 
endereco.cidade, funcionarios.id AS id_funcionario, 
funcionarios.nome AS funcionario, pedidos.data,
produtos.nome AS produtos, 
categorias.nome AS categoria, 
produtos.preco, 
pedidos_produtos.quantidade, 
produtos.preco * pedidos_produtos.quantidade AS total_item, 
SUM(produtos.preco * pedidos_produtos.quantidade) OVER (PARTITION BY pedidos_produtos.id_pedido) AS total
FROM clientes
INNER JOIN telefones
ON telefones.id_cliente = clientes.id
INNER JOIN endereco
ON endereco.id_cliente = clientes.id
INNER JOIN pedidos
ON pedidos.id_cliente = clientes.id
INNER JOIN pedidos_produtos
ON pedidos_produtos.id_pedido = pedidos.id
INNER JOIN produtos
ON produtos.id = pedidos_produtos.id_produto
INNER JOIN categorias
ON categorias.id = produtos.id_categoria
INNER JOIN funcionarios
ON funcionarios.id = pedidos.id_funcionario
GROUP BY (num_pedido, clientes.nome, categorias.nome, clientes.cpf, endereco.cidade, funcionarios.id, 
pedidos.data, produtos.nome, produtos.preco, pedidos_produtos.quantidade);

--DROP VIEW nota_fiscal

SELECT * FROM nota_fiscal
WHERE num_pedido = 1
