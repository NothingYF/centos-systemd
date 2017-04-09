# Version 1.0.0

FROM centos:7
MAINTAINER nothingdocker "84727906@qq.com"
ENV REFRESHED_AT 20170410
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;\
echo "export PS1='[\u@\h \W]\$ '" >> ~/.bash_profile;\
/usr/bin/cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;

RUN yum -y install epel-release;yum -y install net-tools;yum -y install wget;yum clean all;
VOLUME [ "/sys/fs/cgroup" ]
COPY entrypoint.sh /entrypoint.sh
COPY autorun.service /etc/systemd/system/autorun.service
COPY autorun /autorun
RUN systemctl enable autorun.service
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/init"]
