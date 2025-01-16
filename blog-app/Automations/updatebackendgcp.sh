#!/bin/bash

# Set the Instance Name and Zone
INSTANCE_NAME="master-vm"
ZONE="asia-south1-c"

# Retrieve the external IP address of the specified Compute Engine instance
ipv4_address=$(gcloud compute instances describe $INSTANCE_NAME --zone $ZONE --format='get(networkInterfaces[0].accessConfigs[0].natIP)')

# Initializing variables
file_to_find="../backend/.env.docker"
alreadyUpdate=$(cat ../backend/.env.docker)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

# Check if the file exists
if [ -f "$file_to_find" ]; then
    # Update the BACKEND_API_PATH in the .env.docker file
    sed -i -e "s|BACKEND_API_PATH.*|BACKEND_API_PATH=\"http://${ipv4_address}:31100\"|g" ${file_to_find}
    echo -e "${GREEN}env variables configured..${NC}"
else
    echo -e "${RED}ERROR : File not found..${NC}"
fi