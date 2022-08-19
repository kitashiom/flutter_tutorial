import 'package:axiaworks_flutter_tutorial/mercari/api/mercari_api_client.dart';
import 'package:axiaworks_flutter_tutorial/mercari/model/mercari_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mercariRepositoryProvider =
    Provider<MercariRepository>((_) => MercariRepository());

class MercariRepository {
  MercariApiClient _api = MercariApiClient.create();

  Future<List<MercariItem>> fetchMercariItems() async {
    return _api.fetchMercariItems();
  }
}
