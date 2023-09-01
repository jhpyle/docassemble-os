FROM ubuntu:22.04
RUN DEBIAN_FRONTEND=noninteractive \
apt-get -y update \
&& apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive \
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
texlive-lang-cyrillic \
texlive-lang-french \
texlive-lang-italian \
texlive-lang-portuguese \
texlive-lang-german \
texlive-lang-european \
texlive-lang-spanish \
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
fonts-ebgaramond-extra \
ghostscript \
fonts-liberation \
cm-super \
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
busybox
RUN DEBIAN_FRONTEND=noninteractive \
apt-get -q -y install \
libgdbm-dev \
libdb5.3-dev \
libbz2-dev \
libexpat1-dev \
liblzma-dev \
libffi-dev \
uuid-dev \
&& apt-get -y remove libreoffice-report-builder \
&& apt-get -q -y install ttf-mscorefonts-installer \
&& apt-get -q -y remove nodejs \
&& apt-get -q -y remove nodejs-doc \
&& apt-get -q -y autoremove \
&& curl -fsSL https://deb.nodesource.com/setup_18.x | bash \
&& apt-get install -y nodejs \
&& apt-get -y autoremove \
# These lines for pdftk-java can be removed once on 22.10 or higher
&& curl http://ftp.us.debian.org/debian/pool/main/p/pdftk-java/pdftk-java_3.3.3-1_all.deb --output pdftk-java.deb \
&& dpkg -i pdftk-java.deb \
&& rm pdftk-java.deb \
&& npm install -g @mermaid-js/mermaid-cli
RUN DEBIAN_FRONTEND=noninteractive \
bash -c \
'if [[ "$(dpkg --print-architecture)" == "amd64" ]]; then cd /tmp && wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && dpkg -i ./google-chrome-stable_current_amd64.deb && rm ./google-chrome-stable_current_amd64.deb && wget -q https://github.com/jgm/pandoc/releases/download/3.1.6/pandoc-3.1.6-1-amd64.deb && dpkg -i pandoc-3.1.6-1-amd64.deb && rm pandoc-3.1.6-1-amd64.deb; elif [[ "$(dpkg --print-architecture)" == "arm64" ]]; then cd /tmp && wget -q https://github.com/jgm/pandoc/releases/download/3.1.6/pandoc-3.1.6-1-arm64.deb && dpkg -i pandoc-3.1.6-1-arm64.deb && rm pandoc-3.1.6-1-arm64.deb; fi'
RUN DEBIAN_FRONTEND=noninteractive \
cd /tmp \
&& wget -q -O google-fonts.tar.gz https://github.com/google/fonts/archive/main.tar.gz \
&& tar -zxf google-fonts.tar.gz \
&& rm google-fonts.tar.gz \
&& mkdir -p /usr/share/fonts/truetype/google-fonts \
&& find ./fonts-main/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; \
&& rm -r ./fonts-main \
&& sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read | write" pattern="PDF" \/>/' /etc/ImageMagick-6/policy.xml \
&& sed -i 's/^#PATH/PATH/' /etc/crontab
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
cd /tmp \
&& mkdir -p /etc/ssl/docassemble \
   /usr/share/docassemble/local3.10 \
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
&& curl -sL https://aka.ms/InstallAzureCLIDeb | bash
USER www-data
RUN bash -c \
"echo '{ \"args\": [\"--no-sandbox\"], \"executablePath\": \"/usr/bin/google-chrome\" }' > ~/puppeteer-config.json"
USER root
RUN bash -c "\
if [[ \"$(dpkg --print-architecture)\" == \"arm64\" ]]; then \
  sed -i \"s/scram-sha-256$/md5/\" /etc/postgresql/14/main/pg_hba.conf \
  && echo \"password_encryption = md5\" >> /etc/postgresql/14/main/postgresql.conf; \
  echo \"host   all   all  0.0.0.0/0   md5\" >> /etc/postgresql/14/main/pg_hba.conf; \
else \
  echo \"host   all   all  0.0.0.0/0   scram-sha-256\" >> /etc/postgresql/14/main/pg_hba.conf; \
fi; \
echo \"listen_addresses = '*'\" >> /etc/postgresql/14/main/postgresql.conf"
CMD ["bash"]
