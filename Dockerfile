# 选择base镜像
FROM ubuntu:latest

# 添加作者信息
MAINTAINER junyu "tyrone-zhao@qq.com"

# 安装ssh package, 并将监听端口修改为2222
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y openssh-{server,client}
RUN mkdir /var/run/sshd
RUN sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config
RUN echo "root:123456" | chpasswd
RUN sed -ri 's/^#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# 对外暴露2222端口
EXPOSE 2222

# 将默认的命令设置为启动sshd服务
CMD ["service", "ssh", "start"]
