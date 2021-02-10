///数据表定义

class CreateTableSqls{
 //关系表语句
  static final String createTableSql_relation = '''
    CREATE TABLE IF NOT EXISTS relation (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    title  VARCHAR(210) NOT NULL, 
    type INTEGER(3) NOT NULL,
    notebook VARCHAR(255),
    position VARCHAR(255),
    time_modify  DATETIME NOT NULL,
    time_create  DATETIME NOT NULL
    );
    ''';
  Map<String,String> getAllTables(){
    Map<String,String> map = Map<String,String>();
    map['relation'] = createTableSql_relation;
    return map;
  }
}