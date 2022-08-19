import 'package:axiaworks_flutter_tutorial/residence/model/residence_item.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'residence_api_client.g.dart';

@RestApi(baseUrl: 'https://flutter-tutorial-3cc9b.web.app/api/v1/')
abstract class ResidenceApiClient {
  factory ResidenceApiClient(Dio dio, {String baseUrl}) = _ResidenceApiClient;

  static ResidenceApiClient create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ResidenceApiClient(dio);
  }

  @GET('/residence/residence.json')
  Future<List<ResidenceItem>> fetchResidenceItems();
}
