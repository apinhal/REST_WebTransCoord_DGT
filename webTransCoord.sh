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

# run
curl -s http://cgpr.dgterritorio.pt/webtranscoord/transformar\?x\=$x\&y\=$y\&z\=$z\&area\=$area\&crsin\=$4\&crsout\=$5\&altin\=$altin\&altout\=$altout\&metodo\=$metodo | awk -F';' '{print $1" "$2" "$3}'
