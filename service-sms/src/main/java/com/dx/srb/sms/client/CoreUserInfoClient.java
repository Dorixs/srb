package com.dx.srb.sms.client;


import com.dx.srb.sms.client.fallback.CoreUserInfoClientFallBack;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(value = "service-core",fallback = CoreUserInfoClientFallBack.class)
public interface CoreUserInfoClient {
    @GetMapping("/api/core/userInfo/checkMobile/{mobile}")
    Boolean checkMobile(@PathVariable String mobile);
}
