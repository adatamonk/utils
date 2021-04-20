#transfer
transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.digitalmonks.org/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.digitalmonks.org/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.digitalmonks.org/$file_name"|tee /dev/null;fi;}

#alias
alias shortcut='nano ~/.zshrc; source ~/.zshrc'

#cpu
alias cpu5="uptime | sed 's,.*,\x1B[35m&\x1B[0m,';ps -eo user,pid,%cpu,%mem,cmd --sort=-%cpu | head -6  | sed -e $'s/ *[^ ]* /\033[1;33m&\033[0m/3'"
alias dps='docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Command}}\t{{.RunningFor}}\t{{.Status}}"'

#autoscan
alias asdblist='sqlite3 /opt/autoscan/autoscan.db "SELECT * FROM scan"'
alias asdbcount='sqlite3 /opt/autoscan/autoscan.db ".headers off" ".mode line" "SELECT count(*) TOTAL, SUM(CASE WHEN folder like '"'"'%/television/%'"'"' THEN 1 ELSE 0 END) TV, SUM(CASE WHEN folder like '"'"'%/television-int/%'"'"' THEN 1 ELSE 0 END) TV_INT, SUM(CASE WHEN folder like '"'"'%/movies/%'"'"' THEN 1 ELSE 0 END) as MOVIES, SUM(CASE WHEN folder like '"'"'%/movies-int/%'"'"' THEN 1 ELSE 0 END) as MOVIES_INT, SUM(CASE WHEN folder like '"'"'%/audiobooks/%'"'"' THEN 1 ELSE 0 END) as AUDIOBOOKS, SUM(CASE WHEN folder like '"'"'%/audiobooks-int/%'"'"' THEN 1 ELSE 0 END) as AUDIOBOOKS_INT from scan;"'

#logs
alias plexlogs='tail -f /opt/plex/Library/Application\ Support/Plex\ Media\ Server/Logs/Plex\ Media\ Server.log'
alias aslogs='tail -f -n 50 /opt/autoscan/activity.log'
alias poller='sudo tail -f -n 50 /var/log/poller.log'
alias scantarget='tail -n 200 -f /opt/autoscan/activity.log | grep "Scan moved to target"'