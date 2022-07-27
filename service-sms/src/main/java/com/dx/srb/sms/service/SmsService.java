package com.dx.srb.sms.service;

import java.util.Map;

/**
 * @author dx
 */
public interface SmsService {
    void send(String mobile , Map<String,Object> param);
}
