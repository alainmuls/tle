#!/bin/bash

# combine the individual NORAD TLEs in the cmb directory
DIRS=`find . -maxdepth 1 -type d -name '20*' | sort`
NORADIDS=`find . -maxdepth 1 -type f -name '*-NORAD-only.t'`

# echo 'DIRS = '${DIRS}
# echo 'NORADIDS = '${NORADIDS}

for noradid in `cat ${NORADIDS}`
do
	echo ${noradid}
	norad_files=''
	for dir in ${DIRS}
	do
		# echo sat${noradid}.txt
		norad_files+=`find ${dir} -name sat${noradid}.txt`' '
		# echo 'norad files are: '${norad_files}
	done
	cat ${norad_files} > cmb/sat${noradid}.txt
	cd cmb
	sed -i '/^[[:space:]]*$/d' sat${noradid}.txt
	cd ..
done
