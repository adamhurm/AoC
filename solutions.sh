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

#Day 3 - check for go
if [ command -v go >/dev/null 2>&1 ]
then
	echo >&2 "Looks like you're missing Go. Day 3 solution will not be run."
else
	echo -e "\n\nDay 3 Solution\n---------------"
	go run day3_solution.go
fi

#Day 4 - check for Elixir compiler and assume runtime is installed
if [ command -v elixirc >/dev/null 2>&1 ]
then
	echo >&2 "Looks like you're missing an Elixir compiler. Day 4 solution will not be run."
else
	echo -e "\n\nDay 4 Solution\n---------------"
	elixirc day4_solution.ex
fi

#Day 5 - check for Racket1 
if [ command -v racket >/dev/null 2>&1 ]
then
	echo >&2 "Looks like you're missing Racket. Day 5 solution will not be run."
else
echo -e "\n\nDay 4 Solution\n---------------"
	racket day5_solution.rkt
fi
