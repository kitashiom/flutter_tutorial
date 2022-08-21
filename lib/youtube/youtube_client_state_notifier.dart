import 'package:axiaworks_flutter_tutorial/youtube/repository/youtube_repository.dart';
import 'package:axiaworks_flutter_tutorial/youtube/state/youtube_client_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final youtubeClientStateNotifier = StateNotifierProvider.autoDispose<
    YoutubeClientStateNotifier,
    YoutubeClientState>((ref) => YoutubeClientStateNotifier(ref.read));

class YoutubeClientStateNotifier extends StateNotifier<YoutubeClientState> {
  YoutubeClientStateNotifier(this._read) : super(const YoutubeClientState()) {
    fetchYoutubeItems();
  }

  final Reader _read;

  Future<void> fetchYoutubeItems() async {
    state = state.copyWith(isLoading: true);

    final youtubeItems =
        await _read(youtubeRepositoryProvider).fetchYoutubeItems();

    if (youtubeItems.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        isReadyData: true,
        youtubeItems: youtubeItems,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isReadyData: false,
        youtubeItems: youtubeItems,
      );
    }
  }
}
