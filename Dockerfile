FROM ubuntu:21.10
RUN DEBIAN_FRONTEND=noninteractive \
apt-get -y update \
&& apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive \
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
&& apt-get -q -y install language-pack-en \
&& apt-get -q -y install ttf-mscorefonts-installer \
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
nodejs \
npm \
cron \
libxml2 \
libxslt1.1 \
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
libsasl2-dev \
libldap2-dev \
exim4-daemon-heavy \
imagemagick \
pdftk \
pacpl \
pandoc \
texlive \
texlive-luatex \
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
unoconv \
&& apt-get -y remove libreoffice-report-builder \
&& apt-get -y autoremove
RUN DEBIAN_FRONTEND=noninteractive \
bash -c \
'if [[ "$(dpkg --print-architecture)" == "amd64" ]]; then cd /tmp && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && dpkg -i ./google-chrome-stable_current_amd64.deb && rm ./google-chrome-stable_current_amd64.deb && wget -q https://github.com/jgm/pandoc/releases/download/2.17.1.1/pandoc-2.17.1.1-1-amd64.deb && dpkg -i pandoc-2.17.1.1-1-amd64.deb && rm pandoc-2.17.1.1-1-amd64.deb; elif [[ "$(dpkg --print-architecture)" == "arm64" ]]; then cd /tmp && wget -q https://github.com/jgm/pandoc/releases/download/2.17.1.1/pandoc-2.17.1.1-1-arm64.deb && dpkg -i pandoc-2.17.1.1-1-arm64.deb && rm pandoc-2.17.1.1-1-arm64.deb; fi'
RUN DEBIAN_FRONTEND=noninteractive \
cd /tmp \
&& sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read | write" pattern="PDF" \/>/' /etc/ImageMagick-6/policy.xml \
&& sed -i 's/^#PATH/PATH/' /etc/crontab \
&& cd /opt \
&& wget -O Python-3.8.12.tgz https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz \
&& tar -zxf Python-3.8.12.tgz \
&& rm Python-3.8.12.tgz \
&& cd Python-3.8.12 \
&& ./configure --enable-shared --prefix=/usr \
&& make \
&& make altinstall \
&& cd /tmp
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
cd /tmp \
&& mkdir -p /etc/ssl/docassemble \
   /usr/share/docassemble/local3.8 \
   /usr/share/docassemble/certs \
   /usr/share/docassemble/backup \
   /usr/share/docassemble/config \
   /usr/share/docassemble/webapp \
   /usr/share/docassemble/files \
   /var/www/.pip \
   /var/www/.cache \
   /var/run/uwsgi \
   /usr/share/docassemble/log \
   /tmp/docassemble \
   /var/www/html/log \
   /var/www/nascent \
   /var/www/node_modules/.bin \
&& chown -R www-data.www-data /var/www \
&& chown www-data.www-data /var/run/uwsgi \
&& chsh -s /bin/bash www-data \
&& ln -s /var/www/node_modules/.bin/mmdc /usr/local/bin/mmdc \
&& npm install -g azure-storage-cmd
USER www-data
RUN LC_CTYPE=C.UTF-8 LANG=C.UTF-8 \
bash -c \
"cd /tmp \
&& echo '{ \"args\": [\"--no-sandbox\"] }' > ~/puppeteer-config.json \
&& touch ~/.profile \
&& curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash \
&& cd ~ \
&& source ~/.profile \
&& nvm install 14.18.1 \
&& npm install mermaid.cli@0.5.1 \
&& rm ~/.profile"
USER root
RUN echo "host   all   all  0.0.0.0/0   md5" >> /etc/postgresql/13/main/pg_hba.conf \
&& echo "listen_addresses = '*'" >> /etc/postgresql/13/main/postgresql.conf
CMD ["bash"]
