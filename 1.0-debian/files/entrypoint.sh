#!/bin/bash
set -e

function check_and_link_error(){
    [ -e "$1" ] && rm "$1";
    ln -s /dev/stderr "$1"
}
function check_and_link_out(){
    [ -e "$1" ] && rm "$1";
    ln -s /dev/stdout "$1"
}
# For Logfiles



function init_misp_modules() {
    echo "####################################"
    echo "started MISP Modules"
    echo "####################################"
    sudo -u www-data misp-modules -l 0.0.0.0
}

init_misp_modules