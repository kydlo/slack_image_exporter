#!/bin/sh
# for .json in "$@"

tmp_dir=$(mktemp -dt slack_image_export)
[[ -d $tmp_dir ]] || (echo Could not create directory && exit 1)
pushd $tmp_dir &> /dev/null
open $tmp_dir

touch imageurls.txt
touch imageurls1line.txt
popd

# save general/2016-01-02.json
# transform this into variable general-2016-01-02

# Find the first folder in the archive
# find . -mindepth 1 -maxdepth 1 -type d

# for *.json in -d

if ! [[ -d "$1"/general ]]; then
	echo "Are you use sure this is a slack archive?"
	exit 2
fi

cd "$1"
for f in *; do
	if [[ -d $f ]]; 
		then
			cd $f
			echo `pwd`
			for j in *; do
				if [[ *.json ]]; then
					grep "url_private_download" $j >> $tmp_dir/imageurls.txt
				fi
			done
	fi
done

# grep "url_private_download" "$1"/general/ >> imageurls.txt

cat $tmp_dir/imageurls.txt | tr "\n" " " | $tmp_dir/imageurls1line.txt

# for 
sanitizedURL=$(cat $tmp_dir/imageurls1line.txt | cut -d " " -f2 | tr -d "\\" | cut -d "," -f1 | cut -d '"' -f2)
# 
open $sanitizedURL



