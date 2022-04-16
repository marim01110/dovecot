FROM debian:bullseye-slim
MAINTAINER Kohei YOSHIKAWA <admin@marihome.org>

RUN apt update \
    && apt upgrade -yq \
    && apt install dovecot-core dovecot-imapd ca-certificates -yq

RUN apt -yq autoremove \
    && apt -yq clean \
    && rm -rf /var/log/{apt/*,dpkg.log,alternatives.log} \
    && rm -rf /var/log/apt/* \
    && rm -rf /var/apt/lists/* \
    && rm -rf /usr/share/man/?? /usr/share/man/??_*

RUN sed -i 's/#listen =/listen =/g' /etc/dovecot/dovecot.conf
RUN sed -i 's/#disable_plaintext_auth = yes/disable_plaintext_auth = no/g' /etc/dovecot/conf.d/10-auth.conf
RUN sed -i 's/auth_mechanisms = plain/auth_mechanisms = plain login/g' /etc/dovecot/conf.d/10-auth.conf
RUN sed -i 's@mail_location = mbox:~/mail:INBOX=/var/mail/%u@mail_location = maildir:/var/spool/mail/%u@g' /etc/dovecot/conf.d/10-mail.conf
RUN sed -i 's/#port = 143/port = 143/g' /etc/dovecot/conf.d/10-master.conf \
    && sed -i 's/#port = 993/port = 993/g' /etc/dovecot/conf.d/10-master.conf \ 
    && sed -i 's/#ssl = yes/ssl = yes/g' /etc/dovecot/conf.d/10-master.conf

EXPOSE 143 993

CMD ["/usr/sbin/dovecot", "-F"]
