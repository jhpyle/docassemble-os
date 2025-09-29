FROM ubuntu:24.04
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
apt-get -q -y update \
&& apt-get -q -y upgrade \
&& apt-get -q -y dist-upgrade  \
&& apt-get -q -y autoremove \
&& apt-get -q clean
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
ln -snf /usr/share/zoneinfo/America/New_York /etc/localtime \
&& echo America/New_York > /etc/timezone \
&& echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
&& apt-get -q -y install language-pack-en \
&& apt-get -q -y install \
apt-utils \
tzdata \
wget \
unzip \
git \
locales \
nginx \
apache2 \
apache2-utils \
apache2-dev \
postgresql \
libapache2-mod-xsendfile \
gcc \
supervisor \
s4cmd \
make \
perl \
libinline-perl \
libparallel-forkmanager-perl \
autoconf \
automake \
libjpeg-dev \
libpq-dev \
logrotate \
npm \
cron \
libxml2 \
libxslt1.1 \
libu2f-udev \
libvulkan1 \
libxml2-dev \
libxslt1-dev \
libcurl4-openssl-dev \
libssl-dev \
redis-server \
rabbitmq-server \
libtool \
libtool-bin \
syslog-ng \
rsync \
curl \
dnsutils \
build-essential \
fonts-liberation \
fonts-dejavu-core \
libsvm3 \
libsvm-dev \
liblinear4 \
liblinear-dev \
libzbar-dev \
libzbar0 \
libgs-dev \
default-libmysqlclient-dev \
libgmp-dev \
python3-passlib \
python3-pip \
python3-venv \
python3-dev \
libsasl2-dev \
libldap2-dev \
exim4-daemon-heavy \
imagemagick \
pdftk \
pacpl \
pandoc \
texlive \
texlive-luatex \
texlive-xetex \
texlive-latex-recommended \
texlive-latex-extra \
texlive-font-utils \
texlive-lang-all \
texlive-extra-utils \
poppler-utils \
libaudio-flac-header-perl \
libaudio-musepack-perl \
libmp3-tag-perl \
libogg-vorbis-header-pureperl-perl \
libvorbis-dev \
libcddb-perl \
libcddb-get-perl \
libmp3-tag-perl \
libaudio-scan-perl \
libaudio-flac-header-perl \
ffmpeg \
tesseract-ocr-all \
libtesseract-dev \
wkhtmltopdf \
ghostscript \
qpdf \
wamerican \
libreoffice \
zlib1g-dev \
libncurses5-dev \
libncursesw5-dev \
libreadline-dev \
libsqlite3-dev \
liblapack-dev \
libblas-dev \
gfortran \
unixodbc-dev \
libaugeas0 \
libaugeas-dev \
busybox \
libdbus-1-dev
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
apt-get -q -y install \
libgdbm-dev \
libdb5.3-dev \
libbz2-dev \
libexpat1-dev \
liblzma-dev \
libffi-dev \
uuid-dev \
&& cd /tmp \
&& apt-get -q -y remove libreoffice-report-builder \
&& apt-get -q -y install ttf-mscorefonts-installer \
&& apt-get -q -y remove nodejs \
&& apt-get -q -y remove nodejs-doc \
&& apt-get -q -y autoremove \
&& curl -fsSL https://deb.nodesource.com/setup_current.x | bash \
&& apt-get -q -y install nodejs \
&& apt-get -q -y autoremove \
&& apt-get -q clean \
&& npm install -g @mermaid-js/mermaid-cli \
&& rm -rf /usr/lib/python3/dist-packages/setuptools-*.dist-info/ \
&& rm -rf /usr/lib/python3/dist-packages/certifi-*.dist-info/ \
&& rm -rf /usr/lib/python3/dist-packages/cryptography-*.dist-info/ \
&& rm -rf /usr/lib/python3/dist-packages/idna-*.dist-info/ \
&& rm -rf /usr/lib/python3/dist-packages/urllib3-*.dist-info/ \
&& rm -rf /usr/lib/python3/dist-packages/requests-*.dist-info/ \
&& pip3 install --upgrade --force-reinstall --break-system-packages \
     setuptools \
     certifi \
     cryptography \
     idna \
     urllib3 \
     requests
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
bash -c \
'cd /tmp && if [[ "$(dpkg --print-architecture)" == "amd64" ]]; then wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && dpkg -i ./google-chrome-stable_current_amd64.deb && rm ./google-chrome-stable_current_amd64.deb && wget -q https://github.com/jgm/pandoc/releases/download/3.8/pandoc-3.8-1-amd64.deb && dpkg -i pandoc-3.8-1-amd64.deb && rm pandoc-3.8-1-amd64.deb; elif [[ "$(dpkg --print-architecture)" == "arm64" ]]; then wget -q https://github.com/jgm/pandoc/releases/download/3.8/pandoc-3.8-1-arm64.deb && dpkg -i pandoc-3.8-1-arm64.deb && rm pandoc-3.8-1-arm64.deb; fi'
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
cd /tmp \
&& apt-get -q -y autoremove \
&& sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read | write" pattern="PDF" \/>/' /etc/ImageMagick-6/policy.xml \
&& sed -i 's/^#PATH/PATH/' /etc/crontab
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
cd /tmp \
&& mkdir -p /etc/ssl/docassemble \
   /usr/share/docassemble/local3.12 \
   /usr/share/docassemble/certs \
   /usr/share/docassemble/backup \
   /usr/share/docassemble/config \
   /usr/share/docassemble/webapp \
   /usr/share/docassemble/files \
   /usr/share/docassemble/cron \
   /usr/share/docassemble/syslogng \
   /var/www/.pip \
   /var/www/.cache \
   /var/run/uwsgi \
   /var/run/docassemble \
   /usr/share/docassemble/log \
   /tmp/docassemble \
   /var/www/html/log \
   /var/www/nascent \
&& chown -R www-data:www-data /var/www \
&& chown www-data:www-data /var/run/uwsgi \
&& chsh -s /bin/bash www-data \
&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
&& locale-gen \
&& update-locale \
&& curl -sL https://aka.ms/InstallAzureCLIDeb | bash
USER www-data
RUN bash -c \
"echo '{ \"args\": [\"--no-sandbox\"], \"executablePath\": \"/usr/bin/google-chrome\" }' > ~/puppeteer-config.json"
USER root
RUN bash -c "\
if [[ \"$(dpkg --print-architecture)\" == \"arm64\" ]]; then \
  sed -i \"s/scram-sha-256$/md5/\" /etc/postgresql/16/main/pg_hba.conf \
  && echo \"password_encryption = md5\" >> /etc/postgresql/16/main/postgresql.conf; \
  echo \"host   all   all  0.0.0.0/0   md5\" >> /etc/postgresql/16/main/pg_hba.conf; \
else \
  echo \"host   all   all  0.0.0.0/0   scram-sha-256\" >> /etc/postgresql/16/main/pg_hba.conf; \
fi; \
echo \"listen_addresses = '*'\" >> /etc/postgresql/16/main/postgresql.conf"
USER ubuntu
CMD ["bash"]
