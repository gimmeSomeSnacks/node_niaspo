# Используем образ с JDK
#FROM openjdk:11

#$ENV MAVEN_HOME /usr/share/maven
#ENV MAVEN_VERSION 3.8.2
#ENV PATH $MAVEN_HOME/bin:$PATH

#RUN apt-get update \
 #   && apt-get install -y maven \
  #  && rm -rf /var/lib/apt/lists/*

#COPY . /usr/src/app

#WORKDIR /usr/src/app

#RUN mvn clean install

#CMD ["java", "-jar", "target/myapp.jar"]



FROM maven:3.8.4-openjdk-11 AS builder

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем файлы проекта в контейнер
COPY pom.xml .
COPY src ./src

# Собираем проект с помощью Maven
RUN mvn clean package

# Отдельный образ для запуска приложения
FROM openjdk:11-jre-slim

# Копируем собранный JAR файл из предыдущего этапа
COPY --from=builder /app/target/app.jar /app/app.jar

# Запускаем приложение при старте контейнера
CMD ["java", "-jar", "/app/app.jar"]
