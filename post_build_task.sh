#!/bin/sh 

# Jenkins will finish the directory inside the cloned directory
# change directory to target folder
cd target 

# Get the latest saved things in PM2
sudo pm2 resurrect 

# check whether there's a service using the PID
var=$(sudo pm2 pid $1) 

echo $var 
echo $1 
echo $(basename *.jar) 

# if statement
if [ -z "$var" ]; 
 then 
   sudo pm2 start --name $1 java -- -Xmx$2 -jar $(basename *.jar) 
 else 
   sudo pm2 stop $1 
   sudo pm2 start $1 
fi; 

# save the changes process
pm2 save --force 

# unset the var variable
unset var 
