package com.sankuai.inf.leaf.segment.dao;

import com.sankuai.inf.leaf.segment.model.LeafAlloc;

import java.util.List;

public interface IDAllocDao {
     List<LeafAlloc> getAllLeafAllocs();
     LeafAlloc updateMaxIdAndGetLeafAlloc(String tag);
     LeafAlloc updateMaxIdByCustomStepAndGetLeafAlloc(LeafAlloc leafAlloc);
     List<String> getAllTags();

     /**
      * 插入一条新的LeafAlloc记录.
      *
      * @param leafAlloc:
      * @return 返回插入的LeafAlloc，失败则返回null
      */
     LeafAlloc insertAndGetLeafAlloc(LeafAlloc leafAlloc);
}
