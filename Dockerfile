FROM java:8

# Install wget so we can download binaries
RUN apt-get install wget

ENV uid 1000
ENV gid 50

RUN groupadd -g $gid nifi || groupmod -n nifi `getent group $gid | cut -d: -f1`
RUN useradd --shell /bin/bash -u $uid -g $gid -m nifi

# /OPT/NIFI
RUN mkdir -p /opt/nifi
RUN chown -R nifi:nifi /opt/nifi

# /OPT/NIFI-ARCHIVE
RUN mkdir -p /opt/nifi-archive
RUN wget http://apache.mirrors.pair.com/nifi/1.1.1/nifi-1.1.1-bin.zip -O /opt/nifi-archive/nifi-archive.zip
RUN chown -R nifi:nifi /opt/nifi-archive


# /OPT/NIFI-CONF
COPY conf /opt/nifi-conf/
RUN chown -R nifi:nifi /opt/nifi-conf

# /HOME/NIFI
ADD start.sh /home/nifi/
RUN chown -R nifi:nifi /home/nifi

USER nifi

RUN chmod +x /home/nifi/start.sh

EXPOSE 8080
EXPOSE 2181
EXPOSE 2888
EXPOSE 3888
EXPOSE 9001

ENTRYPOINT ["/home/nifi/start.sh"]
