FROM centos:7

RUN yum -q -y update && yum -q clean all

RUN yum -q -y install epel-release && \
    yum -y install wget git sudo java-1.8.0-openjdk-devel && \
    yum -q clean all

RUN wget https://www-us.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz -P /tmp && \
    tar xf /tmp/apache-maven-3.6.0-bin.tar.gz -C /usr/local && \
    ln -s /usr/local/apache-maven-3.6.0 /usr/local/maven && \
    echo $'export JAVA_HOME=/usr/lib/jvm/jre-openjdk\n\export M2_HOME=/usr/local/maven\n\export MAVEN_HOME=/usr/local/maven\n\export PATH=${M2_HOME}/bin:${PATH}' > /etc/profile.d/maven.sh && \
    chmod +x /etc/profile.d/maven.sh

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g $GROUP_ID jenkins && useradd -u $USER_ID -s /bin/sh -g jenkins jenkins
RUN echo 'jenkins ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
