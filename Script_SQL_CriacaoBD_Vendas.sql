------------------------------------------------------------------------
-- Comando para criar o banco
------------------------------------------------------------------------
CREATE DATABASE Vendas_Teste
GO

------------------------------------------------------------------------
-- Comando para usar o banco
------------------------------------------------------------------------
use Vendas_Teste
go

------------------------------------------------------------------------
-- Cria a tabela Pessoas
------------------------------------------------------------------------
create table Pessoas
(
    idPessoa    INT             not null        PRIMARY KEY     IDENTITY,
    nome        VARCHAR(50)     not null,
    cpf         VARCHAR(14)     not null       unique,
    status      INT                 null,
    CHECK       (status in (1,2,3,4))
)
GO

------------------------------------------------------------------------
-- Cria a tabela Clientes
------------------------------------------------------------------------
CREATE TABLE Clientes
(
    pessoa_id   INT     not null    PRIMARY KEY     REFERENCES pessoas,
    renda       DECIMAL(10,2)   not null,
    credito     decimal(10,2)   not null,
    CHECK       (renda >= 700),
    check       (credito >= 100)
)
go

------------------------------------------------------------------------
-- Comando que consulta o dicionário de dados da tabela
------------------------------------------------------------------------
EXECUTE sp_help Clientes
go

------------------------------------------------------------------------
-- Cria a tabela Vendedores
------------------------------------------------------------------------
CREATE TABLE Vendedores
(
    pessoa_id   INT             not null    PRIMARY KEY     REFERENCES pessoas,
    salario     DECIMAL(10,2)   not null,
    check       (salario >= 1000)
)
go

------------------------------------------------------------------------
-- Cria a tabela Pedidos
------------------------------------------------------------------------
CREATE TABLE Pedidos
(
    idPedido    INT         not NULL    PRIMARY KEY IDENTITY,
    data        DATETIME    NOT null, 
    status      int,
    valor       DECIMAL(10,2),
    cliente_id  INT         not null    REFERENCES Clientes,
    vendedor_id INT         not NULL    REFERENCES Vendedores,
    CHECK       (status between 1 and 4),
    CHECK       (valor > 0)
)
go

------------------------------------------------------------------------
-- Cria a tabela Produtos
------------------------------------------------------------------------
CREATE TABLE Produtos
(
    idProduto   INT             not NULL    PRIMARY key     IDENTITY,
    descricao   VARCHAR(100)    NOT NULL,
    qtd         INT                 null,
    valor       decimal(10,2),
    status      int,
    CHECK       (qtd >= 0),
    CHECK       (valor > 0),
    CHECK       (status >= 1 and status <= 2) -- 1 ativo, 2 inativo
)
go

------------------------------------------------------------------------
-- Cria a tabela Itens_Pedidos
------------------------------------------------------------------------
CREATE TABLE Itens_Pedidos
(
    pedido_id   INT     not null    REFERENCES Pedidos,
    produto_id  INT     not NULL    REFERENCES Produtos,
    qtd         int     not null,
    valor       decimal(10,2)   NOT null,
    CHECK       (qtd > 0),
    CHECK       (valor >0),
    PRIMARY KEY (pedido_id, produto_id)
)
go

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------
-- DML - Linguagem de Manipulação de Dados
-- DML: insert, select, update, delete
--------------------------------------------

------------------------------------------------------------------------
-- Comando INSERT = Criar novas linhas na tabela
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Inserindo dados na tabela Pessoas
------------------------------------------------------------------------
insert into Pessoas VALUES
('Teresa Cristina', '121.232.434-34', 1)
GO

insert into Pessoas VALUES
('Luisa Barral', '234.345.456-98', 2)
GO

insert into Pessoas VALUES
('Samuel Jesus', '241.425.647-09',1)
go

-- inserindo mais de um valor junto ao comando insert
insert into Pessoas VALUES
('Vivian Nadoti','111.111.111-11',3),
('Joao Alexandre','122.222.222-22',1),
('Gustavo Zanfolim','133.333.333-33',2)
GO

---------------------------------------------------------------------------

------------------------------------------------------------------------
-- Inserindo dados na tabela Clientes
------------------------------------------------------------------------
insert into Clientes VALUES
(2, 5500, 2000)
GO

