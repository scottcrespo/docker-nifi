FROM java:8

ENV NIFI_VERSION 1.1.1
ENV NIFI_HOME /opt/nifi
ENV uid 1000
ENV gid 50

RUN groupadd -g $gid nifi || groupmod -n nifi `getent group $gid | cut -d: -f1`
RUN useradd --shell /bin/bash -u $uid -g $gid -m nifi

# /OPT/NIFI
COPY nifi-archive/nifi-$NIFI_VERSION /opt/nifi
COPY files/* localhost/* /opt/nifi/conf/

RUN chown -R nifi:nifi /opt/nifi
RUN chown -R nifi:nifi /home/nifi

USER nifi

EXPOSE 8080
EXPOSE 9443
EXPOSE 2181
EXPOSE 2888
EXPOSE 3888
EXPOSE 9001

CMD /opt/nifi/bin/nifi.sh run
#CMD /bin/bash
