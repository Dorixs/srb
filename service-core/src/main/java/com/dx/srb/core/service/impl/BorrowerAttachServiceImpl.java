package com.dx.srb.core.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.dx.srb.core.pojo.entity.BorrowerAttach;
import com.dx.srb.core.mapper.BorrowerAttachMapper;
import com.dx.srb.core.pojo.vo.BorrowerAttachVO;
import com.dx.srb.core.service.BorrowerAttachService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 借款人上传资源表 服务实现类
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
@Service
public class BorrowerAttachServiceImpl extends ServiceImpl<BorrowerAttachMapper, BorrowerAttach> implements BorrowerAttachService {

    @Override
    public List<BorrowerAttachVO> selectBorrowerAttachVOList(Long id) {
        LambdaQueryWrapper<BorrowerAttach> lqw = new LambdaQueryWrapper<>();
        lqw.eq(BorrowerAttach::getBorrowerId,id);
        List<BorrowerAttach> borrowerAttachList = baseMapper.selectList(lqw);
        List<BorrowerAttachVO> borrowerAttachVOList = borrowerAttachList.stream().map((item) -> {
            BorrowerAttachVO borrowerAttachVO = new BorrowerAttachVO();
            BeanUtils.copyProperties(item, borrowerAttachVO);
            return borrowerAttachVO;
        }).collect(Collectors.toList());
        return borrowerAttachVOList;
    }
}
