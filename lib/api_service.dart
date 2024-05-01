import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://devlaundry.chplgroup.org/")
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET("/data_task.json")
  Future<dynamic> getData();
}
