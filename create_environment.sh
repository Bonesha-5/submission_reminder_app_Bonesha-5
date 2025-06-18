#!/bin/bash

#prompting user to enter their username and creating a directory
echo " "
echo "You're going to enter username to be used"
echo "Here are the instructions:
1. username must be not empty
2. It must be exactly one word with no spaces
............................................."

#checking the name enteredby the user according to the instructions
while true; do
  read -p "Enter your username: " username

  # Removing extra spaces
  username=$(echo "$username" | xargs)

  # Check if the input is empty
  if [[ -z "$username" ]]; then
    echo "Error: Username cannot be empty. Please try again."
    continue
  fi

  # Check if username is exactly one word
  word_count=$(echo "$username" | wc -w)
  if [[ "$word_count" -ne 1 ]]; then
    echo "Error: Use only one word with no spaces."
    continue
  fi

  # If valid, break the loop and continue
  echo "Congratulations! Username accepted: $username"
  break
done


# Checking and creating submission_reminder_* directory
if [ -d submission_reminder_$username ]; then
	echo "Folder called submission_reminder_$username exist" 
else
	mkdir -p submission_reminder_$username
	echo "Successfully created submission_reminder_$username folder"
fi

#we are going to create sub directories and files inside it
cd submission_reminder_$username
  #creating directory called app and reminder.sh file
if [ ! -d app ]; then
	mkdir -p app && cd app && touch reminder.sh
	cd ..
else
	cd app && touch reminder.sh
	cd ..
fi
  #creating directory called modules and function.sh file
if [ ! -d modules ]; then
        mkdir -p modules && cd modules && touch functions.sh
	cd ..
else
        cd modules && touch functions.sh
	cd ..
fi
  #creating directory called assets and submissions.txt file
if [ ! -d assets ]; then
        mkdir -p assets && cd assets && touch submissions.txt
	cd ..
else
        cd assets && touch submissions.txt
	cd ..
fi
  #creating directory called config and config.env file
if [ ! -d config ]; then
        mkdir -p config && cd config && touch config.env
	cd ..
else
        cd config && touch config.env
	cd ..
fi
  #creating startup.sh file
if [ ! -f startup.sh ]; then
	touch startup.sh
else
	echo "File startup.sh already exist"
fi

#Now let's create the contents of the file

  #This is the content of the file reminder.sh

chmod +x app/reminder.sh
cat <<BOF > app/reminder.sh
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
BOF

  #These are the content of the file functions.sh

chmod +x modules/functions.sh
cat <<BOF > modules/functions.sh
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
BOF

  #This is the content of the file submissions.txt file
cat <<BOF > assets/submissions.txt
student, assignment, submission status, date_to_submission
Chinemerem, Shell Navigation, not submitted, 4 days
Chiagoziem, Git, submitted, 10 days
Divine, Shell Navigation, not submitted, 1 day
Anissa, Shell Basics, submitted,6 days
kevine, Git, submitted, 7 days
annie, Alu Project, not submitted, 2 days
douce, Shell Basics, submitted, 4 days
liliane, Git, not submitted, 3 days
esther, Shell Navigation, not submitted, 10 days
Pascaline, Alu project, not submitted, 6 days
olga, Shell Read, submitted, 1 day
BOF

  #This is the content of thef file config.env file
cat <<BOF > config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
BOF

  #This is the content of thr file startup.sh
chmod +x startup.sh
cat <<'BOF' > startup.sh
#!/bin/bash
source ./config/config.env
tail -n +2 "./assets/submissions.txt" | while IFS=',' read -r student assignment status days_to_submission
do
  student=$(echo "$student" | xargs)
  assignment=$(echo "$assignment" | tr '[:upper:]' '[:lower:]' | xargs | sed 's/^"\(.*\)"$/\1/')
  status=$(echo "$status" | tr '[:upper:]' '[:lower:]' | xargs)
  days_to_submission=$(echo "$days_to_submission" | xargs)

  if [[ "$status" == "not submitted" && "$assignment" == "$(echo "$ASSIGNMENT" | tr '[:upper:]' '[:lower:]')" ]]; then
    echo "⚠️⚠️ Reminder: $student has ‘$assignment’ assignment that is not submitted yet, due in $days_to_submission!"
  elif [[ "$status" == "submitted" && "$assignment" == "$(echo "$ASSIGNMENT" | tr '[:upper:]' '[:lower:]')" ]]; then
    echo "🎉🎉$student already submitted $assignment assignment"
  fi
done

BOF

#Delegating the user how to use this application
echo "......................................"
echo "To run this app:
./copilot_script.sh
cd submission_reminder_$username && ./startup.sh"
