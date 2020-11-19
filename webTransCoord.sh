#! /bin/bash

# webTransCoord.sh 0 0 0 3763 4258

x=$1
y=$2
z=$3 # Opcional

# "Portugal Continental" /  Acores / Madeira
area="Portugal%20Continental"


crsin=$4 # 3763
crsout=$5 # 4258


#  if z used
altin="Elipsoidal" 
altout="Ortometrica"

# Datum Transform
metodo="grelhas"
metodo="bursaWolf"

#curl http://cgpr.dgterritorio.pt/webtranscoord/transformar\?x\=$lon\&y\=$lat\&z\=$hght\&area\=Portugal%20Continental\&crsin\=4274\&crsout\=3763\&altin\=Elipsoidal\&altout\=Ortometrica\&metodo\=grelhas
#curl http://cgpr.dgterritorio.pt/webtranscoord/transformar\?x\=$lon\&y\=$lat\&z\=$hght\&area\=Portugal%20Continental\&crsin\=27493\&crsout\=3763\&altin\=Elipsoidal\&altout\=Ortometrica\&metodo\=grelhas

#curl http://cgpr.dgterritorio.pt/webtranscoord/transformar\?x\=$lon\&y\=$lat\&z\=$hght\&area\=Portugal%20Continental\&crsin\=27493\&crsout\=3763\&altin\=Elipsoidal\&altout\=Ortometrica\&metodo\=grelhas

#curl -s http://cgpr.dgterritorio.pt/webtranscoord/transformar\?x\=$lon\&y\=$lat\&z\=$hght\&area\=Portugal%20Continental\&crsin\=$4\&crsout\=$5\&altin\=Elipsoidal\&altout\=Ortometrica\&metodo\=grelhas | awk -F';' '{print $1" "$2" "$3}'

#curl -s http://cgpr.dgterritorio.pt/webtranscoord/transformar\?x\=$x\&y\=$y\&z\=$z\&area\=Portugal%20Continental\&crsin\=$4\&crsout\=$5\&altin\=$altin\&altout\=$altout\&metodo\=$metodo | awk -F';' '{print $1" "$2" "$3}'

curl -s http://cgpr.dgterritorio.pt/webtranscoord/transformar\?x\=$x\&y\=$y\&z\=$z\&area\=$area\&crsin\=$4\&crsout\=$5\&altin\=$altin\&altout\=$altout\&metodo\=$metodo | awk -F';' '{print $1" "$2" "$3}'
