package com.dx.srb.core.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.dx.srb.core.pojo.entity.UserLoginRecord;
import com.dx.srb.core.mapper.UserLoginRecordMapper;
import com.dx.srb.core.service.UserLoginRecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 用户登录记录表 服务实现类
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
@Service
public class UserLoginRecordServiceImpl extends ServiceImpl<UserLoginRecordMapper, UserLoginRecord> implements UserLoginRecordService {

    @Override
    public List<UserLoginRecord> listTop50(Long userId) {
        LambdaQueryWrapper<UserLoginRecord> lqw = new LambdaQueryWrapper<>();
        lqw.eq(UserLoginRecord::getUserId,userId).orderByDesc(UserLoginRecord::getId).last("limit 50");
        List<UserLoginRecord> userLoginRecordList = baseMapper.selectList(lqw);
        return userLoginRecordList;
    }
}
