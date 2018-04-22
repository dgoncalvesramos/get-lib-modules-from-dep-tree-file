#!/bin/bash
version=

if [[ $# -eq 3 ]]
then
	case "$1" in
	-v) version=1
	;;
	*) echo "Usage ./getSubModules.sh [-v] lib depfile" 
		  exit 1 
	;;
	esac
	if [ ! -e $3 ]
	then
		echo "Depfile $3 does not exist"
		exit 1
	fi
elif [[ $# -eq 2 ]]
then
	if [ ! -e $2 ]
	then 
		echo "Depfile $2 does not exist"
		exit 1
	fi
else 
	echo "Usage ./getSubModules.sh [-v] lib depfile"
	exit 1
fi

if [ ! -z "$version" ]
then
 	awk -v lib="$2" -v depfile="$3" 'BEGIN { print "List of modules of " lib " lib in dependency tree file " depfile " with the associated versions:";
					 pattern = "^*"lib"$" 
					 FS=":";}
					 $1 ~ pattern { print $2":"$3  }
					 END {}
					 ' $3 | sort -u
else
	awk -v lib="$1" -v depfile="$2" 'BEGIN { print "List of modules of " lib " lib in dependency tree file " depfile " :";
                                         pattern = "^*"lib"$"
                                         FS=":";}
                                         $1 ~ pattern { print $2 }
                                         END {}
                                         ' $2 | sort -u
fi
