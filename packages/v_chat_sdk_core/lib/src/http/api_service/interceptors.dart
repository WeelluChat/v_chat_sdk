import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:v_chat_utils/v_chat_utils.dart';

import '../../../v_chat_sdk_core.dart';
import '../../utils/api_constants.dart';

class ErrorInterceptor implements ErrorConverter {
  @override
  FutureOr<Response> convertError<BodyType, InnerType>(Response response) {
    final errorMap =
        jsonDecode(response.body.toString()) as Map<String, dynamic>;

    // String errStr = errorMap['data'].toString();
    // if (errStr.contains("t.")) {
    //   errStr = errorMap['data'].toString().split("t.")[1];
    // }
    return response.copyWith(
      bodyError: errorMap,
      body: errorMap,
    );
  }
}

void throwIfNotSuccess(Response res) {
  if (res.isSuccessful) return;
  if (res.statusCode == 400) {
    throw VChatHttpBadRequest(
      vChatException: (res.error! as Map<String, dynamic>)['data'].toString(),
    );
  } else if (res.statusCode == 404) {
    throw VChatHttpNotFound(
      vChatException: (res.error! as Map<String, dynamic>)['data'].toString(),
    );
  } else if (res.statusCode == 403) {
    throw VChatHttpForbidden(
      vChatException: (res.error! as Map<String, dynamic>)['data'].toString(),
    );
  }
  if (!res.isSuccessful) {
    throw VChatHttpBadRequest(
      vChatException: (res.error! as Map<String, dynamic>)['data'].toString(),
    );
  }
}

Map<String, dynamic> extractDataFromResponse(Response res) {
  return (res.body as Map<String, dynamic>)['data'] as Map<String, dynamic>;
}

class AuthInterceptor implements RequestInterceptor {
  final String? access;

  AuthInterceptor({this.access});

  @override
  FutureOr<Request> onRequest(Request request) {
    final oldHeaders = Map.of(request.headers);
    oldHeaders['authorization'] = "Bearer ${access ?? VAppPref.getHashedString(
          key: VStorageKeys.accessToken,
        )}";
    oldHeaders["clint-version"] = AppConstants.clintVersion;
    return request.copyWith(
      headers: oldHeaders,
    );
  }
}
