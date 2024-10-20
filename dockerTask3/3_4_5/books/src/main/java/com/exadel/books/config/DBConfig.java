package com.exadel.books.config;

import javax.sql.DataSource;

import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import static java.lang.System.getenv;

@Configuration
public class DBConfig {

    @Bean
    public DataSource dataSource() {
        return DataSourceBuilder.create()
                .url("jdbc:postgresql://%s:5432/%s".formatted(getenv("DB_SERVER"), getenv("POSTGRES_DB")))
                .username(getenv("POSTGRES_USER"))
                .password(getenv("POSTGRES_PASSWORD"))
                .driverClassName("org.postgresql.Driver")
                .type(com.zaxxer.hikari.HikariDataSource.class)
                .build();
    }
}