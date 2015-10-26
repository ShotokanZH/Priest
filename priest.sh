#!/usr/bin/env bash
#+------+
#|Priest|
#+-v1.0-+----------+
#|Brought to you by|
#|Shotokan@aitch.me|
#|https://aitch.me/|
#+-PGP-AHEAD-------+-----------+
#|https://keybase.io/shotokanzh|
#+-$BEGIN----------------------+

log="$(basename "$0").log";

function listdaemons {
	cd $1;
	echo "Testing $1..";
	for a in $(ls);
	do
		if [ -w "$a" ];
		then
			echo $'\t'"$a daemon is writable!!";
			ls -liah "$a";
		else
			if [ -r "$a" ];
			then
				file="$(cat "$a" | grep -i "<key>Program\(Arguments\)\?</key>" -A 2 | grep -io "<string>.*<\/string>" | sed -E 's/<\/?string>//g')" 2>/dev/null;
				if [ $? -eq 0 ];
				then
					if [ -w "$file" ];
					then
						echo $'\t'"$file is writable!";
						ls -liah "$a";
					else
						echo $'\t'"$file is not writable.. But check it!" >&2;
					fi;
					if [ -w "$(dirname "$file")" ];
					then
						echo $'\t'"$(dirname "$file") directory is writable!";
						ls -liah "$a";
					else
						echo $'\t'"$(dirname "$file") is not writable.." >&2;
					fi;
				fi;
			else
				echo $'\t'"File $a not readable" >&2;
			fi;
		fi;
	done;
}

echo "Writable daemons:" | tee "$log";
listdaemons /Library/LaunchDaemons/ | tee -a "$log";
listdaemons /System/Library/LaunchDaemons/ | tee -a "$log";
echo "STDOUT saved to $log";
