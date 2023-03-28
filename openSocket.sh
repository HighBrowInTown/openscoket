#!/bin/bash

DST_IP="${1}"
PORT="${2}"
PID=$$

HELP () {

    echo "${0} <DESTINATION IP ADDRESS> <PORT>"    
}

VARIABLE_CHK () {

    [ "x${DST_IP}" == "x" ] && echo "Error: Undefined Destination IP" && HELP && exit 1
    [ "x${PORT}" == "x" ] && echo "Error: Undefine PORT" && HELP && exit 1
}

INFO () {

    echo "ALL traffic received on port ${PORT} will be forwarded to ${DST_IP}:${PORT}"
}

OPEN_PORT () {

    while true 
    do 
        socat tcp4-listen:"${PORT}",reuseaddr tcp:"${DST_IP}:${PORT}" > /dev/null & disown
    done
}

MAIN () {

    VARIABLE_CHK
    INFO
    OPEN_PORT
}

MAIN