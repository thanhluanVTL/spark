FROM ubuntu:20.04

USER root

# UPDATE ANF INSTALL PACKAGES
RUN apt-get update && apt-get -y dist-upgrade \
&& apt-get install -y openssh-server default-jdk wget scala nano sudo \
&& rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

ARG GROUP_ID=185
ARG GROUP_NAME=luanvt
ARG USER_ID=185
ARG USER_NAME=luanvt

ARG SPARK_VERSION=3.5.3
ARG HADOOP_VERSION=3.3.6

# CREATE GROUP
RUN groupadd --system --gid=${GROUP_ID} ${GROUP_NAME}

# CREATE USER AND ADD TO GROUPS
RUN useradd -rm -d /home/luanvt -s /bin/bash -g root -G sudo,${GROUP_NAME} -u ${USER_ID} ${USER_NAME}
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN  echo ${USER_NAME}:${GROUP_NAME} | chpasswd

# SSH CONFIG
COPY ./ssh/sshd_config /etc/ssh/sshd_config
RUN mkdir -p /home/luanvt/.ssh/
RUN sudo chown -R ${USER_NAME}:${GROUP_NAME} /home/luanvt/.ssh/
COPY --chown=${USER_NAME}:${GROUP_NAME} ./ssh/ /home/luanvt/.ssh/
RUN chmod 600 /home/luanvt/.ssh/id_rsa
RUN chmod 600 /home/luanvt/.ssh/id_rsa.pub

WORKDIR /tmp

# INSTALL SPARK
ENV SPARK_HOME=/opt/spark
RUN mkdir -p $SPARK_HOME \
&& mkdir -p $SPARK_HOME/work-dir \
&& mkdir -p $SPARK_HOME/conf \
&& mkdir -p $SPARK_HOME/logs
COPY ./spark-${SPARK_VERSION}-bin-hadoop3.tgz ./spark-${SPARK_VERSION}-bin-hadoop3.tgz
RUN tar -xf spark-${SPARK_VERSION}-bin-hadoop3.tgz
RUN mv ./spark-${SPARK_VERSION}-bin-hadoop3/* $SPARK_HOME
RUN rm -rf ./spark-${SPARK_VERSION}-bin-hadoop3
RUN rm -rf ./spark-${SPARK_VERSION}-bin-hadoop3.tgz
RUN chown -R ${USER_NAME}:${GROUP_NAME} $SPARK_HOME


# INSTALL HADOOP
ENV HADOOP_HOME=/opt/hadoop
RUN mkdir -p $HADOOP_HOME \
&& mkdir -p $HADOOP_HOME/logs \
&& mkdir -p $HADOOP_HOME/hdfs/namenode \
&& mkdir -p $HADOOP_HOME/hdfs/datanode
COPY ./hadoop-${HADOOP_VERSION}.tar.gz ./hadoop-${HADOOP_VERSION}.tar.gz
RUN tar xfz hadoop-${HADOOP_VERSION}.tar.gz
RUN mv ./hadoop-${HADOOP_VERSION}/* $HADOOP_HOME
RUN rm -rf ./hadoop-${HADOOP_VERSION}
RUN rm -rf ./hadoop-${HADOOP_VERSION}.tar.gz
RUN chown -R ${USER_NAME}:${GROUP_NAME} $HADOOP_HOME
RUN chmod 744 -R $HADOOP_HOME
# RUN "$HADOOP_HOME/bin/hdfs" namenode -format

ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME:sbin:$HADOOP_HOME/bin:$HADOOP_HOME:sbin

EXPOSE 50010 50020 50070 50075 50090 8020 9000
EXPOSE 10020 19888
EXPOSE 8030 8031 8032 8033 8040 8042 8088
EXPOSE 49707 2122 7001 7002 7003 7004 7005 7006 7007 8888 9000

USER luanvt

WORKDIR $SPARK_HOME/work-dir

ENTRYPOINT sudo service ssh start; /bin/bash