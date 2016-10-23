#!/bin/bash


cpu=`top -bi -n 2 -d 0.1 | grep Cpu | tail -1 `
us=`echo $cpu | awk -F'[ %]' '{print $2}'`
echo $us
