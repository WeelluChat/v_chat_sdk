import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:v_chat_sdk_core/src/http/socket/socket_controller.dart';
import 'package:v_chat_sdk_core/src/service/controller_helper.dart';
import 'package:v_chat_sdk_core/src/service/message_insert_trigger.dart';
import 'package:v_chat_sdk_core/src/service/re_send_daemon.dart';
import 'package:v_chat_sdk_core/src/user_apis/auth/auth.dart';
import 'package:v_chat_sdk_core/src/utils/api_constants.dart';
import 'package:v_chat_utils/v_chat_utils.dart';

import '../v_chat_sdk_core.dart';
import 'native_api/v_native_api.dart';

/// VChatController instance.
///
/// It must be initialized before used, otherwise an error is thrown.
///
/// ```dart
/// await VChatController.init(...)
/// ```
///
/// Use it:
///
/// ```dart
/// final i = VChatController.I;
/// ```
class VChatController with WidgetsBindingObserver {
  final _log = Logger('VChatController');

  static WidgetsBinding? get _widgetsBindingInstance => WidgetsBinding.instance;

  ///singleton
  VChatController._();

  static final _instance = VChatController._();

  static VChatController get I {
    assert(
      _instance._isControllerInit,
      'You must initialize the v chat controller instance before calling VChatController.I',
    );
    return _instance;
  }

  late final Auth auth;

  ///v chat variables
  late final ControllerHelper _helper;
  late final VChatConfig config;
  bool _isControllerInit = false;
  late final VNativeApi nativeApi;

  /// Initialize the [VChatController] instance.
  ///
  /// It's necessary to initialize before calling [VChatController.I]
  static Future<VChatController> init({
    required VChatConfig vChatConfig,
  }) async {
    assert(
      !_instance._isControllerInit,
      'This controller is already initialized',
    );
    _instance._isControllerInit = true;
    _instance.config = vChatConfig;
    await VAppPref.init();
    _instance._helper = await ControllerHelper.instance.init(
      _instance.config,
    );
    _instance.nativeApi = await VNativeApi.init();
    _instance.auth = Auth(
      _instance.nativeApi,
      _instance.config,
    );
    _widgetsBindingInstance?.addObserver(_instance);
    SocketController.instance.connect();
    mediaBaseUrl = AppConstants.getMediaBaseUrl;
    ReSendDaemon().start();
    MessageInsertionDaemon.start();
    return _instance;
  }

  void dispose() {
    _isControllerInit = false;
    _widgetsBindingInstance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _log.fine("AppLifecycleState.resumed:");
        break;
      case AppLifecycleState.inactive:
        _log.fine("AppLifecycleState.inactive:");
        break;
      case AppLifecycleState.paused:
        _log.fine("AppLifecycleState.paused:");
        break;
      case AppLifecycleState.detached:
        _log.fine("AppLifecycleState.detached:");
        break;
    }
  }

  ///make sure you already login or already login to v chat
  bool connectToSocket() {
    final access = VAppPref.getHashedString(key: VStorageKeys.accessToken);
    if (access == null) {
      _log.warning(
        "You try to connect to socket with out login please make sure you call VChatController.instance.login first",
      );
      return false;
    }
    SocketController.instance.connect();
    return true;
  }
}
