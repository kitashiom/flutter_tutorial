import 'package:axiaworks_flutter_tutorial/residence/api/residence_api_client.dart';
import 'package:axiaworks_flutter_tutorial/residence/model/residence_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final residenceRepositoryProvider =
    Provider<ResidenceRepository>((_) => ResidenceRepository());

class ResidenceRepository {
  ResidenceApiClient _api = ResidenceApiClient.create();

  Future<List<ResidenceItem>> fetchResidenceItems() async {
    return _api.fetchResidenceItems();
  }
}
