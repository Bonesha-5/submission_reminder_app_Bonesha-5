#!/bin/bash

source ./create_environment.sh

file="./config/config.env"
if [[ -f $file ]]; then
	read -p "Enter name of assignment: " choice
	choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
	sed -i "s|^ASSIGNMENT=.*|ASSIGNMENT=\"$choice\"|" $file
	echo "Your input is being updated"
else
	echo "unable to access the file that contains the assignment"
fi
./startup.sh
