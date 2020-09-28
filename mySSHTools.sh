#!/bin/bash

adresses=(9000 9000 9000 9000 9000)
separator="        "

function printSlowly () {
    mystr=$1
    for i in $(seq 1 ${#mystr}); do
        echo -ne "${mystr:i-1:1}"
        sleep 0.01
    done
}


function removeSlowly () {
    beginning=$1
    end=$2
    for i in $(seq 1 ${#end}); do
        j=$((${#end} - $i))
        echo -ne "\r"
        echo -ne "${beginning}${end:0:j}"
        for k in `seq 0 ${i}`; do
            echo -n " "
        done
        sleep 0.01
    done
}

function knockPorts () {
    beginning=$1
    array=$2
    len=${#array[@]}
    end=""
    printSlowly "$beginning"
    for (( i=0; i<$len; i++ )); do
        end="Knocking ${array[$i]}$separator$(($i + 1)) / $len";
        echo -ne "\r";  # go back to the beginning of the line
        echo -ne "$beginning$separator$end";
        nmap -Pn --max-retries 0 -p ${array[$i]} domain.ext > /dev/null;
    done
    removeSlowly "$beginning" "$separator$end"
}

function sshopenFct () {
    array=("$@")
    knockPorts "Starting to open communications..." "${array[@]}"
    echo ""
    echo "Sequence completed"
}

function sshcloseFct () {
    array=("$@")
    for (( i=${#array[@]}-1,j=0 ;i>=0;i--,j++ )); do
        reversed[j]=${array[i]}
    done
    knockPorts "Starting to close communications..." "${reversed[@]}"
    echo ""
    echo "Sequence completed"
}


