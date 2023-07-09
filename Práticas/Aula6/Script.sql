-- SELECT * FROM pubs.dbo.authors; dá assim também
-- USE pubs;
-- GO

-- SELECT * FROM authors
--SELECT * FROM publishers

-- alinea G
-- SELECT DISTINCT pub_name
-- FROM publishers JOIN titles ON publishers.pub_id = titles.pub_id
-- WHERE type= 'business'

-- alinea J
-- SELECT title -- , stor_name -- só para ver que são todos do Bookbeat
-- FROM titles JOIN sales ON titles.title_id = sales.title_id JOIN stores ON sales.stor_id = stores.stor_id
-- WHERE stor_name= 'Bookbeat'

-- alinea L
-- SELECT [type], pub_id, AVG(price) AS preço_medio, SUM(qty) AS N_total_vendas  
-- FROM titles join sales on titles.title_id = sales.title_id
-- GROUP BY [type] , pub_id

-- alinea o
-- SELECT title, ytd_sales, ytd_sales * price as facturacao, (ytd_sales * price) *(CAST (royalty as decimal(8,3))/100) auths_revenue,
-- price*ytd_sales*(100-royalty)*1/100 as publisher_revenue
-- FROM titles

-- alinea q
-- Lista de lojas que venderam pelo menos um exemplar de todos os livros;

-- SELECT stor_name, count(title) as N_titles
-- FROM stores JOIN sales ON stores.stor_id = sales.stor_id 
-- JOIN titles ON sales.title_id = titles.title_id 
-- GROUP BY stor_name
-- HAVING count(title) >= (SELECT count(title) FROM titles)

-- alinea r
--  Select count(titles.title_id) as total_books_sold, stores.stor_name,count(sales.title_id) as books_sold FROM
-- titles JOIN (
--     stores JOIN 
--     sales ON stores.stor_id = sales.stor_id
-- ) on titles.title_id = sales.title_id
-- group by stores.stor_name
-- HAVING COUNT(sales.title_id) > (
--     SELECT AVG(book_counts.books_sold) as avg_books
--     FROM (
--         SELECT COUNT(sales.title_id) AS books_sold 
--         FROM sales 
--         GROUP BY sales.stor_id
--     ) book_counts ) 

-- alinea s
-- Basicamente o except é a diferença entre conjuntos
-- SELECT title 
-- FROM titles
-- EXCEPT( 
-- SELECT titles.title
-- FROM titles JOIN sales on titles.title_id = sales.title_id 
-- JOIN stores ON stores.stor_id = sales.stor_id 
-- WHERE stor_name = 'Bookbeat');

USE master;
GO

-- alinea a
-- Lista dos fornecedores que nunca tiveram encomendas;

-- SELECT NIF,Nome,FAX,Endereco,CondPag,Tipo
-- FROM Stocks.fornecedor 
-- INNER JOIN Stocks.encomenda ON fornecedor.nif = encomenda.nif 
-- WHERE numeroID IS NULL;

-- SELECT NIF,Nome,FAX,Endereco,CondPag,Tipo
-- FROM Stocks.fornecedor
-- LEFT JOIN Stocks.encomenda encomenda ON fornecedor.nif = encomenda.fornecedor
-- WHERE encomenda.numeroID IS NULL

-- alinea b
-- SELECT codProd, AVG(unidades) AS media_unidades
-- FROM Stocks.item
-- GROUP BY codProd

-- alinea c
-- SELECT * FROM Stocks.item;
-- SELECT Numero, avg(Unidades) as NumUnidades
-- FROM Stocks.Item
-- GROUP BY Numero;

-- alinea d
-- SELECT fornecedor.nome AS nome_fornecedor, produto.nome AS nome_produto, SUM(item.unidades) AS UnidadesTotal
-- FROM Stocks.fornecedor
-- INNER JOIN Stocks.encomenda ON fornecedor.nif = encomenda.fornecedor
-- INNER JOIN Stocks.item ON encomenda.numeroID = item.numero
-- INNER JOIN Stocks.produto ON item.codProd = produto.codigo
-- GROUP BY fornecedor.nome, produto.nome;
