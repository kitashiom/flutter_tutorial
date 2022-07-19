// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qiita_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _QiitaApiClient implements QiitaApiClient {
  _QiitaApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://qiita.com/api/v2/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<QiitaItem>> fetchQiitaItems(String tag) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await _dio.fetch<List<dynamic>>(
      _setStreamType<List<QiitaItem>>(
        Options(method: 'GET', headers: headers, extra: extra)
            .compose(
              _dio.options,
              '/tags/$tag/items',
              queryParameters: queryParameters,
              data: data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
      ),
    );
    final value = result.data!
        .map((dynamic i) => QiitaItem.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
