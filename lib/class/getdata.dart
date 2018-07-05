import 'package:dio/dio.dart';
import '../common/parameter.dart';
class GetData {
  loadData() async => await new Dio().get(Params.smsUrl);   

    /* http.Response response = await http.get(dataURL);     
    */  
}
