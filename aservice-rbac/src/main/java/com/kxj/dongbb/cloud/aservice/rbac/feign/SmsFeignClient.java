package com.kxj.dongbb.cloud.aservice.rbac.feign;


import com.kxj.dongbb.cloud.starter.web.exception.AjaxResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 伪装一个aervice-sms远程服务api接口
 *
 * @author xiangjin.kong
 * @date 2020/9/30 11:43
 */
@FeignClient("ASERVICE-SMS")
public interface SmsFeignClient {

    @PostMapping(value = "/sms/send")
    AjaxResponse send(@RequestParam("phoneNo") String phoneNo,
                      @RequestParam("content") String content);
}
