FROM bitnami/spark:3.3.0
ARG DELTA_CORE_VERSION=2.12-2.1.0
USER root
RUN apt-get update && apt-get install -y curl
USER 1001
RUN curl https://repo1.maven.org/maven2/io/delta/delta-core_2.13/2.1.0/delta-core_${DELTA_CORE_VERSION}.jar --output /opt/bitnami/spark/jars/delta-core_${DELTA_CORE_VERSION}.jar

RUN curl https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.1/hadoop-aws-3.3.1.jar --output /opt/bitnami/spark/jars/hadoop-aws-3.3.1.jar
RUN curl https://repo1.maven.org/maven2/io/delta/delta-storage/2.1.0/delta-storage-2.1.0.jar --output /opt/bitnami/spark/jars/delta-storage-2.1.0.jar
# RUN curl https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.901/aws-java-sdk-bundle-1.11.901.jar --output /opt/bitnami/spark/jars/aws-java-sdk-bundle-1.11.901.jar
RUN curl https://repo1.maven.org/maven2/org/wildfly/openssl/wildfly-openssl/1.0.7.Final/wildfly-openssl-1.0.7.Final.jar --output /opt/bitnami/spark/jars/wildfly-openssl-1.0.7.Final.jar
RUN curl https://repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.8/antlr4-runtime-4.8.jar --output /opt/bitnami/spark/jars/antlr4-runtime-4.8.jar
RUN curl https://repo1.maven.org/maven2/org/codehaus/jackson/jackson-core-asl/1.9.13/jackson-core-asl-1.9.13.jar --output /opt/bitnami/spark/jars/jackson-core-asl-1.9.13.jar






