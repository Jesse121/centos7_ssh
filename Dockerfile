#生成的新镜像以centos7镜像为基础
FROM centos:7
MAINTAINER by jesse (jesse152@163.com)
#升级系统
RUN yum -y update
#安装openssh-server
RUN yum -y install openssh-server
#修改/etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# 生成sshkey
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key


#变更root密码
RUN echo "root:jesse131978"|chpasswd
#开放窗口的22端口
EXPOSE 22
#运行脚本，启动sshd服务
# CMD ["/usr/local/sbin/run.sh"]
CMD    ["/usr/sbin/sshd", "-D"]