insert into Clientes VALUES
(3, 8500,3000)
go

---------------------------------------------------------------------------

------------------------------------------------------------------------
-- Inserindo dados na tabela Vendedores
------------------------------------------------------------------------
insert into Vendedores VALUES
(1, 2000)
go

insert into Vendedores VALUES
(3, 1500)
GO

---------------------------------------------------------------------------

------------------------------------------------------------------------
-- Inserindo dados na tabela Produtos
------------------------------------------------------------------------
insert into Produtos VALUES
('Lapis', 100, 1.5, 1)

insert into Produtos (descricao, qtd, valor) 
VALUES ('Caneta', 100, 2)

insert into Produtos VALUES
('Caderno', 100, 15, 1),
('Borracha', 100, 3, 1),
('Regua', 100, 5.5, 1)
GO

insert into Produtos VALUES
('Apontador', 25, 2.3, 2)
GO

---------------------------------------------------------------------------

------------------------------------------------------------------------
-- Inserindo dados na tabela Pedidos
------------------------------------------------------------------------
insert into Pedidos (data,cliente_id, vendedor_id)
values (GETDATE(), 3, 1)
GO

insert into Pedidos (data,cliente_id, vendedor_id)
values (GETDATE(), 3, 3)
GO

insert into Pedidos (data,cliente_id, vendedor_id)
values (GETDATE(), 2, 1)
GO

insert into Pedidos (data,cliente_id, vendedor_id)
values (GETDATE(), 2, 3)
GO


---------------------------------------------------------------------------

------------------------------------------------------------------------
-- Inserindo dados na tabela Itens_Pedidos 
------------------------------------------------------------------------
insert into Itens_Pedidos 
VALUES (2, 4, 3, 3.0)
GO

insert into Itens_Pedidos 
VALUES (2, 5, 40, 5.3)
GO

insert into Itens_Pedidos 
VALUES (3, 1, 10, 1.5)
GO

insert into Itens_Pedidos 
VALUES (3, 3, 2, 15)
GO

insert into Itens_Pedidos 
VALUES (3, 4, 5, 3)
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Comando SELECT = Consulta/Recupera linhas da tabela
------------------------------------------------------------------------

-- Exibe a coluna id, nome, cpf e status da tabela Pessoas
SELECT IDPESSOA, NOME, CPF, STATUS FROM Pessoas
GO

-- Exibe a coluna id e nome da tabela Pessoas
SELECT IDPESSOA, NOME FROM Pessoas
GO

-- Exibe todas as colunas da tabela Pessoas
SELECT * from Pessoas
go

-- Exibe todas as colunas da tabela Clientes
SELECT * from Clientes
go

-- Exibe todas as colunas da tabela Vendedores
SELECT * from Vendedores
go

-- Exibe todas as colunas da tabela Produtos
SELECT * from Produtos
go

-- Exibe todas as colunas da tabela Pedidos
SELECT * from Pedidos
go

-- Exibe todas as colunas da tabela Itens_Pedidos
SELECT * from Itens_Pedidos
go

----------  Usando comando WHERE --------------------
-- exibe todas as colunas da tabela produtos
-- com a condicao de os dados possuirem na coluna valor o resultado igual ou maior que 5.0
SELECT * from Produtos 
where valor >= 5.0  
GO

----------  Usando comando WHERE --------------------
-- exibe todas as colunas da tabela produtos
-- com a condicao de os dados possuirem na coluna valor o resultado igual ou maior que 5.0 OU
-- na coluna status o valor ser igual a 2
SELECT * from Produtos 
where status = 2 OR valor >= 5.0
GO

----------  Usando comando WHERE --------------------
-- exibe todas as colunas da tabela produtos
-- com a condicao de os dados possuirem na coluna descriçao o resultado "Caderno"
SELECT * from Produtos 
where descricao = 'Caderno'
GO

----------  Usando comando WHERE --------------------
-- exibe todas as colunas da tabela produtos
-- com a condicao de os dados possuirem na coluna descriçao o resultado qualquer palavra com a letra no meio "a" >a<
SELECT * from Produtos 
where descricao like '%a%'
GO

----------  Usando comando WHERE --------------------
-- exibe todas as colunas da tabela produtos
-- com a condicao de os dados possuirem na coluna descriçao o resultado qualquer palavra que inicie com a letra "C" 
SELECT * from Produtos 
where descricao like 'C%'
GO

