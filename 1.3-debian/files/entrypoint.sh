#!/bin/sh
STARTMSG="[entrypoint]"

if [ $# = 0 ]
then
    # If no parameter is set
    echo "$STARTMSG started MISP Modules" && misp-modules -l 0.0.0.0  > /dev/stdout 2> /dev/stderr
else
    # If parameter are set
    echo "$STARTMSG started MISP Modules" && misp-modules -l 0.0.0.0 > /dev/stdout 2> /dev/stderr &
    exec "$@"
fi