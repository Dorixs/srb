package com.dx.srb.core.service;

import com.dx.srb.core.pojo.entity.BorrowInfo;
import com.dx.srb.core.pojo.entity.Lend;
import com.baomidou.mybatisplus.extension.service.IService;
import com.dx.srb.core.pojo.vo.BorrowInfoApprovalVO;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 标的准备表 服务类
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
public interface LendService extends IService<Lend> {

    void createLend(BorrowInfoApprovalVO borrowInfoApprovalVO, BorrowInfo borrowInfo);


    List<Lend> selectList();
//
    Map<String, Object> getLendDetail(Long id);
//
    BigDecimal getInterestCount(BigDecimal invest, BigDecimal yearRate, Integer totalmonth, Integer returnMethod);
//
    void makeLoan(Long id);
}
