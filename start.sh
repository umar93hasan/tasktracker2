#!/bin/bash

export PORT=5104

cd ~/www/tasktracker2
./bin/taskTracker stop || true
./bin/taskTracker start

