#!/bin/bash
cd /home/gem/workspace/agent
pkill -9 -f openclaw
sleep 2
rm -f /tmp/openclaw* 2>/dev/null
nohup npx openclaw@2026.3.13 gateway run --port 18789 > ./logs/service.log 2>&1 &
echo "Started with PID: $!"
sleep 10
ps aux | grep openclaw | grep -v grep