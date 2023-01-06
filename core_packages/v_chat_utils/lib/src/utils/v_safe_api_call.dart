import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../v_chat_utils.dart';

Future<void> vSafeApiCall<T>({
  Function()? onLoading,
  required Future<T> Function() request,
  required Function(T response) onSuccess,
  VoidCallback? finallyCallback,
  bool ignoreTimeoutAndNoInternet = true,
  Function(String exception, StackTrace trace)? onError,
  bool showToastError = false,
}) async {
  try {
    if (onLoading != null) {
      onLoading();
    }
    final res = await request();
    await onSuccess(res);
    return;
  } on SocketException catch (err, stacktrace) {
    _showError(err, showToastError);
    if (onError != null) {
      onError(err.toString(), stacktrace);
    }
  } on TimeoutException catch (err, stacktrace) {
    _showError(err, showToastError);
    if (onError != null && !ignoreTimeoutAndNoInternet) {
      onError(err.toString(), stacktrace);
    }
  } catch (err, stacktrace) {
    _showError(err, showToastError);
    if (onError != null && !ignoreTimeoutAndNoInternet) {
      onError(err.toString(), stacktrace);
    }
    log("", error: err, stackTrace: stacktrace, level: 1000);
    return;
  } finally {
    if (finallyCallback != null) {
      finallyCallback();
    }
  }
  return;
}

void _showError(Object err, bool isAllow) {
  print("_showError_showError_showError_showError $isAllow");
  if (isAllow) {
    VAppAlert.showOverlaySupport(
      title: "Connection error",
      // subtitle: err.toString(),
      textStyle: const TextStyle(color: Colors.white),
      background: Colors.red,
    );
    // VAppAlert.showErrorSnackBar(
    //   msg: err.toString(),
    //   context: context,
    // );
  }
}