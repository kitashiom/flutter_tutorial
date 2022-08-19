import 'package:axiaworks_flutter_tutorial/mvvm/api/qiita_api_client.dart';
import 'package:axiaworks_flutter_tutorial/mvvm/model/qiita_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final qiitaRepositoryProvider =
    Provider<QiitaRepository>((_) => QiitaRepository());

class QiitaRepository {
  final QiitaApiClient _api = QiitaApiClient.create();

  Future<List<QiitaItem>> fetchQiitaItems(String tag) async {
    return _api.fetchQiitaItems(tag);
  }
}
