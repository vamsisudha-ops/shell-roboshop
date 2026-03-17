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
SCRIPT_DIR=$PWD
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" # /var/log/shell-script/16-logs.log  --> giving full path here 
MONGODB_HOST=mongodb.daws86sd.fun
MYSQL_HOST=mysql.daws86sd.fun

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

dnf install maven -y

id roboshop &>>$LOG_FILE
if [ $? -ne 0]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOG_FILE
    VALIDATE $? "Creating a System User"
else 
    echo -e "User already exist ... $Y SKIPPING $N"
fi 

mkdir -p /app 
VALIDATE $? "Creating app directory"

curl -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip &>>$LOG_FILE
VALIDATE $? "Downloading shipping application"

cd /app 
VALIDATE $? "Changing to app directory"

rm -rf /app/*
VALIDATE $? "Removing existing code"

unzip /tmp/catalogue.zip &>>$LOG_FILE
VALIDATE $? "Unzip shipping"

mvn clean package &>>$LOG_FILE
mv target/shipping-1.0.jar shipping.jar 

cp $SCRIPT_DIR/shipping.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl enable shipping &>>$LOG_FILE

dnf install mysql -y 

mysql -h $MYSQL_HOST -uroot -pRoboShop@1 -e 'use cities' &>>$LOG_FILE
if [ $? -ne 0 ]; then
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/schema.sql &>>$LOG_FILE
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/app-user.sql &>>$LOG_FILE
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/master-data.sql &>>$LOG_FILE
else
    echo -e "Shipping data is already loaded ... $Y SKIPPING $N"
fi 

systemctl restart shipping
