#!/usr/bin/env sh

# Boots up the vagrant machine and runs the ansible playbook on it.

echo "I couldn't really test the setup with vagrant specifically, but I"
echo "tested it with an Ubuntu 22.04 ARM64 VM running under orbstack."
echo "You may check ansible/inventory_orb for my orbstack setup's inventory."
echo ""
echo "I have an ARM64 machine, and vagrant + virtualbox does not work on"
echo "that."

echo "---"

echo "Starting the VM"
vagrant up

echo "Running the playbook"
ansible-playbook -i ansible/inventory ansible/playbook.yml
