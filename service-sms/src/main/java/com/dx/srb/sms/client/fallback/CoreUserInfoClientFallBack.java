package com.dx.srb.sms.client.fallback;

import com.dx.srb.sms.client.CoreUserInfoClient;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class CoreUserInfoClientFallBack implements CoreUserInfoClient {
    @Override
    public Boolean checkMobile(String mobile) {
        log.error("调用错误，服务熔断");
        return false;
    }
}
