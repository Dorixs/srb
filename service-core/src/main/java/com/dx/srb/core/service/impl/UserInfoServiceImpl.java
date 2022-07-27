package com.dx.srb.core.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dx.srb.base.util.JwtUtils;
import com.dx.srb.common.exception.Assert;
import com.dx.srb.common.result.ResponseEnum;
import com.dx.srb.common.util.MD5;
import com.dx.srb.core.mapper.UserAccountMapper;
import com.dx.srb.core.mapper.UserLoginRecordMapper;
import com.dx.srb.core.pojo.entity.UserAccount;
import com.dx.srb.core.pojo.entity.UserInfo;
import com.dx.srb.core.mapper.UserInfoMapper;
import com.dx.srb.core.pojo.entity.UserLoginRecord;
import com.dx.srb.core.pojo.query.UserInfoQuery;
import com.dx.srb.core.pojo.vo.LoginVO;
import com.dx.srb.core.pojo.vo.RegisterVO;
import com.dx.srb.core.pojo.vo.UserIndexVO;
import com.dx.srb.core.pojo.vo.UserInfoVO;
import com.dx.srb.core.service.UserInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * <p>
 * 用户基本信息 服务实现类
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements UserInfoService {

    @Resource
    private UserAccountMapper userAccountMapper;
    @Resource
    private UserLoginRecordMapper userLoginRecordMapper;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void register(RegisterVO registerVO) {
        //判断用户是否已经注册
        LambdaQueryWrapper<UserInfo> lqw = new LambdaQueryWrapper<>();
        lqw.eq(UserInfo::getMobile,registerVO.getMobile());
        Integer count = baseMapper.selectCount(lqw);
        Assert.isTrue(count==0, ResponseEnum.MOBILE_EXIST_ERROR);

        //插入用户信息 user_info表
        UserInfo userInfo = new UserInfo();
        userInfo.setUserType(registerVO.getUserType());
        userInfo.setName(registerVO.getMobile());
        userInfo.setNickName(registerVO.getMobile());
        userInfo.setMobile(registerVO.getMobile());
        userInfo.setPassword(MD5.encrypt(registerVO.getPassword()));
        userInfo.setStatus(UserInfo.STATUS_NORMAL);
        userInfo.setHeadImg(UserInfo.USER_AVATAR);
        baseMapper.insert(userInfo);
        //插入用户账户信息 user_account表
        UserAccount userAccount = new UserAccount();
        userAccount.setUserId(userInfo.getId());
        userAccountMapper.insert(userAccount);
    }

    @Override
    public UserInfoVO login(LoginVO loginVO, String ip) {
        String mobile = loginVO.getMobile();
        String password = loginVO.getPassword();
        Integer userType = loginVO.getUserType();
        //用户是否存在
        LambdaQueryWrapper<UserInfo> lqw = new LambdaQueryWrapper<>();
        lqw.eq(UserInfo::getMobile,mobile).eq(UserInfo::getUserType,userType);
        UserInfo one = baseMapper.selectOne(lqw);
        Assert.notNull(one,ResponseEnum.MOBILE_ERROR);
        //密码是否正确
        Assert.equals(MD5.encrypt(password),one.getPassword(),ResponseEnum.LOGIN_PASSWORD_ERROR);
        //用户是否被禁用
        Assert.equals(one.getStatus(),UserInfo.STATUS_NORMAL,ResponseEnum.LOGIN_LOKED_ERROR);
        //记录登录日志
        UserLoginRecord userLoginRecord = new UserLoginRecord();
        userLoginRecord.setUserId(one.getId());
        userLoginRecord.setIp(ip);
        userLoginRecordMapper.insert(userLoginRecord);
        //生成token
        String token = JwtUtils.createToken(one.getId(), one.getName());
        //组装userInfoVo
        UserInfoVO userInfoVO = new UserInfoVO();
        BeanUtils.copyProperties(one,userInfoVO);
        userInfoVO.setToken(token);
        //返回
        return userInfoVO;
    }

    @Override
    public IPage<UserInfo> listPage(Page<UserInfo> pageParam, UserInfoQuery userInfoQuery) {
        if (userInfoQuery==null){
            return baseMapper.selectPage(pageParam,null);
        }
        String mobile = userInfoQuery.getMobile();
        String userType = userInfoQuery.getUserType();
        String status = userInfoQuery.getStatus();
        LambdaQueryWrapper<UserInfo> lqw = new LambdaQueryWrapper<>();
        lqw.eq(mobile!=null,UserInfo::getMobile,mobile)
                .eq(userType!=null,UserInfo::getUserType,userType)
                .eq(status!=null,UserInfo::getStatus,status);

        return baseMapper.selectPage(pageParam,lqw);
    }

    @Override
    public void lock(Long id, Integer status) {
        UserInfo userInfo = new UserInfo();
        userInfo.setId(id);
        userInfo.setStatus(status);
        baseMapper.updateById(userInfo);
    }

    @Override
    public boolean checkMobile(String mobile) {
        LambdaQueryWrapper<UserInfo> lqw = new LambdaQueryWrapper<>();
        lqw.eq(UserInfo::getMobile,mobile);
        Integer count = baseMapper.selectCount(lqw);
        return count>0 ;
    }
    @Override
    public UserIndexVO getIndexUserInfo(Long userId) {
        //用户信息
        UserInfo userInfo = baseMapper.selectById(userId);

        //账户信息
        UserAccount userAccount = userAccountMapper.selectOne(
                new LambdaQueryWrapper<UserAccount>()
                        .eq(UserAccount::getUserId, userId));
        //登录信息
        UserLoginRecord userLoginRecord = userLoginRecordMapper.selectOne(
                new LambdaQueryWrapper<UserLoginRecord>()
                        .eq(UserLoginRecord::getUserId, userId)
                        .orderByDesc(UserLoginRecord::getId)
                        .last("limit 1"));

        //组装结果数据
        UserIndexVO userIndexVO = new UserIndexVO();
        userIndexVO.setUserId(userInfo.getId());
        userIndexVO.setUserType(userInfo.getUserType());
        userIndexVO.setName(userInfo.getName());
        userIndexVO.setNickName(userInfo.getNickName());
        userIndexVO.setHeadImg(userInfo.getHeadImg());
        userIndexVO.setBindStatus(userInfo.getBindStatus());
        userIndexVO.setAmount(userAccount.getAmount());
        userIndexVO.setFreezeAmount(userAccount.getFreezeAmount());
        userIndexVO.setLastLoginTime(userLoginRecord.getCreateTime());

        return userIndexVO;
    }

    @Override
    public String getMobileByBindCode(String bindCode) {
        UserInfo userInfo = baseMapper.selectOne(
                new LambdaQueryWrapper<UserInfo>()
                        .eq(UserInfo::getBindCode, bindCode));
        return userInfo.getMobile();
    }
}
