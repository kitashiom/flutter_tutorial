import 'package:axiaworks_flutter_tutorial/mvvm/model/qiita_item.dart';
import 'package:axiaworks_flutter_tutorial/mvvm/qiita_client_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QiitaTopScreen extends ConsumerWidget {
  const QiitaTopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(qiitaClientStateNotifier);

    return WillPopScope(
      onWillPop: state.isReadyData
          ? () {
              ref.read(qiitaClientStateNotifier.notifier).onBackHome();
              return Future.value(false);
            }
          : null,
      child: Scaffold(
        appBar: AppBar(
          title: state.isReadyData
              ? Text(state.currentTag)
              : const Text('QiitaClientSample'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Center(
              child: state.isReadyData
                  ? _createListView(state.qiitaItems)
                  : _createSearchButtons(ref),
            ),
            Visibility(
              visible: state.isLoading,
              child: const ColoredBox(
                color: Color(0x88000000),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // タグのボタンを押してデータが取得されたら表示されるリスト
  Widget _createListView(List<QiitaItem> qiitaItems) {
    return ListView.builder(
      itemCount: qiitaItems.length,
      itemBuilder: (context, index) {
        final item = qiitaItems[index];

        return Container(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
          constraints: const BoxConstraints(minHeight: 96, maxHeight: 96),
          child: Card(
            elevation: 8,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16),
              child: ListTile(
                leading: Image.network(item.user!.profileImageUrl!),
                title: Text(item.title!),
              ),
            ),
          ),
        );
      },
    );
  }

  // データ未取得時に表示するタグのボタン
  Widget _createSearchButtons(WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => ref
              .read(qiitaClientStateNotifier.notifier)
              .fetchQiitaItems('Flutter'),
          child: const Text('Flutter'),
        ),
        ElevatedButton(
          onPressed: () => ref
              .read(qiitaClientStateNotifier.notifier)
              .fetchQiitaItems('android'),
          child: const Text('android'),
        ),
        ElevatedButton(
          onPressed: () => ref
              .read(qiitaClientStateNotifier.notifier)
              .fetchQiitaItems('ios'),
          child: const Text('ios'),
        ),
      ],
    );
  }
}
