package com.kxj.dongbb.cloud.aservice.rbac;

import com.kxj.dongbb.cloud.starter.web.exception.AjaxResponse;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author xiangjin.kong
 * @date 2020/10/29 10:10
 */
@SpringBootTest
// junit5注解 == junit4 RunWith(SpringRunner.class) Spring Boot 2.1后SpringBootTest集成了ExtendWith
@ExtendWith(SpringExtension.class)
public class RestTemplateTest {

    @Autowired
    private RestTemplate restTemplate;

    @Test
    void httpPostForObject() {
        // 发送远程http请求的url
        String url = "http://localhost:8402/sms/send";
        // 发送到远程服务的参数
        MultiValueMap<String, Object> params = new LinkedMultiValueMap<>();
        params.add("phoneNo", "1321234567");
        params.add("content", "RestTemplate测试远程服务调用");
        // 通过RestTemplate对象发送Post请求
        AjaxResponse ajaxResponse = restTemplate.postForObject(url, params, AjaxResponse.class);

        System.out.println(ajaxResponse);
    }

    @Test
    void httpPostForEntity() {
        String url = "http://localhost:8402/sms/send";
        MultiValueMap<String, Object> params = new LinkedMultiValueMap<>();
        params.add("phoneNo", "123123124124");
        params.add("content", "RestTemplate测试远程服务调用");
        ResponseEntity<AjaxResponse> responseEntity = restTemplate.postForEntity(url, params, AjaxResponse.class);

        // 查看响应的状态吗
        HttpStatus statusCode = responseEntity.getStatusCode();
        System.out.println(statusCode);
        // 查看响应体
        System.out.println(responseEntity.getBody());
        // 查看响应头
        HttpHeaders headers = responseEntity.getHeaders();

        for (Map.Entry<String, List<String>> entry : headers.entrySet()) {
            System.out.println(entry.getKey() + ":" + entry.getValue());
        }
    }
}
