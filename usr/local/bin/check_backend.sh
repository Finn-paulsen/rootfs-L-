#!/bin/bash

# Farben definieren
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

BACKEND_IP="192.168.178.89"   # DATA-RELAY IP

if ping -c1 -W1 $BACKEND_IP >/dev/null 2>&1; then
    echo -e "  BACKEND (DATA-RELAY): [ ${GREEN}LINK ESTABLISHED${NC} ]"
else
    echo -e "  BACKEND (DATA-RELAY): [ ${RED}CONNECTION FAILED${NC} ]"
fi
