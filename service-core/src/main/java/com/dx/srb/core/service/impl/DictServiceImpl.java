package com.dx.srb.core.service.impl;

import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dx.srb.core.listener.ExcelDictDTOListener;
import com.dx.srb.core.mapper.DictMapper;
import com.dx.srb.core.pojo.dto.ExcelDictDTO;
import com.dx.srb.core.pojo.entity.Dict;
import com.dx.srb.core.service.DictService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.io.InputStream;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * <p>
 * 数据字典 服务实现类
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
@Slf4j
@Service
public class DictServiceImpl extends ServiceImpl<DictMapper, Dict> implements DictService {

    @Resource
    private RedisTemplate redisTemplate;


    //设置事务，同时成功或者失败，方便回滚数据
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void importData(InputStream inputStream) {
        //进行easyexcel的读取操作,通过有参构造传入basemapper
        EasyExcel.read(inputStream, ExcelDictDTO.class, new ExcelDictDTOListener(baseMapper)).sheet().doRead();
        log.info("Excel读取成功");
    }


    @Override
    public List<ExcelDictDTO> listDictData() {
        List<Dict> dictList = baseMapper.selectList(null);
        List<ExcelDictDTO> excelDictDTOList = dictList.stream().map((item) -> {
            ExcelDictDTO excelDictDTO = new ExcelDictDTO();
            BeanUtils.copyProperties(item, excelDictDTO);
            return excelDictDTO;
        }).collect(Collectors.toList());
        return excelDictDTOList;
    }

    @Override
    public List<Dict> listByParentId(Long parentId) {
        //设置redis
        //首先查询redis里面是否存在数据，捕获异常
        try {
            List<Dict> dictList1 =(List<Dict>) redisTemplate.opsForValue().get("srb:core:dictList:"+parentId);
            if (!CollectionUtils.isEmpty(dictList1)){
                log.info("从redis获取数据");
                return dictList1;
            }
        } catch (Exception e) {
            //输出错误消息
            log.info("redis服务器异常"+ ExceptionUtils.getStackTrace(e));
        }
        //如果不存在则查询数据库
        log.info("从数据库获取数据");
        LambdaQueryWrapper<Dict> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(Dict::getParentId, parentId);
        List<Dict> dictList = baseMapper.selectList(lambdaQueryWrapper);
        //填充hasChildren属性
        List<Dict> newDictList = dictList.stream().map((item) -> {
            //判断是否存在子节点
            Boolean hasChildren = hasChildren(item.getId());
            item.setHasChildren(hasChildren);
            return item;
        }).collect(Collectors.toList());
        //将查询的数据存入redis中
        try {
            redisTemplate.opsForValue().set("srb:core:dictList:"+parentId,newDictList,24, TimeUnit.HOURS);
        } catch (Exception e) {
            log.info("redis服务器异常"+ ExceptionUtils.getStackTrace(e));
        }
        return newDictList;
    }

    @Override
    public List<Dict> findByDictCode(String dictCode) {

        LambdaQueryWrapper<Dict> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Dict::getDictCode,dictCode);
        Dict dict = baseMapper.selectOne(lqw);
        return this.listByParentId(dict.getId());
    }

    //判断是否存在子节点
    public Boolean hasChildren(Long parentId) {
        LambdaQueryWrapper<Dict> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(Dict::getParentId, parentId);
        Integer count = baseMapper.selectCount(lambdaQueryWrapper);
        return count > 0;

    }
    @Override
    public String getNameByParentDictCodeAndValue(String dictCode, Integer value) {
        Dict parentDict = baseMapper.selectOne(
                new LambdaQueryWrapper<Dict>()
                        .eq(Dict::getDictCode, dictCode));
        if (parentDict == null) {
            return "";
        }
        Dict dict = baseMapper.selectOne(
                new LambdaQueryWrapper<Dict>()
                        .eq(Dict::getParentId, parentDict.getId())
                        .eq(Dict::getValue, value));
        if (dict == null) {
            return "";
        }
        return dict.getName();
    }

}
