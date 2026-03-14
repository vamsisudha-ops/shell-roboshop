#!/bin/bash 
set -euo pipefail ## exit/fail overall if any error/failure occurs 

trap 'echo "There is an error $LINENO, Command is: $BASH_COMMAND"' ERR

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
SCRIPT_DIR=$PWD
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" # /var/log/shell-script/16-logs.log  --> giving full path here 
MONGODB_HOST=mongodb.daws86sd.fun

mkdir -p $LOGS_FOLDER   # -p checks already directory is there or not, if it's not automatically it create a directory
echo "Script started executed at: $(date)" | tee -a $LOG_FILE  #TO APPEND THE ECHO STATEMENT IN LOGS FILE

if [ $USERID -ne 0 ]; then 
    echo "ERROR:: please run this script with root previlege"
    exit 1 #failure is other than 0 
fi 


########### NodeJS #######################
dnf module disable nodejs -y &>>$LOG_FILE
dnf module enable nodejs:20 -y &>>$LOG_FILE
dnf install nodejs -y &>>$LOG_FILE
echo -e "Installing NodeJS 20 ... $G SUCCESS $N"


id roboshop &>>$LOG_FILE
if [ $? -ne 0]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOG_FILE
else 
    echo -e "User already exist ... $Y SKIPPING $N"
fi 

mkdir -p /app 


curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>$LOG_FILE

cd /app 


rm -rf /app/*


unzip /tmp/catalogue.zip &>>$LOG_FILE


npm install &>>$LOG_FILE


cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service   ### Full path 


systemctl daemon-reload
systemctl enable catalogue &>>$LOG_FILE
echo -e "Catalogue Application Set up ... $G SUCCESS $N"


cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo  ## add full path for smoother execution


dnf install mongodb-mongoshfgh -y &>>$LOG_FILE


INDEX=$(mongosh mongodb.daws86sd.fun --quiet --eval "db.getMongo().getDBNames().indexOf('catalogue')")
if [ $INDEX -le 0 ]; then
    mongosh --host $MONGODB_HOST </app/db/master-data.js &>>$LOG_FILE
else 
    echo -e "Catalogue products already loaded ... $Y SKIPPING $N"
fi 
systemctl restart catalogue
echo -e "Loading Products and restarting Catalogue ... $G SUCCESS $N"
