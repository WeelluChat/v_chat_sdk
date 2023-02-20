// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:platform_local_notifications/platform_local_notifications.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';
import 'package:v_chat_utils/v_chat_utils.dart';

class VNotificationListener {
  final VNativeApi nativeApi;
  final VChatConfig vChatConfig;
  final VNavigator vNavigator;

  final _log = Logger('VNotificationListener');

  VNotificationListener(
    this.nativeApi,
    this.vChatConfig,
    this.vNavigator,
  ) {
    _init();
  }

  Future<void> _setRoomSeen(String roomId) async {
    VChatController.I.nativeApi.remote.socketIo.emitSeenRoomMessages(roomId);
    await VChatController.I.nativeApi.local.room.updateRoomUnreadToZero(roomId);
  }

  Future<void> _init() async {
    if (vChatConfig.vPush.enableVForegroundNotification) {
      await PlatformNotifier.I.init(appName: "v_chat_sdk");
      PlatformNotifier.I.platformNotifierStream.listen((event) async {
        if (event.payload!.isEmpty) return;
        if (event is PluginNotificationReplyAction) {
          final txtMessage = VTextMessage.buildMessage(
            content: event.text,
            isEncrypted: vChatConfig.enableEndToEndMessageEncryption,
            roomId: event.payload!,
          );
          await MessageUploaderQueue.instance.addToQueue(
            await MessageFactory.createUploadMessage(txtMessage),
          );
          return;
        }
        if (event is PluginNotificationMarkRead) {
          await _setRoomSeen(event.payload!);
          return;
        }
        if (event is PluginNotificationClickAction) {
          final room = await VChatController.I.nativeApi.local.room
              .getOneWithLastMessageByRoomId(event.payload!);
          if (room == null) return;
          vNavigator.messageNavigator
              .toMessagePage(VChatController.I.navigationContext, room);
          return;
        }
      });
      nativeApi.streams.vOnNewNotificationStream.listen((event) {
        final message = event.message;
        final isRoomOpen = VRoomTracker.instance.isRoomOpen(message.roomId);
        if (!isRoomOpen && !message.isMeSender) {
          PlatformNotifier.I.showChatNotification(
            model: ShowPluginNotificationModel(
              id: message.hashCode,
              title: message.senderName,
              payload: message.roomId,
              body: message.realContentMentionParsedWithAt,
            ),
            userImage: message.senderImageThumb,
            userName: message.senderName,
            conversationTitle: message.senderName,
          );
        }
      });
    }
    nativeApi.streams.vOnNotificationsClickedStream.listen((event) {
      final message = event.message;
      final room = event.room;
      final isRoomOpen = VRoomTracker.instance.isRoomOpen(message.roomId);
      if (isRoomOpen) return;
      if (VChatController.I.navigatorKey.currentContext == null) {
        _log.shout(
          "(vOnNotificationsClickedStream) please set the navigatorKey context to handle the notification click VChatController.I.init(navigatorKey:)",
        );
        return;
      }
      vNavigator.messageNavigator
          .toMessagePage(VChatController.I.navigationContext, room);
    });
    if (!vChatConfig.isPushEnable) return;
    nativeApi.streams.vOnUpdateNotificationsTokenStream.listen((event) async {
      await nativeApi.remote.profile.addFcm(event.token);
    });
    _getOpenAppNotification();
  }

  Future<VRoom?> _getRoom(String roomId) async {
    return VChatController.I.nativeApi.local.room
        .getOneWithLastMessageByRoomId(roomId);
  }

  Future<void> _getOpenAppNotification() async {
    await VChatController.I.nativeApi.remote.socketIo.socketCompleter.future;
    await Future.delayed(const Duration(seconds: 2));
    final message =
        await vChatConfig.currentPushProviderService!.getOpenAppNotification();
    if (message == null) return;
    final room = await _getRoom(message.roomId);
    final isRoomOpen = VRoomTracker.instance.isRoomOpen(message.roomId);
    if (room == null || isRoomOpen) return;
    if (VChatController.I.navigatorKey.currentContext == null) {
      _log.shout(
        "(vOnNotificationsClickedStream) please set the navigatorKey context to handle the notification click VChatController.I.init(navigatorKey:)",
      );
      return;
    }
    vNavigator.messageNavigator.toMessagePage(
      VChatController.I.navigationContext,
      room,
    );
  }
}
