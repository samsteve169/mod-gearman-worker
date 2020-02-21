FROM centos:7.7.1908
MAINTAINER Lorenzo Crippa <webmaster@neterlite.com>

# Install WGET dependency
RUN yum install wget -y

# Install Nagios Repository
RUN rpm -Uvh https://repo.nagios.com/nagios/7/nagios-repo-7-4.el7.noarch.rpm

# Install ModGearman Worker from Nagios
RUN cd /tmp; \
wget https://assets.nagios.com/downloads/nagiosxi/scripts/ModGearmanInstall.sh; \
chmod +x ModGearmanInstall.sh; \
sed -i '/read SERVER_IP/d' ModGearmanInstall.sh; \
sed -i '/sed -i "s\/^server\\=.*:\/server\\=$SERVER_IP:\/" \/etc\/$mod_gearman_folder\/worker.conf/d' ModGearmanInstall.sh; \
./ModGearmanInstall.sh --type=worker

ADD worker.conf /etc/mod_gearman/worker.conf

COPY start.sh /start.sh
RUN chmod +x start.sh
CMD ["./start.sh"]

EXPOSE 4730/tcp 4730/udp