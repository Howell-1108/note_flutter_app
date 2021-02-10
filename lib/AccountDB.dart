import 'package:decimal/decimal.dart';
import 'DBUtil.dart';
import 'TablesInit.dart';

List<Map> dataList = List<Map>();
List<Map> dataGroupList = List<Map>();
DBUtil dbUtil = null;

void initDB() async {
  TablesInit tables = TablesInit();
  tables.init();
  dbUtil = new DBUtil();
  //querygroupby();
}

void insertData(int item_type, String item_title, String item_notebook, String item_position)
async {
  await dbUtil.open();
  Map<String,Object> par = Map<String,Object>();
  par['type'] = item_type.toString();
  par['title'] = item_title;
 // par['moneyValue'] = item_moneyValue.toString();
  par['time_modify'] = DateTime.now().toString().substring(0,19);
  par['time_create'] = DateTime.now().toString().substring(0,19);
  par['notebook'] = item_notebook;
  par['position'] = item_position;
  print(par);

  int flag = await dbUtil.insertByHelper('relation', par);
  print('flag:$flag');
  await dbUtil.close();
  queryData();
}

void delete() async{
  await dbUtil.open();
  dbUtil.delete('DELETE FROM relation', null);
  await dbUtil.close();
  queryData();
}

void deleteSingle(int id) async{
  await dbUtil.open();
  dbUtil.deleteByHelper('relation','id=?', [id]);
  await dbUtil.close();
  queryData();
}

void update(String _id, String _type, String _title, String _notebook, String _position, String _time_modify) async{
  await dbUtil.open();
  Map<String,Object> par = Map<String,Object>();
  if(_type!=null){par['type']=_type;}
  if(_title!=null){par['name']=_title;}
  if(_notebook!=null){par['notebook']=_notebook;}
  if(_position!=null){par['position']=_position;}
  if(_time_modify!=null){par['time_modify']=_time_modify;}
  print(_id);
  dbUtil.updateByHelper('relation', par, 'id=?', [int.parse(_id)]);
  await dbUtil.close();
  queryData();
}

void  queryData() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryList("SELECT * FROM relation WHERE type=0");
  print('data：$data');
  dataList = data;
  await dbUtil.close();
  return  ;
}
void queryOrderCreatePositive() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryOrderByHelper("relation",["*"],null,null,null,'time_create ASC');
  print('data：$data');
  dataList = data;
  await dbUtil.close();
}
void queryOrderCreateNegative() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryOrderByHelper("relation",["*"],null,null,null,'time_create DESC');
  print('data：$data');
  dataList = data;
  await dbUtil.close();
}
void queryOrderModifyPositive() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryOrderByHelper("relation",["*"],null,null,null,'time_modify ASC');
  print('data：$data');
  dataList = data;
  await dbUtil.close();
}
void queryOrderModifyNegative() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryOrderByHelper("relation",["*"],null,null,null,'time_modify DESC');
  print('data：$data');
  dataList = data;
  await dbUtil.close();
}