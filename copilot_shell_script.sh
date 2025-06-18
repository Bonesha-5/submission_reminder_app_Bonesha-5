#!/bin/bash

echo " "
main_dir=$(find . -type d -name "submission_reminder_*" | tail -n 1)
echo "We're now working in $main_dir"
while true; do
  read -p "Enter Assignment name: " choice

  # Trim leading/trailing spaces
  choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]' | xargs)


  # Check user inputs empty assignment
  if [[ -z "$choice" ]]; then
    echo "Error: Assignment cannot be empty. Please try again."
    continue
  fi

  # Check if the assignment is present in a list of files in submission.txt file
  sub_file=${main_dir}/assets/submissions.txt
  if cut -d',' -f2 "$sub_file" | tr '[:upper:]' '[:lower:]' | sed 's/^ *//; s/ *$//' | grep -Fxq "$choice"; then 
	  echo "Successfully found the assignment: $choice"
	  break
  else
    echo "Oooops, assignment not found. Please try again."
  fi
done

# Replacing the input of the user in config/config.env file

file=${main_dir}/config/config.env
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]' | xargs)
sed -i "s|^ASSIGNMENT=.*|ASSIGNMENT=\"$choice\"|" $file
echo "Your input is being updated"
echo "....................................."

echo "To see the status of your assignment:
cd ${main_dir} && ./startup.sh"
