#!/bin/bash
#This is a script that converts binary to decimal and decimal to binary
#The program has a menu that allows users to choose between the five options:
	#decimal to binary
	#binary to decimal
	#read all binary numbers
	#read all decimal numbers
	#exit

#function to convert decimal to binary
decimal_to_binary(){ #this is a function created and added to the menu
	echo "Enter the decimal number" #display message to ask the user for his input (in this case to add a decimal number that he wants to convert to a binary one)
	read decimal #reading the user input, store it in a variable called decimal and use it later in the function
	if [ "$decimal" -ne 0 ] #condition to check if the user input is not equal to 0
		then #if it is not equal to 0 then run the following commands
			echo "The binary number is: " #display the message on the screen
			echo "obase=2;$decimal" | bc #use the bc (base conversion)command to convert the decimal number from user input to binary; the obase(output base) will be 2; the input base (ibase) will be set by default to 10
			bc -l <<<"obase=2;$decimal" >> binarynumbers.txt #add the number in a text file with append to keep a record of all the outputs
		else #in case the number entered by the user is 0, print the following message on the screen
			echo "The number must be higher than 0!"
	fi #end the if statement
}

#function to convert binary to decimal
binary_to_decimal(){ #this is a function created and added to the menu
	echo "Enter the binary number" #display message to ask the user for his input (in this case to add a binary number that he wants to convert to decimal)
	read binary #reading the user input, store it in a variable called binary and use it later in the function
	if [ "$binary" -ne 0 ] #condition to check if the user input is not equal to 0
		then #if it is not equal to 0 then run the following commands
			echo "The decimal number is: " #display the message on the screen
			echo "ibase=2;$binary" | bc ##use the bc (base conversion)command to convert the binary number from user input to decimal; the ibase(input base) will be 2; the output base will be set by default to 10
			bc -l <<<"ibase=2;$binary" >> decimalnumbers.txt #add the number in a text file with append to keep a record of all the outputs
		else #in case the number entered by the user is 0, print the following message on the screen
			echo "The number must be higher than 0!"
	fi #end the if statement
}

#function to display all binary outputs from the text file created in the first function decimal_to_binary, check how many times a number appears in the file or change a number from the file
display_all_binary_numbers(){ #this is a function created and added to the menu
	filename='binarynumbers.txt' #the file name is the one given in the first function (decimal_to_binary function)
	n=1 #initialize the first line with 1
	while read line;
	do #while loop created to read each line from the file
		echo "$n.Binary number : $line" #print the binary number found in each line; it reads each line and displays it
		n=$((n+1)) #increase the line with 1 so all lines can appear one by one
	done < $filename #print all the lines read on the screen; we reached to the end of file

	#alternative option to while loop - for loop
	#for line in $(cat binarynumbers.txt)#for loop to read each line from the file
	#do
	#echo "$n.Binary number : $line"  #print the binary number found in each line
	#n=$((n+1)) #increase the line with 1 so all lines can appear one by one
	#done

	echo "Type the binary number you want to find:" #ask for user input
	read bnumber #read user input
	output=$( grep -x -c "$bnumber" binarynumbers.txt) #search for the number with exact match and show how many times it is found in the file, store the number of times in a variable called output
	echo -n "The binary number $bnumber appears in this file $output time/s." #display how many times the user input appears in the file
	echo #to add a new line
	echo "Type an existing binary number you want to replace: " #ask for user input for the binary number he wants to replace
	read binaryToReplace #read the user input and store it in a variable called binaryToReplace
	if grep -xq "$binaryToReplace" binarynumbers.txt #search for the number entered by user in the file
        	then #if the condition is met (the number is found in the file) then run the following command
        		echo "Type the new binary number: " #ask for user input for the new decimal number
        		read newBinaryNumber #read the user input and store it in a variable called newDecimalNumber
        		sed -i "s/\<$binaryToReplace\>/$newBinaryNumber/g" "$filename" #function to replace the old decimal number from the user input with the new one in the current file
        	else #if the condition is not met
        		echo "The number you entered does not exist" #if the number the user wants to replace does not exist, display the message
        fi #end the if statement
}

#function to display all decimal outputs from the text file createn in the second function binary_to_decimal, check how many times a number appears in the file or change a number from the file
display_all_decimal_numbers(){  #this is a function created and added to the menu
	filename='decimalnumbers.txt' #the file name is the one given in the second function (binary_to_decimal function)
	n=1 #initialize the first line  with 1
	while read line; 
	do #while loop created to read each line from the file
		echo "$n.Decimal number: $line" #print the decimal number found in each file ; it reads each line and displays it
		n=$((n+1)) #increase the line with 1 so all lines can appear one by one
	done < $filename #print all the lines read on the screen; we reached to the end of file

	#alternative option to while loop - for loop
	#for line in $(cat decimalnumbers.txt)
	#do
	#echo "$n.Decimal number : $line"
	#n=$((n+1))
	#done

	echo "Type the decimal number you want to find:" #ask for user input
	read dnumber #read user input
	output=$( grep -x -c "$dnumber" decimalnumbers.txt) #search for the number with exact match and show how many times it is found in the file, store the number of times in a variable called output
	echo -n "The decimal number $dnumber appears in this file $output time/s." #display how many times the user input appears in the file
	echo #to add a new line
	echo "Type the decimal number you want to replace: " #ask for user input for the decimal number he wants to replace
	read decimalToReplace #read the user input and store it in a variable called decimalToReplace
	if grep -xq "$decimalToReplace" decimalnumbers.txt #search for the number entered by user in the file
		then #if the condition is met (the number is found in the file) then run the following command
			echo "Type the new decimal number: " #ask for user input for the new decimal number
			read newDecimalNumber #read the user input and store it in a variable called newDecimalNumber
			sed -i "s/\<$decimalToReplace\>/$newDecimalNumber/g" "$filename" #function to replace the old decimal number from the user input with the new one in the current file
		else #id the condition is not met
			echo "The number you entered does not exist" #if the number the user wants to replace does not exist, display the message
	fi #end the if statement
}

#Creating the menu so user can choose one of the five options
menu(){
#display message for the user with info about program functionality and first instruction to choose his oprion
echo -e "\nWelcome to this awesome program that converts binary to decimal and vice versa!\nYou have a hard decision to make here:\n"
options=(" Convert decimal to binary" " Convert binary to decimal" " Display all binary numbers" " Display all decimal numbers" " Exit") #define the option
select opt in "${options[@]}" #write the input from the user using case to decide what function to call
do
	case $opt in #use case statement for the options
	" Convert decimal to binary") #first option
	decimal_to_binary;menu;;
	" Convert binary to decimal") #second option
	binary_to_decimal;menu;;
	" Display all binary numbers") #third option
	display_all_binary_numbers;menu;;
	" Display all decimal numbers") #fourth option
	display_all_decimal_numbers;menu;;
 	" Exit") #exit option
	exit
	;;
	*) echo "invalid option $REPLY";; #default option in case the user enters an invalid number
	esac #end the case statement
done
}
menu