----------  Usando comando WHERE --------------------
-- exibe todas as colunas da tabela produtos
-- com a condicao de os dados possuirem na coluna descriçao o resultado qualquer palavra com a letra "a" na segunda posição e a letra e na quarta posição
SELECT * from Produtos 
where descricao like '_a_e%'
GO

----------  Usando comando WHERE --------------------
-- exibe todas as colunas da tabela produtos
-- com a condicao de os dados possuirem na coluna valor o resultado entre o 3 e o 10
SELECT * from Produtos 
where valor BETWEEN 3 and 10
GO

----------  Usando comando WHERE --------------------
-- exibe todas as colunas da tabela produtos
-- com a condicao de os dados possuirem na coluna valor o resultado entre >= 3 e <=10 
SELECT * from Produtos 
where valor >= 3 and valor <= 10
GO

-- Exibe as colunas descrição e quantidade da tabela Produtos, alterando seus nomes para visualização para Produto e qtd Disponivel
SELECT descricao Produto, qtd 'qtd Disponivel' from Produtos 
GO

-- Exibe as colunas descrição e quantidade da tabela Produtos, alterando seus nomes para visualização para Produto e qtd Disponivel 
-- utilizando [] ao inves de ' '
SELECT descricao Produto, qtd [qtd Disponivel] from Produtos 
GO

-- Exibe o resultado da conta em uma coluna chamada 'Resultado'
select 324324.76/23565.33 * PI() Resultado
GO

-- Exibe o resultado da raiz quadrada em uma coluna chamada 'Raiz'
select sqrt(16) Raiz
GO

-- Exibe em letras maiusculas todos os dados da coluna descricao alterando seu nome para Produto da tabela Produtos
select UPPER(descricao) Produto from Produtos
go

-- Exibe todas as colunas, pegando a coluna qtd vezes a coluna valor e colocando na coluna 'Faturamento', alterando o nome da tabela para p
select p.*, p.qtd * p.valor Faturamento 
from Produtos p
GO

-- Exibe todas as colunas, pegando a coluna qtd vezes a coluna valor e colocando na coluna 'Faturamento', sem alterar o nome da tabela
SELECT Produtos.*, Produtos.qtd * Produtos.valor Faturamento
from Produtos
GO

-- Exibe a quantidade de dados salvos da tabela Produtos em uma coluna chamada 'Qtd'
select COUNT(*) Qtd FROM Produtos
GO

-- avg = Calcula a média aritmética da coluna valor
-- max = Exibe o maior valor da coluna valor
-- min = Exibe o menor valor da coluna valor
-- count = conta quantos dados tem na tabela Produtos
-- SUM =  retorna a soma dos valores de entrada da coluna qtd
select  avg(valor) Media_Preco, max(valor) Maior_Valor,
        min(valor) Menor_Valor, COUNT(*) Qtd, 
        SUM(qtd) Unidades, SUM(qtd * valor) Total
from Produtos
GO

-- Exibe a quantidade de dados salvos da tabela Produtos em uma coluna chamada 'Total'
SELECT COUNT (idProduto)
AS Total
FROM Produtos
go

-- Lista o salário médio de cada vendedor da empresa
select avg(salario)
AS media_salarial
from Vendedores
GO

----------  Usando comando WHERE --------------------
-- exibe todas as colunas da tabela produtos
-- com a condição de exibir os de id 1,3,5
SELECT * FROM Produtos
WHERE idProduto in (1, 3, 5)
GO

----------  Usando comando WHERE --------------------
-- exibe todas as colunas da tabela produtos
-- com a condição de o id ser 1 ou 3 ou 5
SELECT * FROM Produtos
WHERE   idProduto = 1 OR
        idProduto = 3 OR
        idProduto = 5
GO

----------  Usando comando WHERE --------------------
-- exibe a somatoria da conta das colunas qtd * valor da tabela Itens_Pedidos na coluna 'Total Pedido'
-- com a condicao de o pedido_id for igual a 2
SELECT  sum(qtd * valor) 'Total Pedido'
from    Itens_Pedidos
where   pedido_id = 2
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Comando UPDATE = Permite atualizar registros em uma tabela
------------------------------------------------------------------------

