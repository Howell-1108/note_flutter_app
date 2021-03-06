import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Constants.dart' as Constants;

///sqflite数据库操作工具类
class DBUtil {
  Database db;

  ///sql助手插入 @tableName:表名  @paramters：参数map
  Future<int> insertByHelper(String tableName,Map<String,Object> paramters) async {

    return await db.insert(tableName, paramters);
  }
  ///sql原生插入 
  Future<int> insert(String sql,List paramters) async {
    //调用样例： dbUtil.insert('INSERT INTO Test(name, value) VALUES(?, ?)',['another name', 12345678]);
    return await db.rawInsert(sql,paramters);
  }

  ///sql助手查找列表  @tableName:表名  @selects 查询的字段数组 @wheres 条件，如：'uid=? and fuid=?' @whereArgs 参数数组
  Future<List<Map>> queryListByHelper(String tableName,List<String> selects,String whereStr,List whereArgs) async {
    //调用样例：await dbUtil.queryListByHelper('relation', ['id','uid','fuid'], 'uid=? and fuid=?', [6,1]);
    List<Map> maps = await db.query(
        tableName,
        columns: selects,
        where: whereStr,
        whereArgs: whereArgs);
    return maps;
  }
  Future<List<Map>> queryOrderByHelper(String tableName,List<String> selects,String whereStr,List whereArgs,String groupBystr,String ordBystr) async {
    //调用样例：await dbUtil.queryListByHelper('relation', ['id','uid','fuid'], 'uid=? and fuid=?', [6,1]);
    List<Map> maps = await db.query(
        tableName,
        columns: selects,
        where: whereStr,
        whereArgs: whereArgs,
        groupBy:groupBystr,
        orderBy: ordBystr
    );
    return maps;
  }
  ///sql原生查找列表
  Future<List<Map>> queryList(String sql) async {
    return await db.rawQuery(sql);
  }

  ///sql助手修改
  Future<int> updateByHelper(String tableName,Map<String,Object> setArgs,String whereStr,List whereArgs) async {
   return await db.update(
        tableName, 
        setArgs,
        where: whereStr, 
        whereArgs: whereArgs);
  }

  ///sql原生修改
  Future<int> update(String sql,List paramters) async {
     //样例：dbUtil.update('UPDATE relation SET fuid = ?, type = ? WHERE uid = ?', [1,2,3]);
     return await db.rawUpdate(sql,paramters);
  }

  ///sql助手删除   刪除全部whereStr和whereArgs传null
  Future<int> deleteByHelper(String tableName,String whereStr,List whereArgs) async {
    return await db.delete(
        tableName, 
        where: whereStr, 
        whereArgs: whereArgs);
  }

  ///sql原生删除
  Future<int> delete(String sql,List parameters) async {
    //样例： 样例：await dbUtil.delete('DELETE FROM relation WHERE uid = ? and fuid = ?', [123,234]);
    return await db.rawDelete(sql, parameters);
  }

  ///获取Batch对象，用于执行sql批处理
  Future<Batch> getBatch() async{
      return db.batch();
  }

  ///事务控制
  Future<dynamic> transaction(Future<dynamic> Function(Transaction txn) action)async{
     return await db.transaction(action);
  }
  

  //打开DB
  open() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath,Constants.DB_NAME);
    print('数据库存储路径path:'+path);
    try {
       db = await openDatabase(path);
       print('DB open');
    } catch (e) {
      print('DBUtil open() Error $e');
    }
  }

  // 记得及时关闭数据库，防止内存泄漏
  close() async {
    await db.close();
    print('DB close');
  }
}