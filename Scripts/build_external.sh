#!/bin/zsh

product_folder=""

# Check if an argument is provided
if [ $# -eq 0 ]; then
    product_folder="./Products"
    echo "No arguments provided. will use default folder: ./Products"
else
    product_folder=$1
fi


swift build -c release
cp ".build/release/SwiftyArchitectureMacros" "$product_folder/SwiftyArchitectureMacros"
