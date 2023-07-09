# BD: Guião 6

## Problema 6.1

### *a)* Todos os tuplos da tabela autores (authors);

```
SELECT * FROM authors
```

### *b)* O primeiro nome, o último nome e o telefone dos autores;

```
SELECT au_fname,au_lname,phone FROM authors
```

### *c)* Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente); 

```
SELECT au_fname,au_lname,phone FROM authors
ORDER BY au_fname,au_lname
```

### *d)* Consulta definida em c) mas renomeando os atributos para (first_name, last_name, telephone); 

```
SELECT au_fname AS first_name, au_lname AS last_name , phone AS telephone FROM authors
ORDER BY au_fname,au_lname
```

### *e)* Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’; 

```
SELECT au_fname AS first_name, au_lname AS last_name , phone AS telephone FROM authors
WHERE state = 'CA' and au_lname != 'Ringer'
ORDER BY au_fname,au_lname
```

### *f)* Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome; 

```
SELECT pub_name 
FROM publishers
WHERE pub_name LIKE '%Bo%';
```

### *g)* Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’; 

```
SELECT DISTINCT pub_name
FROM publishers JOIN titles ON publishers.pub_id = titles.pub_id
WHERE type= 'business'
```

### *h)* Número total de vendas de cada editora; 

```
SELECT publishers.pub_id, pub_name, COUNT(ord_num)
FROM sales JOIN titles on sales.title_id = titles.title_id JOIN publishers on publishers.pub_id = titles.pub_id
GROUP by publishers.pub_id, pub_name
```

### *i)* Número total de vendas de cada editora agrupado por título; 

```
SELECT title, pub_name, COUNT(ord_num) as Count
FROM sales JOIN titles on sales.title_id = titles.title_id JOIN publishers on publishers.pub_id = titles.pub_id
GROUP by title, pub_name
```

### *j)* Nome dos títulos vendidos pela loja ‘Bookbeat’; 

```
SELECT title , stor_name -- só para ver que são todos do Bookbeat
FROM titles JOIN sales ON titles.title_id = sales.title_id JOIN stores ON sales.stor_id = stores.stor_id
WHERE stor_name= 'Bookbeat'
```

### *k)* Nome de autores que tenham publicações de tipos diferentes; 

```
SELECT au_fname, au_lname, COUNT(Distinct type) as Count
FROM authors as A JOIN titleauthor  as TA on TA.au_id = A.au_id JOIN titles as T on T.title_id = TA.title_id
GROUP by au_fname, au_lname
HAVING COUNT(Distinct type) > 1
```

### *l)* Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id);

```
SELECT [type], pub_id, AVG(price) AS preço_medio, SUM(qty) AS N_total_vendas
FROM titles join sales on titles.title_id = sales.title_id
GROUP BY [type] , pub_id
```

### *m)* Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);

```
SELECT type, MAX(advance) as Max
FROM titles
GROUP BY type
HAVING MAX(advance) > 1.5 * AVG(advance)
```

### *n)* Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;

```
SELECT title, au_fname, au_lname, price*royalty/100*royaltyper/100 as lucro
FROM titles JOIN titleauthor as TA ON TA.title_id = titles.title_id Join authors ON authors.au_id =  TA.au_id
GROUP BY title, au_fname, au_lname, royaltyper, royalty, price
```

### *o)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;

```
SELECT title, ytd_sales, ytd_sales * price as facturacao, (ytd_sales * price) (CAST (royalty as decimal(8,3))/100) auths_revenue, priceytd_sales(100-royalty)1100 as publisher_revenue
FROM titles
```

### *p)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, o nome de cada autor, o valor da faturação de cada autor e o valor da faturação relativa à editora;

```
SELECT title, ytd_sales, au_fname, au_lname, (ytd_sales * price) *(CAST (royalty as decimal(8,3))/100) auths_revenue,
price*ytd_sales*(100-royalty)*1/100 as publisher_revenue
FROM titles JOIN titleauthor as TA ON TA.title_id = titles.title_id Join authors ON authors.au_id =  TA.au_id
```

