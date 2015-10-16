FROM lifei/baseimage

RUN apt-get install -y krb5-user fail2ban libpam-google-authenticator

RUN sed -i '2i auth required pam_google_authenticator.so' /etc/pam.d/sshd
RUN sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/#GSSAPIAuthentication no/GSSAPIAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/#UsePAM yes/UsePAM yes/' /etc/ssh/sshd_config

# Set up directorie s
RUN mkdir -p /var/run/fail2ban /etc/service/fail2ban
ADD fail2ban-supervisor.sh /etc/service/fail2ban/run
COPY fail2ban/* /etc/fail2ban/
RUN rm -f /etc/service/sshd/down
