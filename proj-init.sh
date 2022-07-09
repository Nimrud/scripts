#!/bin/bash

echo "please enter project name"
read NAME
echo "please enter Java version"
read JAVA_V

if [ "${NAME}" = "" ]
then
	echo "${0}: you need to enter the project name"
	exit 1
fi

if [ "${JAVA_V}" = "" ]
then
	echo "${0} you need to specify Java version"
	exit 1
fi

mkdir -p ~/IdeaProjects/${NAME}/src/{main,test}/{java,resources}
mkdir -p ~/IdeaProjects/${NAME}/src/main/java/com/epam/${NAME}
mkdir -p ~/IdeaProjects/${NAME}/src/test/java/com/epam/${NAME}
mkdir -p ~/IdeaProjects/${NAME}/target/{classes,test-classes}

cat > ~/IdeaProjects/${NAME}/src/main/java/com/epam/${NAME}/Main.java << textMain
package com.epam.${NAME};

class Main {
    public static void main(String... args) {
        System.out.println("Let's start!");
    }
}

textMain

cat > ~/IdeaProjects/${NAME}/pom.xml << textPom
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.epam</groupId>
    <artifactId>${NAME}</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.source>${JAVA_V}</maven.compiler.source>
        <maven.compiler.target>${JAVA_V}</maven.compiler.target>
        <version.maven>3.8.1</version.maven>
        <version.testng>7.5</version.testng>
        <version.junit>4.13.2</version.junit>
        <version.jacoco>0.8.7</version.jacoco>
        <version.assertj>3.22.0</version.assertj>
        <version.logback>1.2.11</version.logback>
        <version.persistence>3.1.0</version.persistence>
        <version.hibernate>6.1.0.Final</version.hibernate>
        <version.postgresql>42.3.6</version.postgresql>
        <version.plugin.maven.surefire>3.0.0-M5</version.plugin.maven.surefire>
        <version.plugin.maven.failsafe>3.0.0-M5</version.plugin.maven.failsafe>
        <version.plugin.maven.jar>3.2.0</version.plugin.maven.jar>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.testng</groupId>
            <artifactId>testng</artifactId>
            <version>\${version.testng}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>\${version.junit}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.assertj</groupId>
            <artifactId>assertj-core</artifactId>
            <version>\${version.assertj}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>\${version.logback}</version>
        </dependency>
        <dependency>
            <groupId>jakarta.persistence</groupId>
            <artifactId>jakarta.persistence-api</artifactId>
            <version>\${version.persistence}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.hibernate.orm</groupId>
            <artifactId>hibernate-core</artifactId>
            <version>\${version.hibernate}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <version>\${version.postgresql}</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <version>\${version.plugin.maven.jar}</version>
                <configuration>
                    <archive>
                        <manifest>
                            <addClasspath>true</addClasspath>
                            <mainClass>com.epam.${NAME}.Main</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>\${version.plugin.maven.surefire}</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-failsafe-plugin</artifactId>
                <version>\${version.plugin.maven.failsafe}</version>
                <configuration>
                    <groups>IT</groups>
                </configuration>
                <executions>
                    <execution>
                        <goals>
                            <goal>integration-test</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.jacoco</groupId>
                <artifactId>jacoco-maven-plugin</artifactId>
                <version>\${version.jacoco}</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>prepare-agent</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>report</id>
                        <phase>prepare-package</phase>
                        <goals>
                            <goal>report</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>

</project>
textPom

touch ~/IdeaProjects/${NAME}/.gitignore
curl https://www.toptal.com/developers/gitignore/api/java,intellij+all,maven > ~/IdeaProjects/${NAME}/.gitignore

xdg-open ~/IdeaProjects/${NAME}/pom.xml
