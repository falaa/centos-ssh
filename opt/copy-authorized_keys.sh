#!/bin/bash

cp /srv/authorized_keys /home/$SSH_USER/.ssh/authorized_keys
chown -R $SSH_USER:$SSH_USER /home/$SSH_USER
chmod -R 600 /home/$SSH_USER/.ssh
echo "Key for $SSH_USER added"