package com.dx.srb.core.mapper;

import com.dx.srb.core.pojo.entity.UserAccount;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;

/**
 * <p>
 * 用户账户 Mapper 接口
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
public interface UserAccountMapper extends BaseMapper<UserAccount> {
    //方便设置金额和冻结金额，写sql语句
    void updateAccount(@Param("bindCode") String bindCode,
                       @Param("amount") BigDecimal amount,
                       @Param("freezeAmount") BigDecimal freezeAmount);

}
