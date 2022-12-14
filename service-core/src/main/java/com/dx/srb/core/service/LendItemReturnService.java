package com.dx.srb.core.service;

import com.dx.srb.core.pojo.entity.LendItemReturn;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 标的出借回款记录表 服务类
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
public interface LendItemReturnService extends IService<LendItemReturn> {
    List<LendItemReturn> selectByLendId(Long lendId, Long userId);

    List<Map<String, Object>> addReturnDetail(Long lendReturnId);

    /**
     * 根据还款记录的id查询对应的回款记录
     *
     * @param lendReturnId
     * @return
     */
    List<LendItemReturn> selectLendItemReturnList(Long lendReturnId);

}
