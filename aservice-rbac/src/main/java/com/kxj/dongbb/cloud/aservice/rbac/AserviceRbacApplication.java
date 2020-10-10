package com.kxj.dongbb.cloud.aservice.rbac;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication(scanBasePackages={"com.kxj.dongbb.cloud"})
@MapperScan(basePackages = {"com.kxj.dongbb.cloud.**.mapper"})
@EnableAutoConfiguration(exclude = {
		SecurityAutoConfiguration.class
})
@EnableEurekaClient
@EnableFeignClients
public class AserviceRbacApplication {

	public static void main(String[] args) {
		SpringApplication.run(AserviceRbacApplication.class, args);
	}

	@Bean
	public PasswordEncoder passwordEncoder(){
		return new BCryptPasswordEncoder();
	}

}
