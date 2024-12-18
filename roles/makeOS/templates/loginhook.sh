#!/bin/bash

link_it () {

	desktop_dir="$HOME/Desktop"
	symlink_path=($HOME/Desktop/transfer $HOME/Downloads)
	source_path="/opt/transfer"
	desktop_files=$(find "$desktop_dir" -type f -name "*.desktop" 2>/dev/null)

	for i in ${symlink_path[*]}
	do
	if [ ! -e "$i" ]; then
	    ln -s "$source_path" "$i" >/dev/null 2>&1
	fi
	done


	for file in $desktop_files; do
	    chmod +x "$file"
	    dbus-launch gio set $file "metadata::trusted" true
	done

}



	if [ "$(id -u)" -eq 0 ] || [ "$(getent passwd "$(whoami)" | cut -d: -f7)" != "/bin/bash" ] && [ "$(getent passwd "$(whoami)" | cut -d: -f7)" != "/bin/sh" ]; then

	    :

	else
		link_it
	fi
