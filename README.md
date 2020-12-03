## REST Web TransCoord DGT
Shell script para transformção de coordenadas com o serviço [REST(Web TransCoord)](https://www.dgterritorio.gov.pt/geodesia/transformacao-coordenadas/Web-TransCoord) da Direção-Geral do Território (DGT). Disponível na página [Web TransCoord](http://cgpr.dgterritorio.pt/webtranscoord/).

```txt
Usage: WebTransCoord.sh [-h] [-am arg] [-cH arg,arg]

Transformção de coordenadas com o serviço REST(WebTransCoord)
da Direção-Geral do Território.

Options:
  -a area: Portugal%20Continental¹ | Madeira | Acores
  -c crsin,crsoit (EPSG codes): 27493,3763¹
  -H altin,altout: Elipsoidal,Ortometrica¹
  -m metodo: grelhas¹ | bursaWolf
  -h help
  -l lista Sistemas de Referência disponíveis (EPSG Nome)
  ¹default

Examples:
  WebTransCoord.sh -c 3763,4258 -H Elipsoidal,Ortometrica
  WebTransCoord.sh -a Madeira -c 3061,5016 -H Elipsoidal,Ortometrica -m bursaWolf
```

### Lista de Sistemas de Referência disponíveis [PDF DGT](https://www.dgterritorio.gov.pt/sites/default/files/ficheiros-geodesia/CodigosWebTransCoord.pdf)

#### `-a Portugal%20Continental -m grelhas | bursaWolf`
|EPSG|Nome|
|:----|:-|
|4258 |ETRS89|
|3763 |ETRS89/PT-TM06|
|4274 |Datum73|
|27493|Datum73/Hayford-Gauss|
|4207 |Datum Lisboa|
|5018 |Datum Lisboa/Hayford-Gauss|
|20790|Datum Lisboa/Hayford-Gauss falsa origem (Coordenadas Militares)|

#### `-a Acores -m bursaWolf`
|EPSG|Nome|
|:----|:-|
|5013 |ITRF93|
|5014 |ITRF93/PTRA08-UTM25N|
|5015 |ITRF93/PTRA08-UTM26N|
|2188 |Datum Observatório - Flores/UTM25N|
|2189 |Datum Base SW - Graciosa/UTM26N|
|2190 |Datum S.Braz - S.Miguel/UTM26N|

#### Madeira `-m bursaWolf`
|EPSG|Nome|
|:----|:-|
|5013 |ITRF93|
|5016 |ITRF93/PTRA08-UTM28N|
|3061 |Datum Base SE/UTM28N|

### Exemplos Utilização
TODO
* pagina DGT exemplos
* echo
* cat

Exemplo 1
http://cgpr.dgterritorio.pt/webtranscoord/transformar?x=-8.4532&y=38.5671&area=Portugal%20Continental&crsin=4274&crsout=3763&metodo=grelhas
Resulta em:
-27819.44;-122112.59

Exemplo 2
http://cgpr.dgterritorio.pt/webtranscoord/transformar?x=-8.532&y=38.5671&z=234&area=Portugal%20Continental&crsin=4274&crsout=3763&altin=Elipsoidal&altout=Ortometrica&metodo=grelhas
Resulta em:
-34687.36;-122085.75;233.09
