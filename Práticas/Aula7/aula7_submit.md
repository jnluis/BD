# BD: Guião 7


## ​7.2 
 
### *a)*

```
Livro ( Titulo_Livro (A), Nome_Autor (B), Afiliacao_Autor (C), Tipo_Livro (D), Preco (E), NoPaginas (F), Editor (G), Endereco_Editor (H), Ano_Publicacao(I) ) 

Livro(_A_,_B_,C,D,E,F,G,H,I)
A,B -> D,F,G,I
D,F -> E
B -> C
G -> H

Está na primeira forma normal, pois os atributos são atómicos e como tem dependências parciais não pode estar na segunda.
```

### *b)* 

```
2ª Forma normal - 
    Livro - R1(_A_ ,_B_,D,E,F,G,I)
    Autor - R2(_B_,C)

    D,F -> E
    G -> H

3ª Forma normal - 
    Livro - R1(_A_,B,D,F,G,I)
    Autor - R2(_B_,C)
    Tipo_Livro - R3(E,_D_,_F_)
    Editor - R4(_G_,H)
```




## ​7.3
 
### *a)*

```
A e B
```


### *b)* 

```
R(_A_,_B_, C)
R2(_A_, D, E, I, J)
R3(_B_, F, G, H)

D -> I, J
F -> G, H
```


### *c)* 

```
R(_A_,_B_, C)
R2(_A_, D, E)
R3(_B_, F)
R4(_D_, I, J)
R5(_F_, G, H)
```


## ​7.4
 
### *a)*

```
A e B
```


### *b)* 

```
R(_A_, _B_, C, D)
R1(_D_, E)

C -> A
```


### *c)* 

```
R(_B_, C, D)
R1(_D_, E)
R2(_C_, A)

```



## ​7.5
 
### *a)*

```
A e B
```

### *b)* 

```
R(_A_, _B_, E)
R1(_A_, C, D)

C -> D
```


### *c)* 

```
R(_A_, _B_, E)
R1(_A_, C)
R2(_C_, D)

```

### *d)* 

```
Fica igual, pois já está na BCNF.
R(_A_, _B_, E)
R1(_A_, C)
R2(_C_, D)
```
