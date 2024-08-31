import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velveta_app/core/enums/request_type.dart';

class NetworkUtil {
  static String baseUrl = 'api.velveta.org';

  static Future sendRequest({
    required RequestType type,
    required String route,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    var url = Uri.https(baseUrl, route, params);

    http.Response response;

    switch (type) {
      case RequestType.POST:
        response = await http.post(url, body: body, headers: headers);
        break;
      case RequestType.GET:
        response = await http.get(url, headers: headers);
        break;
      case RequestType.DELETE:
        response =
            await http.delete(url, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.PUT:
        response =
            await http.put(url, body: jsonEncode(body), headers: headers);
        break;
    }

    Map<String, dynamic> jsonResponse = {};
    dynamic result;
    String decodedBody = Utf8Codec().decode(response.bodyBytes);

    try {
      result = jsonDecode(decodedBody);
    } catch (e) {}

    jsonResponse.putIfAbsent(
        'response', () => result ?? {'message': decodedBody});

    jsonResponse.putIfAbsent('statusCode', () => response.statusCode);

    return jsonResponse;
  }

  // static Future<dynamic> sendMultipartRequest({
  //   required String url,
  //   required RequestType type,
  //   Map<String, dynamic>? params,
  //   Map<String, String>? headers = const {},
  //   Map<String, String>? fields = const {},
  //   Map<String, String>? files = const {},
  // }) async {
  //   try {
  //     var request =
  //         http.MultipartRequest(type.name, Uri.https(baseUrl, url, params));

  //     var _filesKeyList = files!.keys.toList();
  //     var _filesNameList = files.values.toList();

  //     for (int i = 0; i < _filesKeyList.length; i++) {
  //       if (_filesNameList[i].isNotEmpty) {
  //         var multipartFile = http.MultipartFile.fromPath(
  //           _filesKeyList[i],
  //           _filesNameList[i],
  //           filename: path.basename(_filesNameList[i]),
  //           contentType:
  //               MediaType.parse(lookupMimeType(_filesNameList[i]) ?? ''),
  //         );
  //         request.files.add(await multipartFile);
  //       }
  //     }

  //     request.headers.addAll(headers!);
  //     request.fields.addAll(fields!);

  //     var response = await request.send();

  //     Map<String, dynamic> responseJson = {};
  //     var value;
  //     try {
  //       value = await response.stream.bytesToString();
  //     } catch (e) {
  //       print(e);
  //     }

  //     responseJson.putIfAbsent('statusCode', () => response.statusCode);
  //     responseJson.putIfAbsent('response', () => jsonDecode(value));

  //     return responseJson;
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }
}
