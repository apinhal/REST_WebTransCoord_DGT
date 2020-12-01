## REST WebTransCoord DGT
Shell script para transformção de coordenadas com o serviço [REST(WebTransCoord)](https://www.dgterritorio.gov.pt/geodesia/transformacao-coordenadas/Web-TransCoord) da Direção-Geral do Território (DGT)

```shell
Usage: WebTransCoord.sh [-h] [-am arg] [-cH arg,arg]

Transformção de coordenadas com o serviço REST(WebTransCoord) da Direção-Geral do Território.

Options:
  -a area: Portugal%20Continental¹ | Madeira | Acores
  -c crsin,crsoit (EPSG code): 27493,3763¹
  -H altin,altout: Elipsoidal,Ortometrica¹
  -m metodo: grelhas¹ | bursaWolf
  ¹default

Example:
  WebTransCoord.sh -c 4258,3763 -H Elipsoidal,Ortometrica
```

### Lista de sistemas de referência disponiveis [pdf](https://www.dgterritorio.gov.pt/sites/default/files/ficheiros-geodesia/CodigosWebTransCoord.pdf) 
#### Portugal Continental `area="Portugal%20Continental"`
|EPSG|Nome|
|:----|:-|
|4258 |ETRS89|
|3763 |ETRS89/PT-TM06|
|4274 |Datum73|
|27493|Datum73/Hayford-Gauss|
|4207 |Datum Lisboa|
|5018 |Datum Lisboa/Hayford-Gauss|
|20790|Datum Lisboa/Hayford-Gauss com falsa origem (Coordenadas Militares)|

#### Açores `area="Acores"`
|EPSG|Nome|
|:----|:-|
|5013 |ITRF93|
|5014 |ITRF93/PTRA08-UTM25N|
|5015 |ITRF93/PTRA08-UTM26N|
|2188 |Datum Observatório - Flores/UTM25N|
|2189 |Datum Base SW - Graciosa/UTM26N|
|2190 |Datum S.Braz - S.Miguel/UTM26N|

####`area="Madeira"`
|EPSG|Nome|
|:----|:-|
|5013 |ITRF93|
|5016 |ITRF93/PTRA08-UTM28N|
|3061 |Datum Base SE/UTM28N|
