#!/bin/bash

# webTransCoord.sh 0 0 0 3763 4258

# Text Style
tRED=$'\033[1;31m'      # Bold Light Red
tGREEN=$'\033[1;32m'    # Bold Light Green
tBold=$'\033[1m'        # Bold
tNS=$'\033[0m'          # No Style

#
## usage
if [ "$1" == "" ] || [ "$1" == "-h" ]; then
    
    echo "${tBold}usage:${tNS} ${0##*/} crsin crsout"
    exit 1
fi

#x=$1
#y=$2
#z=$3 # optional
# if z used
altin="Elipsoidal"
altout="Ortometrica"
#altout=""
#altout="Elipsoidal"


# "Portugal Continental" /  Acores / Madeira
area="Portugal%20Continental"
#EPSG
# 4258 - ETRS89
# 3763 - ETRS89/PT-TM06
# 4274 - Datum73
# 27493 - Datum73/Hayford-Gauss
# 4207 - DatumLisboa
# 5018 - DatumLisboa/Hayford-Gauss
# 20790 - DatumLisboa/Hayford-Gauss_FalsaOrigem
#
# 5013 - ITRF93 - Acores|Madeira
#area="Acores"
# 5014 - ITRF93/PTRA08_UTM25N
# 2188 - DatumObservatório/UTM25N
# 5015 - ITRF93/PTRA08_UTM26N
# 2188 - DatumBaseSW/UTM26N
# 2190 - DatumSBraz-SMiguel/UTM26N
#area="Madeira"
# 5016 - ITRF93/PTRA08_UTM28N
# 3061 - DatumBaseSE/UTM28N

crsin=$1 #$4 # 3763
crsout=$2 #$5 # 4258


# Datum Transform
metodo="grelhas" #(default)
#metodo="bursaWolf"

#fullURL="http://cgpr.dgterritorio.pt/webtranscoord/transformar?x=$x&y=$y&z=$z&area=$area&crsin=$4&crsout=$5&altin=$altin&altout=$altout&metodo=$metodo"
#echo $fullURL
#curl -s $fullURL | awk -F';' '{print $1" "$2" "$3}'

#xyURL="http://cgpr.dgterritorio.pt/webtranscoord/transformar?x=$x&y=$y&area=$area&crsin=$4&crsout=$5&metodo=$metodo"
#echo $xyURL
#curl -s $xyURL | awk -F';' '{print $1" "$2}'




reg='^[+-]?[0-9]+([.][0-9]+)?$' # decimal n regex
while :
do

	read -a coord


	if [[ ${coord[0]} =~ $reg ]] && [[ ${coord[1]} =~ $reg ]] && [[ ${coord[2]} =~ $reg ]]; then
	
		fullURL="http://cgpr.dgterritorio.pt/webtranscoord/transformar?x=${coord[0]}&y=${coord[1]}&z=${coord[2]}&area=$area&crsin=$crsin&crsout=$crsout&altin=$altin&altout=$altout&metodo=$metodo"
		#echo $fullURL
		curl -s $fullURL | awk -F';' '{print $1" "$2" "$3}'
	else
		echo 'input error'
	fi
done
