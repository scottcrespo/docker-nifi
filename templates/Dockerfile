FROM java:8

ENV NIFI_VERSION {{NIFI_VERSION}}
ENV NIFI_HOME /opt/nifi
ENV uid 1000
ENV gid 50

RUN groupadd -g $gid nifi || groupmod -n nifi `getent group $gid | cut -d: -f1`
RUN useradd --shell /bin/bash -u $uid -g $gid -m nifi

# /OPT/NIFI
COPY nifi-archive/nifi-$NIFI_VERSION /opt/nifi
COPY files/* {{HOSTNAME}}/* /opt/nifi/conf/

RUN chown -R nifi:nifi /opt/nifi
RUN chown -R nifi:nifi /home/nifi

USER nifi

{% for PORT in PORTS %}
EXPOSE {{PORT}}
{% endfor %}

CMD /opt/nifi/bin/nifi.sh run
#CMD /bin/bash
