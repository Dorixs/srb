package com.dx.srb.core.controller.api;


import com.dx.srb.base.util.JwtUtils;
import com.dx.srb.common.exception.Assert;
import com.dx.srb.common.result.R;
import com.dx.srb.common.result.ResponseEnum;
import com.dx.srb.common.util.RegexValidateUtils;
import com.dx.srb.core.pojo.entity.UserAccount;
import com.dx.srb.core.pojo.vo.LoginVO;
import com.dx.srb.core.pojo.vo.RegisterVO;
import com.dx.srb.core.pojo.vo.UserIndexVO;
import com.dx.srb.core.pojo.vo.UserInfoVO;
import com.dx.srb.core.service.UserInfoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 * 用户基本信息 前端控制器
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
@Api(tags = "用户接口")
@RestController
//@CrossOrigin
@RequestMapping("/api/core/userInfo")
public class UserInfoController {
    @Resource
    private RedisTemplate redisTemplate;
    @Resource
    private UserInfoService userInfoService;

    @ApiOperation("用户注册")
    @PostMapping("/register")
    public R userRegister(@RequestBody RegisterVO registerVO){
        String code = registerVO.getCode();
        String password = registerVO.getPassword();
        String mobile = registerVO.getMobile();
        //做简单的校验
        Assert.notNull(password,ResponseEnum.PASSWORD_NULL_ERROR);
        Assert.notNull(code,ResponseEnum.CODE_NULL_ERROR);
        Assert.notNull(mobile,ResponseEnum.MOBILE_NULL_ERROR);
        Assert.isTrue(RegexValidateUtils.checkCellphone(mobile),ResponseEnum.MOBILE_ERROR);
        //校验验证码是否正确
        String codeGen = (String)redisTemplate.opsForValue().get("srb:sms:code:" + mobile);
        Assert.equals(code,codeGen, ResponseEnum.CODE_ERROR);

        //注册
        userInfoService.register(registerVO);
        return R.ok().message("注册成功");
    }
    @ApiOperation("用户登录")
    @PostMapping("/login")
    public R login(@RequestBody LoginVO loginVO , HttpServletRequest httpServletRequest){
        String mobile = loginVO.getMobile();
        String password = loginVO.getPassword();
        Assert.notNull(mobile,ResponseEnum.MOBILE_NULL_ERROR);
        Assert.notNull(password,ResponseEnum.PASSWORD_NULL_ERROR);
        //获取远程主机地址
        String ip = httpServletRequest.getRemoteAddr();
        UserInfoVO userInfoVO = userInfoService.login(loginVO,ip);
        return R.ok().data("userInfo",userInfoVO);
    }

    @ApiOperation("校验令牌")
    @GetMapping("/checkToken")
    public R checkToken(HttpServletRequest request) {
        String token = request.getHeader("token");
        // 校验token
        boolean result = JwtUtils.checkToken(token);
        if (result)
            return R.ok();
        else
            return R.setResult(ResponseEnum.LOGIN_AUTH_ERROR);
    }

    @ApiOperation("校验手机号是否已经被注册")
    @GetMapping("/checkMobile/{mobile}")
    public boolean checkMobile(@PathVariable String mobile) {
        return userInfoService.checkMobile(mobile);
    }

    @ApiOperation("获取个人空间用户信息")
    @GetMapping("/auth/getIndexUserInfo")
    public R getIndexUserInfo(HttpServletRequest request) {
        String token = request.getHeader("token");
        Long userId = JwtUtils.getUserId(token);
        UserIndexVO userIndexVO = userInfoService.getIndexUserInfo(userId);
        return R.ok().data("userIndexVO", userIndexVO);
    }

}

