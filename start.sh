#!/bin/bash

function handle_signal {
  PID=$!
  echo "received signal. PID is ${PID}"
  kill -s SIGHUP $PID
}

trap "handle_signal" SIGINT SIGTERM SIGHUP

echo "go to /app"
cd /app
echo "starting jackett"
mono ./JackettConsole.exe & wait
echo "stopping jackett"
