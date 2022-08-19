import 'package:axiaworks_flutter_tutorial/mercari/model/mercari_item.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'mercari_api_client.g.dart';

@RestApi(baseUrl: 'https://flutter-tutorial-3cc9b.web.app/api/v1/')
abstract class MercariApiClient {
  factory MercariApiClient(Dio dio, {String baseUrl}) = _MercariApiClient;

  static MercariApiClient create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return MercariApiClient(dio);
  }

  @GET('/mercari/mercari.json')
  Future<List<MercariItem>> fetchMercariItems();
}
