#!/usr/bin/env bash

do
	read -p "Are you sure? [y/N]" prompt
	if [[ $prompt == "y" || $prompt == "Y" ]]; then
		echo "Do the thing"
	elif [[ $prompt == "n" || $prompt == "N" ]]; then
		echo "fine whatevs"
	else
		echo "Choose yes or no"
	fi
done