### *q)* Lista de lojas que venderam pelo menos um exemplar de todos os livros;

```
SELECT stor_name, count(title) as N_titles
FROM stores JOIN sales ON stores.stor_id = sales.stor_id 
JOIN titles ON sales.title_id = titles.title_id 
GROUP BY stor_name
HAVING count(title) >= (SELECT count(title) FROM titles)
```

### *r)* Lista de lojas que venderam mais livros do que a média de todas as lojas;

```
 Select count(titles.title_id) as total_books_sold, stores.stor_name,count(sales.title_id) as books_sold FROM
titles JOIN (
    stores JOIN 
    sales ON stores.stor_id = sales.stor_id
) on titles.title_id = sales.title_id
group by stores.stor_name
HAVING COUNT(sales.title_id) > (
    SELECT AVG(book_counts.books_sold) as avg_books
    FROM (
        SELECT COUNT(sales.title_id) AS books_sold 
        FROM sales 
        GROUP BY sales.stor_id
    ) book_counts )
```

### *s)* Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;
#### Basicamente o except é a diferença entre conjuntos
```
SELECT title 
FROM titles
EXCEPT( 
SELECT titles.title
FROM titles JOIN sales on titles.title_id = sales.title_id 
JOIN stores ON stores.stor_id = sales.stor_id 
WHERE stor_name = 'Bookbeat');
```

### *t)* Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora; 

```
(select pub_name, stor_name
from publishers,stores
group by pub_name, stor_name)
except
(select pub_name, stor_name
from (((publishers join titles on publishers.pub_id=titles.pub_id)
		join sales on titles.title_id=sales.title_id)
		join stores on sales.stor_id=stores.stor_id)
group by pub_name, stor_name)
```

## Problema 6.2

### ​5.1

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_1_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_1_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
select Ssn, Fname, Minit, Lname, Pno
from (Company.Employee join Company.Works_on on Ssn=Essn);
```

##### *b)* 

```
SELECT E.Fname, E.Minit, E.Lname
FROM Company.Employee AS E JOIN Company.Employee as S ON E.Super_ssn = S.Ssn
WHERE S.Fname = 'Carlos' AND S.Minit = 'D' AND S.Lname = 'Gomes';
```

##### *c)* 

```
SELECT Pname, Sum([Hours]) AS Num_of_Hours
FROM Company.Project AS P Join Company.Works_on as Work ON Work.Pno = P.Pnumber
GROUP BY Pname;

