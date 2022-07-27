package com.dx.srb.core.controller.admin;


import com.alibaba.excel.EasyExcel;
import com.dx.srb.common.exception.BusinessException;
import com.dx.srb.common.result.R;
import com.dx.srb.common.result.ResponseEnum;
import com.dx.srb.core.pojo.dto.ExcelDictDTO;
import com.dx.srb.core.pojo.entity.Dict;
import com.dx.srb.core.service.DictService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

/**
 * <p>
 * 数据字典 前端控制器
 * </p>
 */
@Api(tags = "数据字典管理")
@RestController
@RequestMapping("/admin/core/dict")
@Slf4j
//@CrossOrigin
public class AdminDictController {

    @Resource
    private DictService dictService;

    /**
     * 导入Excel数据
     * @param file
     * @return
     */
    @ApiOperation("批量导入Excel数据")
    @PostMapping("/import")
    public R batchImport(
            @ApiParam(value = "Excel数据字典文件", required = true)
            @RequestParam("file") MultipartFile file) {
        try {
            dictService.importData(file.getInputStream());
            return R.ok().message("数据批量导入成功");
        } catch (Exception e) {
            throw new BusinessException(ResponseEnum.UPLOAD_ERROR, e);
        }
    }

    /**
     * 导出excel文件
     * @param response
     * @throws IOException
     */
    @ApiOperation("Excel数据的导出")
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws IOException {
        //TODO Swagger和EasyExcel有兼容问题，在使用Swagger对该方法进行测试时可能会产生问题
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("utf-8");
        String prefixPath = "mydict" + UUID.randomUUID().toString();
        String fileName = URLEncoder.encode(prefixPath, "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
        EasyExcel.write(response.getOutputStream(), ExcelDictDTO.class).sheet("数据字典").doWrite(dictService.listDictData());

    }


    /**
     * 实现懒加载，并且定义属性hasChildren 判断是否存在子节点
     * @param parentId
     * @return
     */
    @ApiOperation("根据上级id获取子节点数据列表")
    @GetMapping("/listByParentId/{parentId}")
    public R listByParentId(
            @ApiParam(value = "上级节点id", required = true)
            @PathVariable("parentId") Long parentId) {
        List<Dict> dictList = dictService.listByParentId(parentId);
        return R.ok().data("list", dictList);
    }
}

