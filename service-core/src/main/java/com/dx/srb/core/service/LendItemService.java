package com.dx.srb.core.service;

import com.dx.srb.core.pojo.entity.LendItem;
import com.baomidou.mybatisplus.extension.service.IService;
import com.dx.srb.core.pojo.vo.InvestVO;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 标的出借记录表 服务类
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
public interface LendItemService extends IService<LendItem> {
    String commitInvest(InvestVO investVO);

    void notify(Map<String, Object> paramMap);

    List<LendItem> selectByLendId(Long lendId, Integer status);

    List<LendItem> selectByLendId(Long lendId);

}
