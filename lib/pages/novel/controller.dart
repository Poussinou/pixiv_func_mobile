import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart' as html show parse;
import 'package:pixiv_dart_api/vo/novel_js_data.dart';
import 'package:pixiv_func_mobile/app/api/api_client.dart';

class NovelController extends GetxController {
  final int id;

  NovelController(this.id);

  final CancelToken cancelToken = CancelToken();

  bool error = false;

  bool notFound = false;

  bool loading = false;

  NovelJSData? novelJSData;

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }

  NovelJSData decodeNovelHtml(html.Document document) {
    Map<String, dynamic>? json;
    final scriptTags = document.querySelectorAll('script');
    for (final scriptTag in scriptTags) {
      if (scriptTag.text.contains('Object.defineProperty(window, \'pixiv\'')) {
        //novel : { "id":"123123", ...... []}
        final jsonString = RegExp(r'({)(.*?)("id")(.*?)(]})').stringMatch(scriptTag.text);
        if (null != jsonString) {
          json = jsonDecode(jsonString);
        }

        break;
      }
    }

    return NovelJSData.fromJson(json!);
  }

  void loadData() {
    error = false;
    notFound = false;
    loading = true;
    Get.find<ApiClient>().getNovelHtml(id, cancelToken: cancelToken).then((result) {
      novelJSData = decodeNovelHtml(html.parse(result));
    }).catchError((e, s) {
      if (e is DioError && HttpStatus.notFound == e.response?.statusCode) {
        notFound = true;
      } else {
        error = true;
      }
    }).whenComplete(() {
      loading = false;
      update();
    });
  }
}
