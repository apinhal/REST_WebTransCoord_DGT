#!/bin/bash -
#title          :WebTransCoord.sh
#description    :Transformção de coordenadas com o serviço REST(WebTransCoord) da DGT
#author         :apinhal
#date           :20201201
#=======


usage() {

  echo "Usage: ${0##*/} [-h] [-am arg] [-cH arg,arg]"
  echo
  echo "Transformção de coordenadas com o serviço REST(WebTransCoord)" 
  echo "da Direção-Geral do Território."
  echo
  echo "Options:"
  echo "  -a area: Portugal%20Continental¹ | Madeira | Acores"
  echo "  -c crsin,crsoit (EPSG codes): 27493,3763¹"
  echo "  -H altin,altout: Elipsoidal,Ortometrica¹"
  echo "  -m metodo: grelhas¹ | bursaWolf"
  echo "  -h help"
  echo "  -l lista Sistemas de Referência disponíveis (EPSG Nome)"
  echo "  ¹default"
  echo
  echo "Examples:"
  echo "  ${0##*/} -c 3763,4258 -H Elipsoidal,Ortometrica"
  echo "  ${0##*/} -a Madeira -c 3061,5016 -H Elipsoidal,Ortometrica -m bursaWolf"
}


get_url() { # REST request

  url="http://cgpr.dgterritorio.pt/webtranscoord/transformar?x=$1&y=$2&z=$3&area=$area&crsin=$crsin&crsout=$crsout&altin=$altin&altout=$altout&metodo=$metodo"
  curl -s $url
}


print_error() {
  
  echo "input error"
}


print_epsg_list() {

echo "Lista de Sistemas de Referência (EPSG  Nome)

  Portugal Continental (-m grelhas|bursaWolf)
  4258  ETRS89
  3763  ETRS89/PT-TM06
  4274  Datum73
  27493 Datum73/Hayford-Gauss
  4207  Datum Lisboa
  5018  Datum Lisboa/Hayford-Gauss
  20790 Datum Lisboa/Hayford-Gauss falsa origem (Coordenadas Militares)

  Açores (-m bursaWolf)
  5013  ITRF93
  5014  ITRF93/PTRA08-UTM25N
  5015  ITRF93/PTRA08-UTM26N
  2188  Datum Observatório - Flores/UTM25N
  2189  Datum Base SW - Graciosa/UTM26N
  2190  Datum S.Braz - S.Miguel/UTM26N

  Madeira (-m bursaWolf)
  5013  ITRF93
  5016  ITRF93/PTRA08-UTM28N
  3061  Datum Base SE/UTM28N"
}


# check if curl exists
if ! command -v curl >/dev/null 2>&1; then
    
  echo "curl is not installed. Please install it first."
  exit 1
fi


# default input argumets
area="Portugal%20Continental"
crsin="27493"
crsout="3763"
altin="Elipsoidal"
altout="Ortometrica"
metodo="grelhas"
#
while getopts "a:c:H:m:lh" opt; do

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

    l) print_epsg_list
       exit 0 ;;

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
