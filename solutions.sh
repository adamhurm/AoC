#!/bin/bash

#Day 1 - check for python
if [ command -v python3 >/dev/null 2>&1 ]
then
	echo >&2 "Looks like you're missing python3. Day 1 solution will not be run." 
else
	echo -e "Day 1 Solution\n---------------"
	python3 day1_solution.py
fi

#Day 2 - check for Java compiler and assume runtime is installed
if [ command -v javac >/dev/null 2>&1 ]
then
	echo >&2 "Looks like you're missing a Java compiler. Day 2 solution will not be run."
else
	echo -e "\n\nDay 2 Solution\n---------------"
	javac day2_solution.java && java day2_solution
fi


if [ command -v go >/dev/null 2>&1 ]
then
	echo >&2 "Looks like you're missing Go. Day 3 solution will not be run."
else
	echo -e "\n\nDay 3 Solution\n---------------"
	go run day3_solution.go
fi
