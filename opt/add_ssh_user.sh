#!/bin/bash

__create_user() {
	SSH_USER=${SSH_USER:-user}
	SSH_USERPASS=${SSH_USERPASS:-`date | md5sum | head -c16`}

	useradd $SSH_USER
	echo -e "$SSH_USERPASS\n$SSH_USERPASS" | (passwd --stdin $SSH_USER)
	echo "$SSH_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
	mkdir /home/$SSH_USER/.ssh
	echo -e "\e[92mNow you can connect via ssh with:\e[39m"
	echo -e "  Username: \e[91m$SSH_USER\e[39m"
	echo -e "  Password: \e[91m$SSH_USERPASS\e[39m"
}

__create_user