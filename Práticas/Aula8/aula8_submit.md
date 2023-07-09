# BD: Guião 8


## ​8.1. Complete a seguinte tabela.
Complete the following table.

| #    | Query                                                                                                      | Rows  | Cost  | Pag. Reads | Time (ms) | Index used | Index Op.            | Discussion |
| :--- | :--------------------------------------------------------------------------------------------------------- | :---- | :---- | :--------- | :-------- | :--------- | :------------------- | :--------- |
| 1    | SELECT * from Production.WorkOrder                                                                         | 72591 | 0.484 | 531        | 1171      | 1          | Clustered Index Scan |            |
| 2    | SELECT * from Production.WorkOrder where WorkOrderID=1234                                                  | 1      | 0.00328      | 2            | 19          | 1           | Clustered Index Seek                     |            |
| 3.1  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                               | 11      | 0.0032952       |20           | 43          | 1            |Clustered Index Seek                      |             |
| 3.2  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                   | 72591      | 0.4735      | 530           | 476           | 1            | Clustered Index Seek                     |            |
| 4    | SELECT * FROM Production.WorkOrder WHERE StartDate = '2012-05-09'                                          | 55       | 0.4735       | 530           | 90          | 1           |Clustered Index Scan                      |            |
| 5    | SELECT * FROM Production.WorkOrder WHERE ProductID = 757                                                   | 9       |0.03401       | 20            | 37          | 2            | Index Seek (NonClustered) e Key Lookup (Clustered)                      |            |
| 6.1  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              | 9       | 0.03401       | 20            | 20          | 2            | Index Seek (NonClustered) e Key Lookup (Clustered)                     |            |
| 6.2  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              | 1105       |0.4735       | 530            | 32           | 1            | Clustered Index Scan                      |            |
| 6.3  | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2012-05-09'            | 1      | 0.4735       | 530            | 3          | 1           | Clustered Index Scan                     |            |
| 7    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2012-05-09' | 1       | 0.4735      | 550           | 4          | 1           | Clustered Index Scan                     |            |
| 8    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2012-05-09' | 1       | 0.4735      | 530            | 2          | 1            | Clustered Index Scan                     |            |

## ​8.2.

### a)

```
ALTER TABLE myTemp ADD CONSTRAINT primaryMyTemp PRIMARY KEY CLUSTERED (rid) 
```

### b)

```
Percentagem de fragmentação: 99.28%
Ocupação das páginas:69.28%
```

### c)

| #    | FillFactor | Tempo (ms)  | Fragmentação (%)  | Ocupação de páginas (%) 
| :--- | :--- | :---- | :---- | :---- | 
| 1    | 65   | 45180 | 99.26 | 68.18 |    
| 2    |80    | 57796 | 99.00 | 60.15 | 
| 3    | 90   | 53470 | 99.05 | 60.32 |



### d)

| #    | FillFactor | Tempo (ms)  | Fragmentação (%)  | Ocupação de páginas (%) 
| :--- | :--- | :--- | :---- | :------ | 
| 1    | 0   | 44396 | 99.07 | 0.90    |    
| 2    | 65  | 47787 | 79.99 | 1.04    |    
| 3    | 80  | 48246 | 86.33 | 0.43    | 
| 4    | 90  | 49443 | 92.90 | 0.51    |


### e)

```
CREATE NONCLUSTERED INDEX ix_mytemp_at1 ON mytemp(at1);
CREATE NONCLUSTERED INDEX ix_mytemp_at2 ON mytemp(at2);
CREATE NONCLUSTERED INDEX ix_mytemp_at3 ON mytemp(at3);
CREATE NONCLUSTERED INDEX ix_mytemp_lixo ON mytemp(lixo);


Sem indices demorou 112540 ms
Com indices demorou 119743 ms

Com isto podemos concluir que a inserção de registos na tabela "mytemp" é mais lenta com índices do que sem índices. Isto acontece porque a criação de índices adicionais requer mais recursos do servidor.

```

## ​8.3.

```
i) CREATE INDEX idxSsn ON EMPLOYEE(Ssn);
ii) CREATE INDEX idxEmpName ON Employee(Fname, Lname);
ii) CREATE INDEX idxEmpDep ON Employee(Dno);
iv) CREATE INDEX idxWorksOnProj ON Works_On (Essn, Pnum);
v) CREATE INDEX idxDependent ON Dependent(Essn);
vi) CREATE INDEX idxProjectDnum ON Project(Dnum);


```
