package com.eland;

import com.eland.dao.RollbackTaskDAO;
import com.eland.dao.SourceDatabaseMappingDAO;
import com.eland.pojo.model.IndexRollbackTaskEntity;
import com.eland.pojo.model.SourceDatabaseMappingEntity;
import com.eland.backend.GetMonthBetween;

import java.util.LinkedList;
import java.util.List;

public class ErrorTest {
    public static void main(String[] args) {
        String indexName = "WH_Instagram_1%202010%";
        String source = "wh_fb";
      /*  SourceDatabaseMappingDAO sourceDatabaseMappingDAO =new SourceDatabaseMappingDAO();
        List<SourceDatabaseMappingEntity> list= sourceDatabaseMappingDAO.selectBySource(source);
        for(SourceDatabaseMappingEntity test : list){
            System.out.println(test.getIndexName());
        }
        */
        System.out.println("123");


    }
}
