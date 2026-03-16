#!/bin/bash 
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]; then 
    echo "ERROR:: please run this script with root previlege"
    exit 1 #failure is other than 0 
fi 
LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" # /var/log/shell-script/16-logs.log  --> giving full path here 
START_TIME=$(date +%s)
mkdir -p $LOGS_FOLDER   # -p checks already directory is there or not, if it's not automatically it create a directory
echo "Script started executed at: $(date)" | tee -a $LOG_FILE  #TO APPEND THE ECHO STATEMENT IN LOGS FILE

if [ $USERID -ne 0 ]; then 
    echo "ERROR:: please run this script with root previlege"
    exit 1 #failure is other than 0 
fi 

VALIDATE(){ # funtions receive inputs through args just like shell script args
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N" | tee -a $LOG_FILE
    fi 
}

dnf install mysql-server -y
VALIDATE $? "Installing MySQL Server"
systemctl enable mysqld
VALIDATE $? "Enabling MySQL Server"
systemctl start mysqld  
VALIDATE $? "Starting MySQL Server"

mysql_secure_installation --set-root-pass RoboShop@1
VALIDATE $? "Setting up Root Password"

END_TIME=$(date +%s)
TOTAL_TIME=$(( $END_TIME - $START_TIME))
echo -e "Script executed in: $Y $TOTAL_TIME Seconds $N"