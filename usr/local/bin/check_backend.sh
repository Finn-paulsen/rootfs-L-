#!/bin/bash

BACKEND_IP="192.168.178.89"   # DATA-RELAY IP

if ping -c1 -W1 $BACKEND_IP >/dev/null 2>&1; then
    echo "Backend:    DATA-RELAY erreichbar"
else
    echo "Backend:    DATA-RELAY NICHT erreichbar"
fi
