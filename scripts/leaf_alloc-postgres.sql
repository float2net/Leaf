----- POSTGRESQL 建库脚本 -----

--创建更新时间戳字段的函数
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.update_time = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

--创建 leaf_alloc 表
DROP TABLE IF EXISTS "leaf_alloc";
CREATE TABLE "leaf_alloc" (
  "biz_tag" varchar(128)  NOT NULL DEFAULT '',
  "max_id" int8 NOT NULL DEFAULT '1',
  "step" int8 NOT NULL,
  "description" varchar(256)  DEFAULT NULL,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("biz_tag")
) ;

--创建触发器，当修改表时更新时间戳字段
DROP TRIGGER IF EXISTS update_leaf_modtime on "leaf_alloc";
CREATE TRIGGER update_leaf_modtime BEFORE UPDATE ON "leaf_alloc" FOR EACH ROW EXECUTE PROCEDURE  update_modified_column();

--插入一条测试记录
insert into leaf_alloc(biz_tag, max_id, step, description) 
values('leaf-segment-test', 1, 2000, 'Test leaf Segment Mode Get Id')
