# Используем образ Jenkins LTS
FROM jenkins/jenkins:lts

# Устанавливаем переменную окружения для версии Node.js
ENV NODEJS_VERSION=14

# Установка Node.js
USER root
RUN curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash -
RUN apt-get install -y nodejs

# Установка npm
RUN npm install -g npm@latest

# Возвращаемся в пользовательский режим Jenkins
USER jenkins

# Устанавливаем плагины Jenkins из файла plugins.txt
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