--   Nome tabela     campo  =  novo valor         condição
UPDATE Produtos set qtd = qtd - 3 WHERE idProduto = 4

select * from Produtos
where idProduto = 4
go

-- Atualiza os valores da coluna qtd retirando 40 no produto de id 5
UPDATE Produtos set qtd = qtd - 40 WHERE idProduto = 5

select * from Produtos
where idProduto = 5
go

-- Atualiza os valores da coluna qtd retirando 10 no produto de id 1
UPDATE Produtos set qtd = qtd - 10 WHERE idProduto = 1

select * from Produtos
where idProduto = 1
go

-- Atualiza os valores da coluna qtd retirando 2 no produto de id 3
UPDATE Produtos set qtd = qtd - 2 WHERE idProduto = 3

select * from Produtos
where idProduto = 3
go

-- Atualiza os valores da coluna qtd retirando 5 no produto de id 4
UPDATE Produtos set qtd = qtd - 5 WHERE idProduto = 4

select * from Produtos
where idProduto = 4
go

-- Atualiza os valores da coluna status para 2 e o valor para 236 no pedido de id 2
UPDATE Pedidos set status = 2, valor = 236 WHERE idPedido = 2

select * from Pedidos
where idPedido = 2
go

-- Atualiza os valores da coluna status para 2 e o valor para 45 no pedido de id 3
UPDATE Pedidos set status = 2, valor = 45 WHERE idPedido = 3

select * from Pedidos
where idPedido = 3
go

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Comando DELETE = Permite que uma ou mais linhas sejam excluídas de uma tabela
------------------------------------------------------------------------

-- Remove da tabela produtos o produto que tiver o id 6
DELETE from Produtos where idProduto = 6

