FROM ubuntu:20.04

USER root

# UPDATE ANF INSTALL PACKAGES
RUN apt-get update && apt-get -y dist-upgrade \
&& apt-get install -y openssh-server default-jdk wget scala nano sudo \
&& rm -rf /var/lib/apt/lists/* \
&& mkdir -p /opt/spark

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# CREATE GROUP
ARG user_uid=185
RUN groupadd --system --gid=${user_uid} luanvt

# CREATE USER AND ADD TO GROUPS
RUN useradd -rm -d /home/luanvt -s /bin/bash -g root -G sudo,luanvt -u ${user_uid} luanvt
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN  echo 'luanvt:luanvt' | chpasswd

# SSH CONFIG
COPY ./ssh/sshd_config /etc/ssh/sshd_config
RUN mkdir -p /home/luanvt/.ssh/
RUN sudo chown -R luanvt:luanvt /home/luanvt/.ssh/
COPY --chown=luanvt:luanvt ./ssh/ /home/luanvt/.ssh/

WORKDIR /tmp

# INSTALL SPARK
RUN mkdir -p /opt/spark && mkdir -p /opt/spark/work-dir && mkdir -p /opt/spark/conf && mkdir -p /opt/spark/logs
COPY ./spark-3.5.1-bin-hadoop3.tgz ./spark-3.5.1-bin-hadoop3.tgz
RUN tar -xf spark-3.5.1-bin-hadoop3.tgz
RUN mv ./spark-3.5.1-bin-hadoop3/* /opt/spark
RUN rm -rf ./spark-3.5.1-bin-hadoop3
RUN rm -rf ./spark-3.5.1-bin-hadoop3.tgz
RUN chown -R luanvt:luanvt /opt/spark

ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME:sbin

# INSTALL HADOOP
# CONTINUE ...

USER luanvt

WORKDIR $SPARK_HOME/work-dir

ENTRYPOINT sudo service ssh start; /bin/bash