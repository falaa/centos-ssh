FROM centos
MAINTAINER fala


env SSH_USER user

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
	rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
	yum -y install dmidecode openssh-server python-pip sudo vim sed curl wget tar&& \
	pip install supervisor && \
	mkdir /var/log/supervisor && \
	yum clean all
 
ADD ./etc /etc
ADD ./opt /opt

# reconfigure ssh
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '';\
	/opt/add_ssh_user.sh ;\
	sed -i "/#RSAAuthentication yes/ s/# *//" /etc/ssh/sshd_config ;\
	sed -i "/ssh_host_rsa_key/ s/# *//" /etc/ssh/sshd_config ;\
	sed -i "/#PermitRootLogin/ s/# *//" /etc/ssh/sshd_config ;\
	sed -i -e 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config ;\
	sed -i "/#UsePrivilegeSeparation/ s/# *//" /etc/ssh/sshd_config ;\
	sed -i "/#LoginGraceTime/ s/# *//" /etc/ssh/sshd_config ;\
	sed -i "/#StrictModes/ s/# *//" /etc/ssh/sshd_config ;\
	sed -i "/#PubkeyAuthentication/ s/# *//" /etc/ssh/sshd_config ;\	
	echo AllowUsers $SSH_USER >> /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"] 
