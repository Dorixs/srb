package com.dx.srb.sms.controller.api;

/**
 * @ClassName ApiSmsController
 * @Description TODO
 * @Author dx
 **/


import com.dx.srb.common.exception.Assert;
import com.dx.srb.common.result.R;
import com.dx.srb.common.result.ResponseEnum;
import com.dx.srb.common.util.RandomUtils;
import com.dx.srb.common.util.RegexValidateUtils;
import com.dx.srb.sms.client.CoreUserInfoClient;
import com.dx.srb.sms.service.SmsService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * @author dx
 */
@Api(tags = "短信发送")
@RestController
@RequestMapping("/api/sms")
//@CrossOrigin //跨域
@Slf4j
public class SmsController {

    @Resource
    private SmsService smsService;

    @Resource
    private RedisTemplate redisTemplate;

    @Resource
    private CoreUserInfoClient coreUserInfoClient;


    @GetMapping("/send/{mobile}")
    public R send(
            @ApiParam(value = "手机号",required = true)
            @PathVariable("mobile") String mobile) {

        //MOBILE_NULL_ERROR(-202, "手机号不能为空"),
        Assert.notEmpty(mobile, ResponseEnum.MOBILE_NULL_ERROR);
        //MOBILE_ERROR(-203, "手机号不正确"),
        Assert.isTrue(RegexValidateUtils.checkCellphone(mobile), ResponseEnum.MOBILE_ERROR);

        //远程调用校验手机号码
        Boolean b = coreUserInfoClient.checkMobile(mobile);
        Assert.isTrue(!b,ResponseEnum.MOBILE_EXIST_ERROR);
        //生成验证码
        String code = RandomUtils.getFourBitRandom();
        //组装短信模板参数
        Map<String, Object> param = new HashMap<>();
        param.put("code", code);
        //发送短信
//        smsService.send(mobile, param);

        //将验证码存入redis
        redisTemplate.opsForValue().set("srb:sms:code:" + mobile, code, 5, TimeUnit.MINUTES);

        return R.ok().message("短信发送成功");
    }
}