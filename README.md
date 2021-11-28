# REST Web TransCoord DGT

Shell script para transformação de coordenadas com o serviço [REST(Web TransCoord)](https://www.dgterritorio.gov.pt/geodesia/transformacao-coordenadas/Web-TransCoord) da Direção-Geral do Território (DGT). Disponível na página [Web TransCoord](http://cgpr.dgterritorio.pt/webtranscoord/).

```txt
Usage: WebTransCoordDGT.sh [-hl] [-am arg] [-cH arg,arg]

Transformção de coordenadas com o serviço REST(WebTransCoord) da DGT

Default arguments:
  WebTransCoordDGT.sh -m grelhas -c 27493,3763

Options:
  -a area: Portugal%20Continental¹ | Madeira | Acores
  -c crsIN,crsOUT (EPSG codes): 27493,3763¹
  -H altIN,altOUT: Ortometrica,Ortometrica¹ | Elipsoidal
  -m metodo: grelhas¹ | bursaWolf
  -h help
  -l lista de Sistemas de Referência disponíveis
  ¹default

Examples:
  WebTransCoordDGT.sh -c 4258,3763 -H Elipsoidal,Ortometrica
  WebTransCoordDGT.sh -a Madeira -c 3061,5016 -m bursaWolf
```

## Lista de Sistemas de Referência disponíveis [PDF DGT](https://www.dgterritorio.gov.pt/sites/default/files/ficheiros-geodesia/CodigosWebTransCoord.pdf)

### `-a Portugal%20Continental -m grelhas | bursaWolf`
|EPSG|Nome|
|:----|:-|
|4258 |ETRS89|
|3763 |ETRS89/PT-TM06|
|4274 |Datum73|
|27493|Datum73/Hayford-Gauss|
|4207 |Datum Lisboa|
|5018 |Datum Lisboa/Hayford-Gauss|
|20790|Datum Lisboa/Hayford-Gauss falsa origem (Coordenadas Militares)|

### `-a Acores -m bursaWolf`
|EPSG|Nome|
|:----|:-|
|5013 |ITRF93|
|5014 |ITRF93/PTRA08-UTM25N|
|5015 |ITRF93/PTRA08-UTM26N|
|2188 |Datum Observatório - Flores/UTM25N|
|2189 |Datum Base SW - Graciosa/UTM26N|
|2190 |Datum S.Braz - S.Miguel/UTM26N|

### `-a Madeira -m bursaWolf`
|EPSG|Nome|
|:----|:-|
|5013 |ITRF93|
|5016 |ITRF93/PTRA08-UTM28N|
|3061 |Datum Base SE/UTM28N|

## Exemplos de utilização
```sh
➜  WebTransCoord.sh -c 4274,3763                        
-8.532 38.5671
-34687.36 -122085.75
-8.532 38.5671 234
-34687.36 -122085.75 233.09

➜  echo -8.532 38.5671 234 | WebTransCoord.sh -c 4274,3763 -H Elipsoidal,Ortometrica -m grelhas
-34687.36 -122085.75 233.09

➜  cat fileIN.txt | WebTransCoordDGT.sh > fileOUT.txt
```
