FROM maven:3.8.4-openjdk-17 as builder
WORKDIR /app
COPY . /app/.
RUN mvn -f /app/pom.xml clean package -Dmaven.test.skip=true

FROM openjdk:18.0.1-jdk
#eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/Task_list_maven-0.0.1-SNAPSHOT-spring-boot.jar /app/Task_list_maven-0.0.1-SNAPSHOT-spring-boot.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/Task_list_maven-0.0.1-SNAPSHOT-spring-boot.jar"]

#FROM maven:3.8.4-openjdk-17 as builder - указываем на основании какого образа,
#который докер стянет с docker hub мы будем билдить наш проект,
#as builder - это название, которое мы присвоили, для того чтобы обратиться с другого слоя образа для получения данных.
#
#WORKDIR /app - создаем директорию app внутри слоя образа.
#
#COPY . /app/. - копируем все наши папки с текущего проекта в папку app в слое образа.
#
#RUN mvn -f /app/pom.xml clean package -Dmaven.test.skip=true - запускаем maven,
#который билдит наш проект и получаем jar-ник.
#
#FROM eclipse-temurin:17-jre-alpine - снова указываем на основании какого образа,
#мы будем запускать наш проект, здесь уже мы не используем jdk, а только jre - так как нам не нужны инструменты разработчика.
#
#WORKDIR /app - создаем директорию app в новом слое образа.
#
#COPY --from=builder /app/target/.jar /app/.jar - копируем с предыдущего слоя с папки target наш jar-ник в папку app.
#
#EXPOSE 8080 - указываем на каком порту должен работать наш контейнер.
#
#ENTRYPOINT ["java", "-jar", "/app/*.jar"] - запускаем наше приложение в контейнере.