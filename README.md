# submission_reminder_app_Bonesha-5

......Submission Reminder App – User Guide.............

Welcome to the Submission Reminder App!

This simple application helps both teachers and students keep track of assignment submissions — showing which ones are submitted and which are still pending.

 1. .....Purpose of the App....
This app helps:

✅ Teachers: see students who have not submitted a specific assignment.

✅ Students: view which assignments that are still pending for submission.

 2. .....How the Application Works.....
Follow these steps to use the app from start to finish:

1️⃣Step One: Set Up Your Environment
 Run the setup script by entering the following command in your terminal: ./create_environment.sh
 You will be asked to enter your username.
 Make sure your name follows these rules:
      ✅ It must be one word only
      ❌ No spaces allowed
      ❌ Don’t use two words
             For example:
                kiki → OK
                john doe → Not allowed

 Once you enter your username; your environment folder is created automatically named like this: submission_reminder_username.
 To enter into your working environment (folder) write this command in your terminal : cd submission_reminder_username (where username is the name you entered in step 1).If you wrote the above command in your terminal to come back into the current directory write this command on your terminal: cd ..

 This script will also automatically create sub_directories and files inside the main directory(submission_reminder_username).

2️⃣ Step Two: Enter the assignment name
  Now it's time to check if a specific assignment has been submitted or not.
  To check you will have to run the copilot script like this: ./copilot_shell_script.sh
  
  It will ask you to enter the name of the assignment you want to check.
  You can type the name in capital or small letters — both work!
       Example of assignment inputs:
		Git 
		git
		SHELL NAVIGATION

3️⃣ Step Three: Display the details of assignment. 
  In the above step you were asked to enter the assignment name to check the assignment's deails like submission status:
  Re-enter your folder like how we did it in step one by writing this command in your terminal: cd submission_reminder_username 
  Then run the startup script by writing this command on your terminal: ./startup.sh
  
  ⚡This refreshes the folder structure with the updated assignment information.

 3. ......Summary of Scripts.........
     Script Name	                         Purpose
 create_environment.sh		 Creates your working folder using your name
 copilot_shell_script.sh	 Updates information for a chosen assignment in other files like config/config.env
 startup.sh                      checks for submission status for a chosen assignment

 4. .......🎓 Who Is This App For?........
Teachers – see which students have submitted or missed assignments.

Students – get reminders about which assignments are still pending.

 5. .......✅ Example Flow ..........

 ./create_environment.sh             # Step 1: Set up environment
 cd submission_reminder_username     	# Go into your folder
 tree				     	# check the sub_directories and files 
 cd ..                               	# Get back into the working directory 
 ./copilot_shell_script.sh           # Step 2: Check assignment
 cd submission_reminder_username        # Go into your folder
 ./startup.sh                        # Step 5: Display all detail of assignment

 6. ......📞 Need Help?..........
If anything doesn’t work or you see an error, double-check:

 a. You typed your name as one word (no spaces).

 b. You followed the steps in order.
