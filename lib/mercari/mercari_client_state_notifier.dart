import 'package:axiaworks_flutter_tutorial/mercari/repository/mercari_repository.dart';
import 'package:axiaworks_flutter_tutorial/mercari/state/mercari_client_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mercariClientStateNotifier = StateNotifierProvider.autoDispose<
    MercariClientStateNotifier,
    MercariClientState>((ref) => MercariClientStateNotifier(ref.read));

class MercariClientStateNotifier extends StateNotifier<MercariClientState> {
  MercariClientStateNotifier(this._read) : super(const MercariClientState()) {
    fetchMercariItems();
  }

  final Reader _read;

  Future<void> fetchMercariItems() async {
    state = state.copyWith(isLoading: true);

    final mercariItems =
        await _read(mercariRepositoryProvider).fetchMercariItems();

    if (mercariItems.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        isReadyData: true,
        mercariItems: mercariItems,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isReadyData: false,
        mercariItems: mercariItems,
      );
    }
  }
}
