package com.kxj.dongbb.cloud.aservice.rbac.config;

import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.cloud.netflix.ribbon.RibbonClientHttpRequestFactory;
import org.springframework.cloud.netflix.ribbon.SpringClientFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.client.OkHttp3ClientHttpRequestFactory;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;

/**
 * @author xiangjin.kong
 * @date 2020/10/29 10:05
 *
 * 要使用RestTemplate, 必须是Spring环境， 首先要将它初始为一个Bean
 */
@Configuration
public class ContextConfig {

    /**
     * 默认实现，实现与urlConnection是一样的底层实现
     * @LoadBalanced 实现远程服务调用的负载均衡
     */
    @Bean
    @LoadBalanced
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    /**
     * 默认实现
     */
    @Bean("urlConnection")
    public RestTemplate urlConnectionRestTemplate() {
        RestTemplate restTemplate = new RestTemplate(new SimpleClientHttpRequestFactory());
        return restTemplate;
    }

    @Bean("httpClient")
    public RestTemplate httpClientRestTemplate() {
        RestTemplate restTemplate = new RestTemplate(new HttpComponentsClientHttpRequestFactory());
        return restTemplate;
    }

    @Bean("OKHttp3")
    public RestTemplate OKHttp3RestTemplate() {
        RestTemplate restTemplate = new RestTemplate(new OkHttp3ClientHttpRequestFactory());
        return restTemplate;
    }

}
