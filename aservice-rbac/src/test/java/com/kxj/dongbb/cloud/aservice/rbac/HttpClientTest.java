package com.kxj.dongbb.cloud.aservice.rbac;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kxj.dongbb.cloud.starter.web.exception.AjaxResponse;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

/**
 * @author xiangjin.kong
 * @date 2020/10/28 19:38
 *
 *
 * HttpClient远程调用服务步骤
 * 1、创建HttpClient对象
 * 2、请求参数、地址配置
 * 3、请求封装与发送
 * 4、Http请求结果的获取HttpEntity
 * 5、获取Http请求结果中的响应体
 * 6、将响应体转成java对象
 */
@SpringBootTest
public class HttpClientTest {

    @Test
    public void httpPost() throws IOException {
        // 发送远程的http请求的地址
        String url = "http://localhost:8402/sms/send";
        // 创建HttpClient对象
        CloseableHttpClient client = HttpClients.createDefault();
        // 创建HttpPost对象，发送post请求
        HttpPost method = new HttpPost(url);
        // 封装发送到服务提供者的参数
        BasicNameValuePair phoneNo = new BasicNameValuePair("phoneNo", "13214409773");
        BasicNameValuePair content = new BasicNameValuePair("content", "HttpClient测试远程服务调用");
        List<NameValuePair> params = new ArrayList<>();
        params.add(phoneNo);
        params.add(content);
        // 封装请求体数据
        method.setEntity(new UrlEncodedFormEntity(params, "UTF-8"));
        // 发送具体的http请求
        CloseableHttpResponse response = client.execute(method);
        // 获得服务提供者响应的具体数据
        HttpEntity entity = response.getEntity();

        // 获得http的响应体
        InputStream inputStream = entity.getContent();
        int len = 0;
        char[] buf = new char[1024];
        // 使用字节流读取
        InputStreamReader reader = new InputStreamReader(inputStream);
        StringBuffer sb = new StringBuffer();
        while ((len = reader.read(buf)) != -1) {
            sb.append(String.valueOf(buf, 0, len));
        }

        // 转成对象
        ObjectMapper mapper = new ObjectMapper();
        AjaxResponse ajaxResponse = mapper.readValue(sb.toString(), AjaxResponse.class);
        System.out.println(ajaxResponse);
    }
}
