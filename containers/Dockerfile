FROM centos:7

USER root

# Maven
ENV MAVEN_VERSION 3.3.9
RUN curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
&& mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
&& sed -i 's|${CLASSWORLDS_LAUNCHER} "$@"|${CLASSWORLDS_LAUNCHER} -B "$@"|g' /usr/share/maven/bin/mvn \
&& ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

RUN echo "export M2_HOME=/usr/share/maven" >> /etc/profile
RUN mkdir /root/.m2

RUN chmod 777 /usr/share/maven/conf/settings.xml

#make sure maven repo is empty
RUN rm -rf /root/.m2/repository/

# Gradle
ENV GRADLE_VERSION 4.10
RUN yum install -y wget unzip && yum clean all
RUN wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip
RUN echo "248cfd92104ce12c5431ddb8309cf713fe58de8e330c63176543320022f59f18 *gradle-$GRADLE_VERSION-bin.zip" > gradle-$GRADLE_VERSION-bin.zip.sha256
RUN sha256sum -c gradle-$GRADLE_VERSION-bin.zip.sha256
RUN unzip gradle-$GRADLE_VERSION-bin.zip -d /usr/share
RUN rm gradle-$GRADLE_VERSION-bin.zip
RUN rm gradle-$GRADLE_VERSION-bin.zip.sha256
ENV PATH="${PATH}:/usr/share/gradle-$GRADLE_VERSION/bin"

# OpenJFX packages
RUN yum install -y gcc-c++ make autoconf automake libtool glibc-devel \
    libstdc++-static bison flex gperf ksh pkgconfig \
    libpng12-devel libjpeg-devel libxml2-devel \
    libxslt-devel systemd-devel glib2-devel  gtk2-devel \
    libXtst-devel pango-devel freetype-devel \
    perl-JSON-PP perl-Digest-MD5 ruby \
    && yum clean all
RUN yum install -y centos-release-scl epel-release
RUN yum install -y devtoolset-8
RUN yum install -y cmake3 && yum clean all
RUN ln -s /usr/bin/cmake3 /usr/bin/cmake

RUN yum install -y git
RUN yum install -y java-1.8.0-openjdk-devel
ENV JDK_HOME /usr/lib/jvm/java-1.8.0-openjdk
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk

RUN chgrp -R 0 /usr/share/maven && \
    chmod -R g=u /usr/share/maven && \
    chgrp -R 0 /usr/share/gradle-4.10 && \
    chmod -R g=u /usr/share/gradle-4.10