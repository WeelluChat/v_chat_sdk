import 'package:v_chat_utils/v_chat_utils.dart';

import '../../../v_chat_sdk_core.dart';

class VEmptyMessage extends VBaseMessage {
  VEmptyMessage()
      : super(
          id: "EmptyMessage",
          senderId: "EmptyMessage",
          senderName: "EmptyMessage",
          senderImageThumb: VFullUrlModel("Empty.url", isFullUrl: true),
          platform: "EmptyMessage",
          roomId: "EmptyMessage",
          content: "",
          messageType: MessageType.text,
          localId: "EmptyMessage",
          createdAt: DateTime.now().toLocal().toIso8601String(),
          updatedAt: DateTime.now().toLocal().toIso8601String(),
          replyTo: null,
          seenAt: null,
          isStared: false,
          deliveredAt: null,
          messageStatus: MessageEmitStatus.serverConfirm,
          forwardId: null,
          deletedAt: null,
          parentBroadcastId: null,
        );

  // @override
  // VEmptyMessage copyWith({
  //   String? id,
  //   String? senderId,
  //   String? senderName,
  //   VFullUrlModel? senderImageThumb,
  //   String? platform,
  //   String? roomId,
  //   bool? isTesting,
  //   String? content,
  //   MessageType? messageType,
  //   MessageSendingStatusEnum? messageStatus,
  //   VBaseMessage? replyTo,
  //   String? seenAt,
  //   String? deliveredAt,
  //   String? forwardId,
  //   String? deletedAt,
  //   String? parentBroadcastId,
  //   String? localId,
  //   String? createdAt,
  //   String? updatedAt,
  //   bool? isDeleted,
  //   bool? isStared,
  // }) {
  //   return VEmptyMessage(
  //     id: id ?? this.id,
  //     senderId: senderId ?? this.senderId,
  //     senderName: senderName ?? this.senderName,
  //     senderImageThumb: senderImageThumb ?? this.senderImageThumb,
  //     platform: platform ?? this.platform,
  //     roomId: roomId ?? this.roomId,
  //     isTesting: isTesting ?? this.isTesting,
  //     content: content ?? this.content,
  //     messageType: messageType ?? this.messageType,
  //     messageStatus: messageStatus ?? this.messageStatus,
  //     replyTo: replyTo ?? this.replyTo,
  //     seenAt: seenAt ?? this.seenAt,
  //     deliveredAt: deliveredAt ?? this.deliveredAt,
  //     forwardId: forwardId ?? this.forwardId,
  //     deletedAt: deletedAt ?? this.deletedAt,
  //     parentBroadcastId: parentBroadcastId ?? this.parentBroadcastId,
  //     localId: localId ?? this.localId,
  //     createdAt: createdAt ?? this.createdAt,
  //     updatedAt: updatedAt ?? this.updatedAt,
  //     isDeleted: isDeleted ?? this.isDeleted,
  //     isStared: isStared ?? this.isStared,
  //   );
  // }
}
