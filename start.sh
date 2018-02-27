#!/bin/bash

export PORT=5104

cd ~/www/tasktracker2
./bin/taskTracker2 stop || true
./bin/taskTracker2 start

