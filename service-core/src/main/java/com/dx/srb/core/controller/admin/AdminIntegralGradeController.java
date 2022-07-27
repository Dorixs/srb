package com.dx.srb.core.controller.admin;


import com.dx.srb.common.exception.Assert;
import com.dx.srb.common.result.R;
import com.dx.srb.common.result.ResponseEnum;
import com.dx.srb.core.pojo.entity.IntegralGrade;
import com.dx.srb.core.service.IntegralGradeService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 积分等级表 前端控制器
 * </p>
 *
 * @author dx
 * @since 2022-07-10
 */
@Api(tags = "积分等级管理")
//@CrossOrigin
@RestController
@RequestMapping("/admin/core/integralGrade")
public class AdminIntegralGradeController {
    @Resource
    private IntegralGradeService integralGradeService;

    @ApiOperation("获取积分列表")
    @GetMapping("/list")
    public R list() {
        List<IntegralGrade> list = integralGradeService.list();
        return R.ok().data("list", list).message("获取列表成功");
    }

    @ApiOperation(value = "根据id删除积分数据记录", notes = "逻辑删除记录")
    @DeleteMapping("/remove/{id}")
    public R removeById(
            @ApiParam(value = "数据id", required = true)
            @PathVariable Long id) {
        boolean result = integralGradeService.removeById(id);
        return result ? R.ok().message("删除成功") : R.error().message("删除失败");

    }

    @ApiOperation("新增积分等级")
    @PostMapping("/save")
    public R save(
            @ApiParam(value = "积分等级对象", required = true)
            @RequestBody IntegralGrade integralGrade) {
        //使用自定义断言工具类，抛出异常
        Assert.notNull(integralGrade.getBorrowAmount(), ResponseEnum.BORROW_AMOUNT_NULL_ERROR);
        boolean result = integralGradeService.save(integralGrade);
        return result ? R.ok().message("保存成功") : R.error().message("保存失败");
    }

    @ApiOperation("根据ID获取积分等级")
    @GetMapping("/get/{id}")
    public R getById(
            @ApiParam(value = "数据ID", required = true)
            @PathVariable("id") Long id) {
        IntegralGrade integralGrade = integralGradeService.getById(id);
        return (integralGrade != null) ? R.ok().data("record", integralGrade) : R.error().message("数据获取失败");
    }

    @ApiOperation("更新积分等级")
    @PutMapping("/update")
    public R updateById(
            @ApiParam(value = "积分等级对象", required = true)
            @RequestBody IntegralGrade integralGrade) {
        boolean result = integralGradeService.updateById(integralGrade);
        return result ? R.ok().message("更新成功") : R.error().message("更新失败");
    }

}

