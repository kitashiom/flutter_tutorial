import 'package:axiaworks_flutter_tutorial/residence/repository/residence_repository.dart';
import 'package:axiaworks_flutter_tutorial/residence/state/residence_client_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final residenceClientStateNotifier = StateNotifierProvider.autoDispose<
    ResidenceClientStateNotifier,
    ResidenceClientState>((ref) => ResidenceClientStateNotifier(ref.read));

class ResidenceClientStateNotifier extends StateNotifier<ResidenceClientState> {
  ResidenceClientStateNotifier(this._read)
      : super(const ResidenceClientState()) {
    fetchResidenceItems();
  }

  final Reader _read;

  Future<void> fetchResidenceItems() async {
    state = state.copyWith(isLoading: true);

    final residenceItems =
        await _read(residenceRepositoryProvider).fetchResidenceItems();

    if (residenceItems.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        isReadyData: true,
        residenceItems: residenceItems,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isReadyData: false,
        residenceItems: residenceItems,
      );
    }
  }
}
