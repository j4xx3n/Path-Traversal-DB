#!/bin/bash


main(){
    domainFile="$1"
    database="$2"
    # Loop through each line in the file
    while IFS= read -r line; do
        #table=$(echo "$line" |  sed -e 's|^[^/]*//||' -e 's|/.*$||' -e 's|www\.||' -e 's|\..*$||')
        #echo "$table"
        table=$(echo "$line" | sed -e 's|^[^/]*//||' -e 's|/.*$||' -e 's|www\.||' -e 's|\..*$||' -e 's|-||g')
        echo "$table"


        # Open a new terminal window using the default terminal emulator
        #x-terminal-emulator -e /bin/bash -c "source CreateDB.sh; createTable '$table' '$database'; domainEnum '$line' '$table' '$database'; bash"


        # Open a new terminal window using gnome-terminal
        #gnome-terminal -- bash -c '
        # Source the file containing the main function
        source CreateDB.sh
        # Call the functions
        createTable "$table" "$database"
        domainEnum "$line" "$table" "$database"
        #'

    done < "$domainFile"
}


