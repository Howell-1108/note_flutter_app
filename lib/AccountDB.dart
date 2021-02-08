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
  querygroupby();
}

void insertData(int item_type, String item_name, Decimal item_moneyValue, String item_description)
async {
  await dbUtil.open();
  Map<String,Object> par = Map<String,Object>();
  par['type'] = item_type.toString();
  par['name'] = item_name;
  par['moneyValue'] = item_moneyValue.toString();
  par['time'] = DateTime.now().toString().substring(0,10);
  par['description'] = item_description;
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

void update(String _id, String _type, String _name, String _moneyValue, String _description) async{
  await dbUtil.open();
  Map<String,Object> par = Map<String,Object>();
  if(_type!=null){par['type']=_type;}
  if(_name!=null){par['name']=_name;}
  if(_moneyValue!=null){par['moneyValue']=_moneyValue;}
  if(_description!=null){par['description']=_description;}
  print(_id);
  dbUtil.updateByHelper('relation', par, 'id=?', [int.parse(_id)]);
  await dbUtil.close();
  queryData();
}

void  queryData() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryList("SELECT * FROM relation");
  print('data：$data');
  dataList = data;
  await dbUtil.close();
  return  ;
}
void queryOrderByTypePositive() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryOrderByHelper("relation",["*"],null,null,null,'type ASC');
  print('data：$data');
  dataList = data;
  await dbUtil.close();
}
void queryOrderByTypeNegative() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryOrderByHelper("relation",["*"],null,null,null,'type DESC');
  print('data：$data');
  dataList = data;
  await dbUtil.close();
}
void queryOrderByTimePositive() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryOrderByHelper("relation",["*"],null,null,null,'time ASC');
  print('data：$data');
  dataList = data;
  await dbUtil.close();
}
void queryOrderByTimeNegative() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryOrderByHelper("relation",["*"],null,null,null,'time DESC');
  print('data：$data');
  dataList = data;
  await dbUtil.close();
}
void queryOrderByMoneyPositive() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryOrderByHelper("relation",["*"],null,null,null,'moneyValue ASC');
  print('data：$data');
  dataList = data;
  await dbUtil.close();
}
void queryOrderByMoneyNegative() async{
  await dbUtil.open();
  List<Map> data = await dbUtil.queryOrderByHelper("relation",["*"],null,null,null,'moneyValue DESC');
  print('data：$data');
  dataList = data;
  await dbUtil.close();
}
void querygroupby() async{
  await dbUtil.open();
  dataGroupList=[];
  List<Map> data = await dbUtil.queryOrderByHelper("relation",['type','SUM(moneyValue)'],null,null,'type',null);
  print('data：$data');
  dataGroupList.add({'type': 0,'SUM(moneyValue)': 0});
  dataGroupList.add({'type': 1,'SUM(moneyValue)': 0});
  dataGroupList.add({'type': 2,'SUM(moneyValue)': 0});
  dataGroupList.add({'type': 3,'SUM(moneyValue)': 0});
  print('dataGroupList：$dataGroupList');
  for(int i=0;i<data.length;i++){
    dataGroupList[data[i]['type']]['type']=data[i]['type'];
    dataGroupList[data[i]['type']]['SUM(moneyValue)']=data[i]['SUM(moneyValue)'];
  }
  print('dataGroupList：$dataGroupList');
  await dbUtil.close();
}