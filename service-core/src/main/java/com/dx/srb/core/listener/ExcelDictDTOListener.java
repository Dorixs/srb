package com.dx.srb.core.listener;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.dx.srb.core.mapper.DictMapper;
import com.dx.srb.core.pojo.dto.ExcelDictDTO;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@Slf4j
public class ExcelDictDTOListener extends AnalysisEventListener<ExcelDictDTO> {

    private DictMapper dictMapper;

    //因为没有受到spring管理，不能使用自动注入的方式注入mapper，然后我们可以通过构造方法，传入mapper，使用mapper
    public ExcelDictDTOListener(DictMapper dictMapper) {
        this.dictMapper = dictMapper;
    }

    //创建一个集合存入数据，避免多次大量调用数据库接口
    List<ExcelDictDTO> list = new ArrayList<>();
    //定义常量临界值
    public static final int BATCH_COUNT = 5;

    @Override
    public void invoke(ExcelDictDTO data, AnalysisContext context) {
        list.add(data);
        if (list.size() >= BATCH_COUNT) {
            saveData();
            log.info(list.size()+"条数据存入数据库中");
            list.clear();
        }
    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext context) {
        //最后如果还剩余一些不足10条的数据，最后再次调用saveData方法进行收尾
        log.info("最后一次存入数据"+list.size()+"条");
        saveData();
        log.info("数据存入完毕");
    }

    public void saveData() {
        //在mapper中实现该方法
        dictMapper.insertBatch(list);

    }
}
