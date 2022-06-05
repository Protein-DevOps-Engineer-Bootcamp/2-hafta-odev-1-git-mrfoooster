#!/bin/bash



echo "please select whether to use debug(d) or not"

read debug

read -p "debug(d) / dont use debug" db			#choosing debug mode or not for the user. d selects debug, anything else sets it to 0

if [ $db == 'd' ]; then
	set -x
else 
	set +x
fi

echo "Name of branch"					#branch naming

read branch

echo "Create $branch from main branch (n), from master (m) or something else(s)?"

read -p "main(n) / master(m) / something else(s) ?" cm	#selecting type of branch 

if [ $cm == 'n' ]; then
	git checkout -b  $branch
	echo "THIS IS A WARNING: YOU ARE BUILDING ON THE MAIN BRANCH"

elif [ $cm == 'm' ]; then
	git checkout master && git pull origin master && git checkout -b $branch
	echo "THIS IS A WARNING: YOU ARE BUILDING ON THE MASTER BRANCH"

elif [ $cm == 's' ]; then
	git checkout -b $branch
else
	echo "i'm out of time"
fi

cd /tmp
mkdir -p uni/corn/horn
touch uni/corn/horn/$branch

read -p "Zip(z) or Gzip(g) ?" kl  			#selecting compressed package type. 

if [ $kl == 'z' ]; then
	find uni/corn/horn -mtime -1 -type f -exec zip -r $branch.zip {} +
elif [ $kl == 'g' ]; then
	find uni/corn/horn -mtime -1 -type f -exec gzip {} \;
else
	break
fi





