#生成的新镜像以centos7镜像为基础
FROM centos:7
#升级系统
RUN yum -y update
RUN yum -y install vim epel-release
RUN yum -y install nginx
#安装openssh-server
RUN yum -y install openssh-server
#修改/etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# 生成sshkey
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -t ed25519 -f  /etc/ssh/ssh_host_ed25519_key

# ADD start.sh /root/
# RUN chmod +x /root/start.sh

#变更root密码
RUN echo "root:jesse131978"|chpasswd
#开放窗口的端口
EXPOSE 80 22
#运行脚本，启动sshd服务 
# CMD ["sh","/root/start.sh"]
CMD ["/usr/sbin/sshd -D"]