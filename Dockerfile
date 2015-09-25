# Base Image
FROM ubuntu

MAINTAINER Wallace Roque <wallacerock@gmail.com>

# Pacotes necessários
RUN apt-get update && apt-get install -y vim curl git python build-essential

# Instalação NodeJS
#RUN curl --silent --location https://deb.nodesource.com/setup_4.x | sudo bash -
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo -E bash -
RUN apt-get update && apt-get install -y nodejs

# Instalação PM2
RUN npm install -g pm2

# Instalação Sinopia
ENV version v1.4.0
RUN git clone https://github.com/rlidwka/sinopia
WORKDIR /sinopia
RUN git checkout $version
RUN npm install --production

# Clean
RUN rm -rf .git
RUN npm cache clean

# Configuração
ADD config.yaml /sinopia/config.yaml

CMD ["pm2", "start", "./bin/sinopia", "--no-daemon"]

EXPOSE 4873
VOLUME /sinopia/storage
