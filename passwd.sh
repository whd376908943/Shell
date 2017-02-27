#!/bin/bash

IFS=':'                               

while read f1 f2 f3 f4 f5 f6 f7         

do

 echo "账号:$f1,login shell是:$f7"     

done <   /etc/passwd         
