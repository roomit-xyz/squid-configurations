#!/bin/bash
#
# Dwi
# Mini Web service for sarg
#
#

STATUS=$1

case $STATUS in
      start | START )
      cd /var/www/html/reports
      python -m SimpleHTTPServer 8000 > /dev/null 2>&1 &
      echo $! > /var/run/sarg-web/sarg.pid
      ;;
      stop | STOP )
      kill -9 $(cat /var/run/sarg-web/sarg.pid);
      ;;
      status | STATUS )
      DATA=`ps -ef | grep python | grep SimpleHTTPServer | wc -l`
      if [ $DATA -gt 0 ]
      then
         echo "Service Hidup"
      else
         echo "Service mati"
      fi
      ;;
      * )
      echo $"Usage: $0 {start|stop|status}"
      exit 1
esac
