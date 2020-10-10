package com.kxj.dongbb.cloud.aservice.sms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication(scanBasePackages={"com.kxj.dongbb.cloud"})
@EnableEurekaClient
public class AserviceSmsApplication {

	public static void main(String[] args) {
		SpringApplication.run(AserviceSmsApplication.class, args);
	}

}
