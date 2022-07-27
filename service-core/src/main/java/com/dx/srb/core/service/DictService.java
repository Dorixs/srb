package com.dx.srb.core.service;

import com.dx.srb.core.pojo.dto.ExcelDictDTO;
import com.dx.srb.core.pojo.entity.Dict;
import com.baomidou.mybatisplus.extension.service.IService;

import java.io.InputStream;
import java.util.List;

/**
 * <p>
 * 数据字典 服务类
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
public interface DictService extends IService<Dict> {
    /**
     * 上传excel文件进行读取
     * @param inputStream
     */
    void importData(InputStream inputStream);

    /**
     * 查询数据字典数据
     * @return
     */
    List<ExcelDictDTO> listDictData();

    List<Dict> listByParentId(Long parentId);

    List<Dict> findByDictCode(String dictCode);

    String getNameByParentDictCodeAndValue(String education, Integer education1);
}
