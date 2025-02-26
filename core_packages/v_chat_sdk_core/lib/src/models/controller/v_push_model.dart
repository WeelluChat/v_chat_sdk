// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';

class VPush {
  final bool enableVForegroundNotification;
  final VLocalNotificationPushConfig vPushConfig;
  final VChatPushProviderBase? fcmProvider;
  final VChatPushProviderBase? oneSignalProvider;

  VPush({
    required this.enableVForegroundNotification,
    required this.vPushConfig,
    this.fcmProvider,
    this.oneSignalProvider,
  });

  VPush copyWith({
    bool? enableVForegroundNotification,
    VLocalNotificationPushConfig? vPushConfig,
    VChatPushProviderBase? fcmProvider,
    VChatPushProviderBase? oneSignalProvider,
  }) {
    return VPush(
      enableVForegroundNotification:
          enableVForegroundNotification ?? this.enableVForegroundNotification,
      vPushConfig: vPushConfig ?? this.vPushConfig,
      fcmProvider: fcmProvider ?? this.fcmProvider,
      oneSignalProvider: oneSignalProvider ?? this.oneSignalProvider,
    );
  }
}
