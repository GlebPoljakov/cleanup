#!/bin/sh
#
# script for cleaning directories
#
# Date: 2008_01_17
# Author: Gleb GByte Poljakov
# e-mail: gleb.poljakov@gmail.com
#
ver="0.02"
#

# -o $DIR
# -c $count
# -d $debug_level

#System vars
    log_tag="CleanUp v${ver} [${$}]"
    debug="1"					#debug level

#System procedures
    msg ()
    {
    	# Procedure for writing debug messages
		# $1 - message, $2 - level of the message (error, warning, notify)
    
		[ $2 -le $debug ] && logger -t "$log_tag" "$1"
    }
	usage ()
	{
		echo >&2 \
		"usage: $0 -c count -o DIR [-d debug_level]";
		exit 1;
	}

#parse command line
    while getopts c:d:o: opt
    do
	case "$opt" in
	    c)	count="$OPTARG";;
	    d)	debug="$OPTARG";;
	    o)	DIR="$OPTARG";;
	    \?)				#unknown
			usage;;
	esac
    done
    shift `expr $OPTIND - 1`

#Check for correct variable values:
    if [ ! -d "$DIR" ]; then
		echo "Directory ${DIR} d'not exist."
		usage;
		exit 1;
    fi;

#Run
	cd $DIR
	i=1
	
	for file in `ls -1t`; do
		if [ ${i} -gt ${count} ];then
			#forse recursively remove $file
			rm -fr $file
			msg "Remove $file." 0
		fi;
		i=$(($i+1))
		echo $file
	done;

