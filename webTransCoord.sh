#! /bin/bash

# webTransCoord.sh 0 0 0 3763 4258

x=$1
y=$2
z=$3 # optional

# "Portugal Continental" /  Acores / Madeira
area="Portugal%20Continental"
#area="Acores"
#area="Madeira"


crsin=$4 # 3763
crsout=$5 # 4258

#  if z used
altin="Elipsoidal" 
altout="Ortometrica"
#altout="Elipsoidal"

# Datum Transform
#metodo="grelhas" (default)
#metodo="bursaWolf"

fullURL="http://cgpr.dgterritorio.pt/webtranscoord/transformar?x=$x&y=$y&z=$z&area=$area&crsin=$4&crsout=$5&altin=$altin&altout=$altout&metodo=$metodo"
echo $fullURL
curl -s $fullURL | awk -F';' '{print $1" "$2" "$3}'

#xyURL="http://cgpr.dgterritorio.pt/webtranscoord/transformar?x=$x&y=$y&area=$area&crsin=$4&crsout=$5&metodo=$metodo"
#echo $xyURL
#curl -s $xyURL | awk -F';' '{print $1" "$2}'
