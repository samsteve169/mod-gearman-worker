FROM centos:7.7.1908
MAINTAINER Lorenzo Crippa <webmaster@neterlite.com>

# Install ModGearman Worker from Nagios
RUN cd /tmp; \
wget https://assets.nagios.com/downloads/nagiosxi/scripts/ModGearmanInstall.sh; \
chmod +x ModGearmanInstall.sh; \
sed -i '/read SERVER_IP/d' ModGearmanInstall.sh; \
sed -i '/sed -i "s\/^server\\=.*:\/server\\=$SERVER_IP:\/" \/etc\/$mod_gearman_folder\/worker.conf/d' ModGearmanInstall.sh; \
./ModGearmanInstall.sh --type=worker

# Copy configuration files
#ADD worker.conf /etc/mod_gearman/worker.conf

RUN systemctl restart mod-gearman-worker

#
#    info "What is the IP address of your Nagios master server?: "
#    read SERVER_IP
#    sed -i "s/^server\=.*:/server\=$SERVER_IP:/" /etc/$mod_gearman_folder/worker.conf
#