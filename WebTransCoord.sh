#!/bin/bash -   
#title          :WebTransCoord.sh
#description    :Transformção de coordenadas com o serviço REST(WebTransCoord) da DGT
#author         :apinhal
#date           :20201129
#=======


usage() {

  echo "Usage: ${0##*/} [-h] [-am arg] [-cH arg,arg]" 1>&2
  echo
  echo "Transformção de coordenadas com o serviço REST(WebTransCoord) da Direção-Geral do Território."
  echo
  echo "Options:"
  echo "  -a area: Portugal%20Continental¹ | Madeira | Acores"
  echo "  -c crsin,crsoit (EPSG code): 27493,3763¹"
  echo "  -H altin,altout: Elipsoidal,Ortometrica¹"
  echo "  -m metodo: grelhas¹ | bursaWolf"
  echo "  ¹default"
  echo
  echo "Example:"
  echo "  WebTransCoord.sh -c 4258,3763 -H Elipsoidal,Ortometrica"

  exit 1
}

get_url() { # REST request

  URL="http://cgpr.dgterritorio.pt/webtranscoord/transformar?x=$1&y=$2&z=$3&area=$area&crsin=$crsin&crsout=$crsout&altin=$altin&altout=$altout&metodo=$metodo"
  #echo $fullURL
  curl -s $URL
}

print_error() {
  
  echo "input error"
}


# default input argumets
area="Portugal%20Continental"
crsin="27493"
crsout="3763"
altin="Elipsoidal"
altout="Ortometrica"
metodo="grelhas"

while getopts "a:c:H:m:h" opt; do

  IFS=,
  case $opt in
    a) area=$OPTARG ;;

    c) crs=($OPTARG)
        crsin=${crs[0]}
        crsout=${crs[1]} ;;
     
    H) alt=($OPTARG)
        altin=${alt[0]}
        altout=${alt[1]} ;;

    m) metodo=$OPTARG ;;

    h) usage
       exit 0 ;;

    *) usage
       exit 1 ;;
  esac

done
shift $((OPTIND - 1))


reg="^[+-]?[0-9]+([.][0-9]+)?$"   # regex: decimal number 
while IFS=" " read -r -a xyz; do  # input 2d or 3d

  case ${#xyz[@]} in # check number of elements of array: xyz
  2)
    if [[ ${xyz[0]} =~ $reg ]] && [[ ${xyz[1]} =~ $reg ]]; then # validate 2d input

	  get_url ${xyz[0]} ${xyz[1]} 0 | awk -F';' '{print $1" "$2}'
    
	else
	  print_error
	fi
	;;

  3)
    if [[ ${xyz[0]} =~ $reg ]] && [[ ${xyz[1]} =~ $reg ]] && [[ ${xyz[2]} =~ $reg ]]; then # validate 3d input
	
	  get_url ${xyz[0]} ${xyz[1]} ${xyz[2]} | awk -F';' '{print $1" "$2" "$3}'
	
	else
	  print_error
	fi
	;;

  *)
    print_error
	;;
  esac

done