```

##### *d)* 

```
SELECT Fname, Lname, SUM([Hours]) AS Num_of_Hours
FROM Company.Employee AS E 
JOIN Company.Department as D ON D.Dnumber = E.Dno 
JOIN Company.Works_on AS W ON W.Essn = E.Ssn 
JOIN Company.Project AS P ON P.Pnumber = W.Pno
WHERE P.Pname = 'Aveiro Digital' AND E.Dno = 3
GROUP BY Fname, Lname
HAVING SUM([Hours]) > 20;
```

##### *e)* 

```
SELECT Ssn, Fname, Lname
FROM Company.Employee AS E 
LEFT JOIN Company.Works_on AS W ON W.Essn = E.Ssn 
WHERE Pno IS NULL
```

##### *f)* 

```
SELECT Dname, AVG(Salary) AS Average
FROM Company.Employee AS E
JOIN Company.Department AS D ON E.Dno = D.Dnumber
WHERE E.Sex = 'F'
GROUP BY Dname
```

##### *g)* 

```
SELECT Fname, Lname, Count(Essn) AS Num_of_Dependents
FROM Company.Employee AS E 
JOIN [Company.Dependent] as Dep ON E.Ssn = Dep.Essn
GROUP BY Fname, Lname
HAVING Count(Essn) > 2
```

##### *h)* 

```
SELECT Fname, Lname, Count(Dep.Essn) AS Num_of_Dependents
FROM Company.Employee AS E 
JOIN Company.Department AS D ON D.Mgr_Ssn = E.Ssn
LEFT JOIN [Company.Dependent] as Dep ON E.Ssn = Dep.Essn
GROUP BY Fname, Lname
HAVING Count(Dep.Essn) = 0
```

##### *i)* 

```
SELECT DISTINCT Fname, Lname, [Address]
FROM Company.Employee AS E 
JOIN Company.Works_on AS W ON E.Ssn = W.Essn
JOIN Company.Project AS P ON W.Pno = P.Pnumber
JOIN Company.Dept_locations AS D_Local ON E.Dno =  D_Local.Dnumber
WHERE Plocation = 'Aveiro' AND Dlocation != 'Aveiro'
```

### 5.2

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_2_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_2_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*
###### Usei LEFT JOIN em conjunto com a cláusula WHERE, de forma a selecionar apenas as linhas da tabela fornecedor que não têm correspondência na tabela encomenda.
```
SELECT NIF,Nome,FAX,Endereco,CondPag,Tipo
FROM Stocks.fornecedor
LEFT JOIN Stocks.encomenda encomenda ON fornecedor.nif = encomenda.fornecedor
WHERE encomenda.numeroID IS NULL
```

##### *b)* 

```
SELECT codProd, AVG(unidades) AS media_unidades
FROM Stocks.item
GROUP BY codProd
```


##### *c)* 

```
SELECT * FROM Stocks.item;
SELECT Numero, avg(Unidades) as NumUnidades
FROM Stocks.Item
GROUP BY Numero;
```


##### *d)* 

```
SELECT fornecedor.nome AS nome_fornecedor, produto.nome AS nome_produto, SUM(item.unidades) AS UnidadesTotal
FROM Stocks.fornecedor
INNER JOIN Stocks.encomenda ON fornecedor.nif = encomenda.fornecedor
INNER JOIN Stocks.item ON encomenda.numeroID = item.numero
INNER JOIN Stocks.produto ON item.codProd = produto.codigo
GROUP BY fornecedor.nome, produto.nome;
```

### 5.3

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_3_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_3_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT  P.numUtente, P.nome, dataNasc, endereco
FROM Prescricao.Paciente AS P LEFT JOIN Prescricao.Prescricao AS Presc ON Presc.numUtente = P.numUtente
WHERE numPresc is NULL
```

##### *b)* 

```
SELECT especialidade, count(numPresc) AS Num_Prescricoes
FROM Prescricao.Medico JOIN Prescricao.Prescricao ON numMedico != numSNS
GROUP BY especialidade
```


##### *c)* 

```
SELECT nome, count(numPresc) AS Num_Prescricoes
FROM Prescricao.Farmacia JOIN Prescricao.Prescricao ON nome = farmacia
GROUP BY nome
```


##### *d)* 

```
SELECT nome, formula, F.numRegFarm
FROM Prescricao.Farmaco AS F LEFT JOIN Prescricao.Presc_Farmaco AS PF ON nome = nomeFarmaco
WHERE F.numRegFarm = 906 AND PF.numPresc is NULL
```

##### *e)* 

```
SELECT Farm.nome, F.nome, count(nomeFarmaco) AS Num_Vendidos
FROM Prescricao.Farmaceutica AS F JOIN Prescricao.Presc_farmaco AS PF ON F.numReg = PF.numRegFarm JOIN Prescricao.Prescricao AS P ON P.NumPresc =  PF.numPresc JOIN Prescricao.Farmacia as Farm ON Farm.nome = farmacia
GROUP BY Farm.nome, F.nome
```

##### *f)* 

```
SELECT DISTINCT U.numUtente, nome, count(numMedico) AS Num_Medicos_Dif
FROM Prescricao.Paciente AS U JOIN Prescricao.Prescricao AS P ON P.numUtente = U.numUtente
GROUP BY U.numUtente, nome
HAVING count(numMedico) > 1
```
