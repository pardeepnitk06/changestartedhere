#!/bin/bash
#!/bin/sh

########## VARIABLES
GAME_NAME=($2); GAME_TAG=$1
########## VARIABLES

########## FUNCTIONS
CheckOutGame(){
	local repo_game_dir="https://svn.ali.global/GDK_uslv/GDK_games/OnlineGames/Games/"
	#if[${GAME_SOURCE_PATHS[@]} > 1];
	
	#for i in ${GAME_NAME[@]}; do
	#local name = $(svn list --depth immediates $repo_game_dir) | grep $i
	local name=$((svn ls --depth immediates $repo_game_dir) | grep -iw "$1")
	

	if ["$name" == ""]; then continue; fi
	
	echo " gameName:  $name[@]"
	
	local array_length=${#name[@]};
	echo " array_length:  $array_length"
	#if [array_length -gt 2]; then continue; fi
	
	echo "https://svn.ali.global/GDK_uslv/GDK_games/OnlineGames/Games/${name}tags/$2"
	
	svn checkout "https://svn.ali.global/GDK_uslv/GDK_games/OnlineGames/Games/${name}tags/$2" "$1"
}

GameList(){
	local filename="gamedetails.txt"
	while IFS=$' ' read -r line || [[ -n "$line" ]]; do
		local i=0;
		for word in $line; do data[i]="$word"; i+=1; done 

		echo "name: ${data[0]}, tag:${data[1]}"
		CheckOutGame "${data[0]}" "${data[1]}"
	done < "$filename"
	
}


########## FUNCTIONS


##MAIN
GameList
##MAIN