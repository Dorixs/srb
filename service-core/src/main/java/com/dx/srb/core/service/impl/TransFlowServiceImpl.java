package com.dx.srb.core.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.dx.srb.core.mapper.UserInfoMapper;
import com.dx.srb.core.pojo.bo.TransFlowBO;
import com.dx.srb.core.pojo.entity.TransFlow;
import com.dx.srb.core.mapper.TransFlowMapper;
import com.dx.srb.core.pojo.entity.UserInfo;
import com.dx.srb.core.service.TransFlowService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 交易流水表 服务实现类
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
@Service
public class TransFlowServiceImpl extends ServiceImpl<TransFlowMapper, TransFlow> implements TransFlowService {

    @Resource
    private UserInfoMapper userInfoMapper;

    @Override
    public void saveTransFlow(TransFlowBO transFlowBO) {
        // 查询userInfo
        String bindCode = transFlowBO.getBindCode();
        UserInfo userInfo = userInfoMapper.selectOne(
                new LambdaQueryWrapper<UserInfo>()
                        .eq(UserInfo::getBindCode, bindCode));

        TransFlow transFlow = new TransFlow();
        transFlow.setTransAmount(transFlowBO.getAmount());
        transFlow.setMemo(transFlowBO.getMemo());
        transFlow.setTransTypeName(transFlowBO.getTransTypeEnum().getTransTypeName());
        transFlow.setTransType(transFlowBO.getTransTypeEnum().getTransType());
        transFlow.setTransNo(transFlowBO.getAgentBillNo()); // 流水号
        transFlow.setUserId(userInfo.getId());
        transFlow.setUserName(userInfo.getName());
        // 保存交易流水
        baseMapper.insert(transFlow);
    }

    @Override
    public boolean isSaveTransFlow(String agentBillNo) {
        Integer count = baseMapper.selectCount(
                new LambdaQueryWrapper<TransFlow>()
                        .eq(TransFlow::getTransNo, agentBillNo));
        return count > 0;
    }

    @Override
    public List<TransFlow> selectByUserId(Long userId) {
        return baseMapper.selectList(
                new LambdaQueryWrapper<TransFlow>()
                        .eq(TransFlow::getUserId, userId)
                        .orderByDesc(TransFlow::getId));
    }
}
