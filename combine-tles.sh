#!/bin/bash

# combine the individual NORAD TLEs in the cmb directory
DIRS=`find . -maxdepth 1 -type d -name '20*' | sort`
NORADIDS=`find . -maxdepth 1 -type f -name '*-NORAD-PRN.t'`

echo 'DIRS = '${DIRS}
echo 'NORADIDS = '${NORADIDS}

echo -n > /tmp/NORAD-all.t
for noradf in ${NORADIDS}
do
	cat ${noradf} >> /tmp/NORAD-all.t
done

# extract column with NORAD IDs and get uniq list
awk -F "," '{print $4}' /tmp/NORAD-all.t | sort | uniq > /tmp/NORAD-IDs.t
sed -i 's/.$//'  /tmp/NORAD-IDs.t

wc -l /tmp/NORAD-all.t
wc -l /tmp/NORAD-IDs.t
exit 2

for noradid in `cat ${NORADIDS} | sort`
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
