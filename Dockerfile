FROM debian:buster
RUN DEBIAN_FRONTEND=noninteractive \
bash -c \
'echo -e "deb http://deb.debian.org/debian buster main contrib\n\
deb http://deb.debian.org/debian buster-updates main\n\
deb http://security.debian.org/debian-security buster/updates main contrib\n\
deb http://ftp.debian.org/debian buster-backports main" > /etc/apt/sources.list\
&& apt-get -y update && apt-get -y upgrade'
RUN DEBIAN_FRONTEND=noninteractive \
apt-get -q -y install \
apt-utils \
tzdata \
python \
python-dev \
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
liblinear3 \
liblinear-dev \
libzbar-dev \
libzbar0 \
libgs-dev \
default-libmysqlclient-dev \
libgmp-dev \
python-passlib \
libsasl2-dev \
libldap2-dev \
python3 \
exim4-daemon-heavy \
python3-venv \
python3-dev \
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
ttf-mscorefonts-installer \
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
gfortran
RUN DEBIAN_FRONTEND=noninteractive \
apt-get -q -y install \
libgdbm-dev \
libdb5.3-dev \
libbz2-dev \
libexpat1-dev \
liblzma-dev \
libffi-dev \
uuid-dev
RUN DEBIAN_FRONTEND=noninteractive \
cd /opt \
&& wget -O Python-3.6.9.tgz https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz \
&& tar -zxf Python-3.6.9.tgz \
&& rm Python-3.6.9.tgz \
&& cd Python-3.6.9 \
&& ./configure --enable-shared --enable-ipv6 --enable-loadable-sqlite-extensions --with-dbmliborder=bdb:gdbm --with-computed-gotos --without-ensurepip --with-system-expat --with-system-libmpdec --with-system-ffi --prefix=/usr \
&& make \
&& make altinstall \
&& cd /tmp
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
cd /tmp \
&& mkdir -p /etc/ssl/docassemble \
   /usr/share/docassemble/local3.6 \
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
&& curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
&& cd ~ \
&& source ~/.profile \
&& nvm install 12.6.0 \
&& npm install mermaid.cli@0.5.1 \
&& rm ~/.profile"
USER root
RUN DEBIAN_FRONTEND=noninteractive TERM=xterm \
cd /usr/share/docassemble \
&& git clone https://github.com/letsencrypt/letsencrypt \
&& cd letsencrypt \
&& ./letsencrypt-auto --help \
&& echo "host   all   all  0.0.0.0/0   md5" >> /etc/postgresql/11/main/pg_hba.conf \
&& echo "listen_addresses = '*'" >> /etc/postgresql/11/main/postgresql.conf
CMD ["bash"]
