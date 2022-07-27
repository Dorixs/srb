package com.dx.srb.core.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dx.srb.common.exception.Assert;
import com.dx.srb.common.result.ResponseEnum;
import com.dx.srb.core.enums.BorrowInfoStatusEnum;
import com.dx.srb.core.enums.UserBindEnum;
import com.dx.srb.core.mapper.BorrowInfoMapper;
import com.dx.srb.core.mapper.BorrowerMapper;
import com.dx.srb.core.mapper.IntegralGradeMapper;
import com.dx.srb.core.mapper.UserInfoMapper;
import com.dx.srb.core.pojo.entity.BorrowInfo;
import com.dx.srb.core.pojo.entity.Borrower;
import com.dx.srb.core.pojo.entity.IntegralGrade;
import com.dx.srb.core.pojo.entity.UserInfo;
import com.dx.srb.core.pojo.vo.BorrowInfoApprovalVO;
import com.dx.srb.core.pojo.vo.BorrowerDetailVO;
import com.dx.srb.core.service.BorrowInfoService;
import com.dx.srb.core.service.BorrowerService;
import com.dx.srb.core.service.DictService;
import com.dx.srb.core.service.LendService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 借款信息表 服务实现类
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
@Service
public class BorrowInfoServiceImpl extends ServiceImpl<BorrowInfoMapper, BorrowInfo> implements BorrowInfoService {
    @Resource
    private IntegralGradeMapper integralGradeMapper;
    @Resource
    private UserInfoMapper userInfoMapper;
    @Resource
    private BorrowInfoMapper borrowInfoMapper;
    @Resource
    private DictService dictService;
    @Resource
    private BorrowerMapper borrowerMapper;
    @Resource
    private BorrowerService borrowerService;
    @Resource
    private LendService lendService;

    @Override
    public BigDecimal getBorrowAmount(Long userId) {
        UserInfo user = userInfoMapper.selectById(userId);
        LambdaQueryWrapper<IntegralGrade> lqw = new LambdaQueryWrapper<>();
        lqw.le(IntegralGrade::getIntegralStart, user.getIntegral())
                .ge(IntegralGrade::getIntegralEnd, user.getIntegral());
        IntegralGrade integralGrade = integralGradeMapper.selectOne(lqw);
        if (integralGrade.getBorrowAmount() == null) {
            return new BigDecimal("0");
        }
        return integralGrade.getBorrowAmount();


    }

    @Override
    public void saveBorrowInfo(BorrowInfo borrowInfo, Long userId) {
        //获取用户信息
        UserInfo userInfo = userInfoMapper.selectById(userId);
        //判断用户绑定状态
        Assert.isTrue(userInfo.getBindStatus().intValue() == UserBindEnum.BIND_OK.getStatus().intValue(), ResponseEnum.USER_NO_BIND_ERROR);
        //判断额度是否充足
        BigDecimal borrowAmount = this.getBorrowAmount(userId);
        Assert.isTrue(borrowInfo.getAmount().doubleValue() <= borrowAmount.doubleValue(), ResponseEnum.USER_AMOUNT_LESS_ERROR);
        //存储borrowInfo
        borrowInfo.setUserId(userId);
        //百分比转小数
        borrowInfo.setBorrowYearRate(borrowInfo.getBorrowYearRate().divide(new BigDecimal(100)));
        //设置借款申请审核状态
        borrowInfo.setStatus(BorrowInfoStatusEnum.CHECK_RUN.getStatus());
        baseMapper.insert(borrowInfo);
    }

    @Override
    public Integer getStatusByUserId(Long userId) {
        List<Object> objects = baseMapper.selectObjs(
                new LambdaQueryWrapper<BorrowInfo>()
                        .select(BorrowInfo::getStatus)
                        .eq(BorrowInfo::getUserId, userId));
        if (objects.size() == 0) {
            return BorrowInfoStatusEnum.NO_AUTH.getStatus();
        }
        return (Integer) objects.get(0);
    }

    @Override
    public List<BorrowInfo> selectList() {
        List<BorrowInfo> borrowInfoList = borrowInfoMapper.selectBorrowInfoList();
        //获取returnMethod和moneyUse
//        List<BorrowInfo> borrowInfos = borrowInfoList.stream().map((item) -> {
//            String returnMethod = dictService.getNameByParentDictCodeAndValue("returnMethod", item.getReturnMethod());
//            String moneyUse = dictService.getNameByParentDictCodeAndValue("moneyUse", item.getMoneyUse());
//            String status = BorrowInfoStatusEnum.getMsgByStatus(item.getStatus());
//            item.getParam().put("returnMethod", returnMethod);
//            item.getParam().put("moneyUse", moneyUse);
//            item.getParam().put("status", status);
//            return item;
//        }).collect(Collectors.toList());
        borrowInfoList.forEach(borrowInfo -> {
            String returnMethod = dictService.getNameByParentDictCodeAndValue("returnMethod", borrowInfo.getReturnMethod());
            String moneyUse = dictService.getNameByParentDictCodeAndValue("moneyUse", borrowInfo.getMoneyUse());
            //在后端封装status文本值
            String status = BorrowInfoStatusEnum.getMsgByStatus(borrowInfo.getStatus());

            borrowInfo.getParam().put("returnMethod", returnMethod);
            borrowInfo.getParam().put("moneyUse", moneyUse);
            borrowInfo.getParam().put("status", status);
        });
        return borrowInfoList;
    }

    @Override
    public Map<String, Object> getBorrowInfoDetail(Long id) {
        //先获取borrowInfo
        BorrowInfo borrowInfo = baseMapper.selectById(id);
        //组装
        String returnMethod = dictService.getNameByParentDictCodeAndValue("returnMethod", borrowInfo.getReturnMethod());
        String moneyUse = dictService.getNameByParentDictCodeAndValue("moneyUse", borrowInfo.getMoneyUse());
        //在后端封装status文本值
        String status = BorrowInfoStatusEnum.getMsgByStatus(borrowInfo.getStatus());

        borrowInfo.getParam().put("returnMethod", returnMethod);
        borrowInfo.getParam().put("moneyUse", moneyUse);
        borrowInfo.getParam().put("status", status);
        //获取borrower，封装为borroweDetaileVO
        LambdaQueryWrapper<Borrower> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Borrower::getUserId, borrowInfo.getUserId());
        Borrower borrower = borrowerMapper.selectOne(lqw);
        //根据之前封装的方法，得到borrowerDetailVO
        BorrowerDetailVO borrowerDetailVO = borrowerService.getBorrowerDetailVOById(borrower.getId());
        //创建map集合存入
        Map<String, Object> map = new HashMap<>();
        map.put("borrowInfo", borrowInfo);
        map.put("borrower", borrowerDetailVO);


        return map;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void approval(BorrowInfoApprovalVO borrowInfoApprovalVO) {
        //修改借款审核的状态（borrowInfo）
        //取出id
        Long borrowInfoId = borrowInfoApprovalVO.getId();
        BorrowInfo borrowInfo = baseMapper.selectById(borrowInfoId);
        borrowInfo.setStatus(borrowInfoApprovalVO.getStatus());
        baseMapper.updateById(borrowInfo);

        //审核通过新增标的（lend）
        if (borrowInfoApprovalVO.getStatus()==BorrowInfoStatusEnum.CHECK_OK.getStatus().intValue()){
            //新增标的
            lendService.createLend(borrowInfoApprovalVO,borrowInfo);


        }
    }
}
