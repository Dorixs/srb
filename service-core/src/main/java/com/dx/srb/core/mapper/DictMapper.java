package com.dx.srb.core.mapper;

import com.dx.srb.core.pojo.dto.ExcelDictDTO;
import com.dx.srb.core.pojo.entity.Dict;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 * 数据字典 Mapper 接口
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
public interface DictMapper extends BaseMapper<Dict> {


    void insertBatch(List<ExcelDictDTO> list);
}
