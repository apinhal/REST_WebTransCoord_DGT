#!/bin/bash -   
#title          :WebTransCoord.sh
#description    :Transformção de coordenadas com o serviço REST(WebTransCoord) da DGT
#author         :apinhal
#date           :20201127
#=======


# Text Style
tRED=$'\033[1;31m'      # Bold Light Red
tGREEN=$'\033[1;32m'    # Bold Light Green
tBold=$'\033[1m'        # Bold
tNS=$'\033[0m'          # No Style


#
## usage
if [ "$1" == "" ] || [ "$1" == "-h" ]; then
    
    echo "${tBold}usage:${tNS} ${0##*/} crsin crsout Elipsoidal Ortometrica"
    exit 1
fi


#
## CRS available
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
#
#
## CRS i/o
crsin=$1 #$4 # 3763
crsout=$2 #$5 # 4258


# Datum Transform
metodo="grelhas" #(default)
#metodo="bursaWolf"


# if z used
#altin="Elipsoidal"
#altout="Ortometrica"
altin=$3
altout=$4
#altout=""
#altout="Elipsoidal"


getWTC() { # REST request
	
	fullURL="http://cgpr.dgterritorio.pt/webtranscoord/transformar?x=$1&y=$2&z=$3&area=$area&crsin=$crsin&crsout=$crsout&altin=$altin&altout=$altout&metodo=$metodo"
	#echo $fullURL
	curl -s $fullURL
}

errorPrint() {
	
	echo "${tRED}input error${tNS}"
}


reg="^[+-]?[0-9]+([.][0-9]+)?$"   # regex: decimal number 
while IFS=" " read -r -a xyz; do  # input 2d or 3d	

	case ${#xyz[@]} in # check number of elements of array: xyz 
	2)
	 if [[ ${xyz[0]} =~ $reg ]] && [[ ${xyz[1]} =~ $reg ]]; then # validate 2d input

		getWTC ${xyz[0]} ${xyz[1]} 0 | awk -F';' '{print $1" "$2}'
	 else
	 	errorPrint
	 fi
	;;

	3)
	 if [[ ${xyz[0]} =~ $reg ]] && [[ ${xyz[1]} =~ $reg ]] && [[ ${xyz[2]} =~ $reg ]]; then # validate 3d input
	
		getWTC ${xyz[0]} ${xyz[1]} ${xyz[2]} | awk -F';' '{print $1" "$2" "$3}'
	 else
		errorPrint
	 fi
	 ;;

	*)
	 errorPrint
	esac

done
