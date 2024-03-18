#!/bin/bash
# Print cool title and supply user imput to the functions

callMain() {
    domainFile="$1"
    databaseName="$2"


    # Source the file containing the main function
    source main.sh

    # Call the main function
    main "$domainFile" "$databaseName"

}


askFile() {
    # Ask user for a domain and database then put in a variables
    echo "Enter a wordlist of domains: "
    read domainFile
    echo "Enter a Database name (Database will be create if it doesnt already exist): "
    read databaseName

    # Call the main function and supply variables with user imput
    callMain "$domainFile" "$databaseName"

}

askFile
