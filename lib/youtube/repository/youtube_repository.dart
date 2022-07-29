import 'package:axiaworks_flutter_tutorial/youtube/api/youtube_api_client.dart';
import 'package:axiaworks_flutter_tutorial/youtube/model/youtube_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final youtubeRepositoryProvider =
    Provider<YoutubeRepository>((_) => YoutubeRepository());

class YoutubeRepository {
  final YoutubeApiClient _api = YoutubeApiClient.create();

  Future<List<YoutubeItem>> fetchYoutubeItems() async {
    return _api.fetchYoutubeItems();
  }
}