select * from Produtos
where idProduto = 6
go

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Comando VIEW´s = tabela virtual composta por linhas e colunas de dados
-- vindos de tabelas relacionadas em uma query (agrupamento de SELECT'S)
------------------------------------------------------------------------

------------------------------------------------------------------------
-- View simples para consultar todos os produtos da tabela de Produtos
------------------------------------------------------------------------

--         nome da view
create view v_prods
AS  -- select (colunas) from (tabelas)   
    select * from Produtos
GO

-- Para consultar os dados da view usamos o comando SELECT e o nome da view 
SELECT * from v_prods
go 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Comando ALTER VIEW = Atualiza uma view, após ela já ter sido criada e
-- necessitar de alterações
------------------------------------------------------------------------

-- Seleciona as colunas da tabela Produtos:
-- idProduto e muda o nome para Codigo,
-- descricao e muda o nome para Produto,
-- qtd e muda o nome para Estoque,
-- valor e muda o nome para Preco,
-- caso os valores da coluna status seja 1 altera para ativo,
-- caso os valores da coluna status seja 2 altera para inativo,
-- caso os valores da coluna status seja diferente de 1 e 2 altera para cancelado,
-- altera o nome da coluna status para Situacao.
ALTER view v_prods
as
    select  idProduto Codigo, descricao Produto, qtd Estoque, valor Preço,
            case status
                when 1 then 'Ativo'
                when 2 then 'Inativo'
                else 'Cancelado'
            end Situacao
    from    Produtos
go

SELECT * from v_prods
go 

------------------------------------------------------------------------
-- Comando DROP VIEW = Exclui uma view
------------------------------------------------------------------------

DROP view v_prods

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- criar uma view para consultar itens dos pedidos e calcular
-- valor de cada item do pedido. Saída no. do pedido, o produto 
-- comprado, a quantidade do produto, o valor unitário e o valor
-- total de cada item
------------------------------------------------------------------------

CREATE VIEW v_itens_pedidos
AS
    select  p.idPedido, p.data, p.valor, i.produto_id, i.qtd,
            i.valor valor_item, i.valor * i.qtd valor_total
    from    Pedidos p, Itens_Pedidos i
    where   p.idPedido = i.pedido_id
    order by p.idPedido
GO

select * from v_itens_pedidos
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------
-- Comando STORED PROCEDURE = Procedimento armazenado 
-- Conjunto de comando em SQL que podem ser executados de uma só vez
------------------------------------------------------------------------

-- Procedure para cadastrarmos produtos novos no Banco de Dados

CREATE PROCEDURE sp_cadProdutos (@desc varchar(50), @qtd int, @valor money, @status int)
AS
BEGIN
    INSERT into Produtos (descricao, qtd, valor, status)
    VALUES (@desc, @qtd , @valor , @status)
END
GO

--  Executando a procedure

EXEC sp_cadProdutos 'Mochila', 100,50.20,1
go  

SELECT * from produtos
go


----------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Comando INNER JOIN = Combina duas ou mais tabelas por meio de alguma 
-- chave ou valor comum entre as tabelas
------------------------------------------------------------------------

-- Exibe os dados da tabela Produtos e da tabela Itens_Pedidos
-- com a chave idProduto da tabela Produtos igual a idProduto da tabela Itens_Pedidos

-- sem inner join
SELECT *
from Produtos P, Itens_Pedidos Ipe
where P.idProduto = Ipe.idProduto
GO

-- com inner join
SELECT * 
FROM Produtos INNER JOIN Itens_Pedidos
ON Produtos.idProduto = Itens_Pedidos.idProduto
GO

-- exemplo de inner join alterando o nome das colunas
SELECT *
from Produtos P inner join Itens_Pedidos IPe
on P.idProduto = IPe.idProduto
go

-- Na junção das tabelas podemos usar o operador de igualdade (=), diferente (!=), maior (>), menor (<), maior ou igual (>=), menor ou igual (<=)
-- misturadas ao operadores AND, OR, NOT na claúsula WHERE

-- exemplo utilizando o operador de igualdade (=)
SELECT *
from Produtos P inner join Itens_Pedidos IPe
on P.idProduto = IPe.produto_id
where P.idProduto = 1
go

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Comando LEFT JOIN = Retorna todos os registros da tabela esquerda e os registros correspondentes da tabela direita.
-- Em resumo retorna todas as linhas da tabela “esquerda” A e as linhas correspondentes ou valores NULL da tabela “esquerda” A.
------------------------------------------------------------------------

-- exemplo utilizando o left join
-- onde não há registro na tabela esquerda é retornado um registro com valores NULL
SELECT *
from Produtos P left join Itens_Pedidos IPe
on P.idProduto = IPe.produto_id
go

-- sem usar o left join, na tabela não será exibido os registros q não tenham itens_pedidos
select * 
from Produtos P, Itens_Pedidos IPe
where P.idProduto = IPe.produto_id
go 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Comando RIGHT JOIN = Retorna todos os registros da tabela direita e os registros correspondentes da tabela esquerda.
--  Se uma linha na tabela direita B não tiver nenhuma linha correspondente da tabela “esquerda” A, a coluna da tabela “esquerda” A 
-- no conjunto de resultados será nula igualmente ao que acontece no LEFT JOIN.
------------------------------------------------------------------------

-- exemplo utilizando o right join
-- onde não há registro na tabela direita é retornado um registro com valores NULL
SELECT *
from Produtos P right join Itens_Pedidos IPe
on P.idProduto = IPe.produto_id
go

-- sem usar o right join, na tabela não será exibido os registros q não tenham itens_pedidos
select *
from Produtos P, Itens_Pedidos IPe
where P.idProduto = IPe.produto_id
go

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Comando FULL OUTER JOIN = retorna todas as linhas das tabelas unidas, correspondidas ou não, ou seja,
-- você pode dizer que a FULL JOIN combina as funções da LEFT JOIN e da RIGHT JOIN. 
-- FULL JOIN é um tipo de junção externa, por isso também é chamada junção externa completa.
------------------------------------------------------------------------

-- exemplo utilizando o full join
SELECT *
from Produtos P full join Itens_Pedidos IPe
on P.idProduto = IPe.produto_id
go

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Comando CROSS JOIN = retorna todas as linhas das tabelas por cruzamento, ou seja, 
-- para cada linha da tabela esquerda queremos todos os linhas da tabelas direita ou vice-versa.
-- Ele também é chamado de produto cartesiano entre duas tabelas.
-- Porém, para isso é preciso que ambas tenham o campo em comum, para que a ligação exista
-- entre as duas tabelas.
------------------------------------------------------------------------

-- exemplo utilizando o cross join
SELECT *
from Produtos P cross join Itens_Pedidos IPe
go

----------------------------------------------------------------------------------------------------------------------------------------------------------------------