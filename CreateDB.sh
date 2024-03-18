#!/bin/bash
# Gather path traversal data from a domain and add to SQLite database

# Create the SQLite table and columns if it doesnt already exist
createTable() {
    # Create variable of user supplied input for the table and database name
    table="$1"
    batabase="$2"
    # Create a database and table with variables
    sqlite3 $batabase "CREATE TABLE IF NOT EXISTS "$table" (Domain TEXT, Path TEXT, Query TEXT, Status TEXT, Request TEXT, Size TEXT);"
    echo "Database: $database    Table: $table    Status: Empty"
}


# Spider and grep for interesting paths then add to database
domainEnum() {
    # Create variable of user supplied input for the full path, table, and database name
    local fullPath="$1"
    local table="$2"
    local database="$3"

    # Run your Linux command and iterate over its output
    echo "$fullPath" | hakrawler | grep "$fullPath" | grep ? | while IFS= read -r line; do

        # Create a variable for the path, query, and domain
        path=$(echo "$line" | cut -d'/' -f4- | cut -d'?' -f1)
        query=$(echo "$line" | cut -d'?' -f2)
        domain=$(echo "$line" | sed 's/^\(.*:\/\/\)\?\([^\/]*\)\(\/.*\)\?$/\2/')

        # Create file for urls without the file at the end of the query
        echo "$line" | sed 's/=.*/=/' >> enumQuerys--$domain.txt

        # Check the status of the found urls
        status=$(curl -I -w "%{http_code}" -s -o /dev/null "$line")

        # Check the file size of the found page
        size=$(curl -s -o /dev/null -w "%{size_download}" "$line")

        # Check the request mothod of a url
        # Create a list for the diffrent request methods.
        local methods=("GET" "POST" "PUT" "DELETE")

        # Loop through the request methods and check for a 200 status code
        for method in "${methods[@]}"; do
            local response=$(curl -s -o /dev/null -w "%{http_code}" -X "$method" "$line")
            if [ "$response" -eq 200 ]; then
                request=$(echo "$method") # Put the request method in a variable

                # Send a query with the info to database
                sqlite3 $database "INSERT INTO "$table" (Domain, Path, Query, Status, Request, Size) VALUES ('$domain', '$path', '$query', '$status', '$request', '$size');"
                echo "Database: $database    Table: $table    Status: Scanning"
            fi

        done
    done
    echo "Database: $database    Table: $table    Status: Finished"

}


main(){
    domainFile="$1"
    database="$2"
    # Loop through each line in the file
    while IFS= read -r line; do
        table=$(echo "$line" |  sed -e 's|^[^/]*//||' -e 's|/.*$||' -e 's|www\.||' -e 's|\..*$||')
        echo "$table"
        #createTable "$table" "$database"
        #domainEnum "$line" "$table" "$database"

        # Open a new terminal window and execute both createTable and domainEnum
        #x-terminal-emulator -e bash -c "createTable \"$table\" \"$database\" && domainEnum \"$line\" \"$table\" \"$database\"; exec bash"


    done < "$domainFile"
}


#main

