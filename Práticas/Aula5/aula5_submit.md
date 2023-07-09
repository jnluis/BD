# BD: Guião 5


## ​Problema 5.1
 
### *a)*

```
Write here your answer e.g:
(π Pname, Pnumber (project)) ⨝ (π Fname, Lname, Ssn (employee))
```
### *b)* 

```
 π Fname, Lname, Super_ssn (employee) ⨝ Super_ssn = Ssn (π Ssn σ Fname='Carlos' and Minit='D' and Lname='Gomes' (employee)) 
```

### *c)* 
```
γ Pname;sum(Hours)->TotalHours (project ⨝ (Pnumber=Pno) works_on)
```

### *d)*
```
((π Fname, Minit, Lname, Ssn σ Dno=3 employee) ⨝ (π Pname σ Pname = 'Aveiro Digital' project ⨝ σ (Hours≥20) (works_on)))

```
### *e)* 
```
σ Essn=null (employee ⟕ Ssn=Essn works_on)
```

### *f)* 

```
γ Dname,Sex;avg(Salary)-> Avg_Salary (σ Sex='F' (department ⨝ Dno = Dnumber (employee))
```

### *g)* 

```
π Ssn, Fname, Lname employee ⨝ Ssn=Essn ( σ Dependents>=2 (γ Essn; count(Essn)->Dependents (dependent)))
-- o Ssn e o Essn não eram necessários ser mostrados, apenas foi para verificar que estavam iguais
```


### *h)* 

```
π Fname,Minit,Lname (σ Essn=null (dependent ⟖ (Essn=Mgr_ssn) (employee ⨝ Ssn=Mgr_ssn (department))))
```


### *i)* 

```
σ nProjetos ≥ 1 (γFname,Lname,Address;count(Pnumber)-> nProjetos (σ Dlocation ≠ 'Aveiro' (dept_location ⨝ Dnumber=Dno (σ Plocation = 'Aveiro' (project ⨝ Pnumber=Pno (works_on ⨝ Essn=Ssn (employee)))))))
```


## ​Problema 5.2

### *a)*
```
π nome,numero (σ numero=null (fornecedor ⟕(nif=fornecedor) encomenda)) 
```
### *b)* 

```
γ codProd;avg(unidades) -> MED_UNIDADES_PRODUTO item
```


### *c)* 

```
γ avg(total_product)-> media  (γ numEnc; count(numEnc)-> total_product (item))
```


### *d)* 

```
γ fornecedor.nome,produto.nome; sum(item.unidades)->UnidadesTotal (produto⨝codigo=codProd (π nome,codProd,unidades (item⨝numEnc=numero (fornecedor⨝nif=fornecedor encomenda))))
```


## ​Problema 5.3

### *a)*
```
σ nUtente=null (paciente ⟕ numUtente=nUtente ρ nUtente←numUtente (prescricao))
```
### *b)* 
```
γ especialidade;count(especialidade)->nPresc (medico ⨝ numSNS = numMedico prescricao)
```

### *c)* 
```
γ nome;count(nome)->nPresc (farmacia ⨝ farmacia = nome prescricao)
```
### *d)* 
```
σ numPresc=null (σ numRegFarm=906 (farmaco) ⨝ nome=nomeFarmaco σ numRegFarm = 906 (presc_farmaco))
```
### *e)* 
```
γ farmacia.nome, farmaceutica.nome; count(farmaco.nome)->nFarmacos (farmaceutica ⨝(numReg=farmaco.numRegFarm) (farmaco ⨝(farmaco.nome=presc_farmaco.nomeFarmaco) (presc_farmaco ⨝(presc_farmaco.numPresc=prescricao.numPresc) (farmacia ⨝(nome=farmacia) prescricao))))
```
### *f)* 
```
(πpaciente.nome σ nMedicos>1 (γpaciente.nome;count(medico.nome)->nMedicos (π paciente.nome,medico.nome (medico ⨝(medico.numSNS=prescricao.numMedico) (paciente ⨝(paciente.numUtente=prescricao.numUtente) prescricao)))))
```