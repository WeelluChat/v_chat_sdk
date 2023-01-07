import 'package:diacritic/diacritic.dart';
import 'package:intl/intl.dart';

import '../../../v_chat_sdk_core.dart';
import '../../local_db/tables/room_table.dart';

class VRoom {
  final String id;
  String title;
  String enTitle;
  String thumbImage;
  VRoomType roomType;
  bool isArchived;
  int unReadCount;
  VBaseMessage lastMessage;
  bool isDeleted = false;
  final DateTime createdAt;
  bool isMuted;
  bool isOnline;
  VSocketRoomTypingModel typingStatus;
  String? nickName;
  final String? peerId;
  final String? peerIdentifier;
  String? blockerId;

  VRoom({
    required this.id,
    required this.title,
    required this.enTitle,
    required this.roomType,
    required this.thumbImage,
    required this.isArchived,
    required this.unReadCount,
    required this.lastMessage,
    required this.createdAt,
    required this.isMuted,
    this.isOnline = false,
    this.blockerId,
    required this.peerId,
    required this.peerIdentifier,
    required this.nickName,
    this.typingStatus = VSocketRoomTypingModel.offline,
  });

  VRoom.empty()
      : id = "",
        title = "",
        thumbImage = "empty!.png",
        isArchived = false,
        roomType = VRoomType.s,
        createdAt = DateTime.now(),
        enTitle = "",
        unReadCount = 0,
        isMuted = false,
        isDeleted = false,
        nickName = null,
        peerIdentifier = null,
        typingStatus = VSocketRoomTypingModel.offline,
        isOnline = false,
        blockerId = null,
        peerId = null,
        lastMessage = VEmptyMessage();

  VRoom.fromMap(Map<String, dynamic> map)
      : id = map['rId'] as String,
        title = map['t'] as String,
        thumbImage = map['img'] as String,
        isArchived = map['isA'] as bool,
        roomType = VRoomType.values.byName(map['rT'] as String),
        createdAt = DateTime.parse(map['createdAt'] as String),
        enTitle = removeDiacritics(map['t'] as String),
        unReadCount = map['uC'] as int,
        isMuted = map['isM'] as bool,
        isDeleted = map['isD'] as bool,
        peerIdentifier = map['pIdentifier'] as String?,
        nickName = null,
        typingStatus = VSocketRoomTypingModel.offline,
        isOnline = false,
        blockerId = map['bId'] as String?,
        peerId = map['pId'] as String?,
        lastMessage = map['lastMessage'] == null
            ? VEmptyMessage()
            : MessageFactory.createBaseMessage(
                map['lastMessage'] as Map<String, dynamic>,
              );

  VRoom.fromLocalMap(Map<String, dynamic> map)
      : id = map[RoomTable.columnId] as String,
        roomType =
            VRoomType.values.byName(map[RoomTable.columnRoomType] as String),
        title = map[RoomTable.columnTitle] as String,
        thumbImage = map[RoomTable.columnThumbImage] as String,
        isArchived = (map[RoomTable.columnIsArchived] as int) == 1,
        createdAt = DateTime.parse(map[RoomTable.columnCreatedAt] as String),
        enTitle = map[RoomTable.columnEnTitle] as String,
        unReadCount = map[RoomTable.columnUnReadCount] as int,
        isMuted = (map[RoomTable.columnIsMuted] as int) == 1,
        // isDeleted = (map[RoomTable.columnIsDeleted] as int) == 1,
        nickName = map[RoomTable.columnNickName] as String?,
        peerIdentifier = map[RoomTable.columnPeerIdentifier] as String?,
        typingStatus = VSocketRoomTypingModel.offline,
        isOnline = false,
        blockerId = map[RoomTable.columnBlockerId] as String?,
        peerId = map[RoomTable.columnPeerId] as String?,
        lastMessage = MessageFactory.createBaseMessage(map);

  Map<String, dynamic> toLocalMap() {
    return {
      RoomTable.columnId: id,
      RoomTable.columnTitle: title,
      RoomTable.columnThumbImage: thumbImage,
      RoomTable.columnEnTitle: enTitle,
      RoomTable.columnRoomType: roomType.name,
      RoomTable.columnIsArchived: isArchived ? 1 : 0,
      RoomTable.columnUnReadCount: unReadCount,
      RoomTable.columnCreatedAt: createdAt.toUtc().toIso8601String(),
      RoomTable.columnIsMuted: isMuted ? 1 : 0,
      RoomTable.columnPeerIdentifier: peerIdentifier,
      RoomTable.columnNickName: nickName,
      RoomTable.columnPeerId: peerId,
      RoomTable.columnBlockerId: blockerId,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VRoom && runtimeType == other.runtimeType && id == other.id);

  @override
  int get hashCode => id.hashCode;

  DateTime get lastMessageTime => lastMessage.createdAtDate;

  @override
  String toString() {
    return 'BaseRoom{id: $id, title: $title, enTitle: $enTitle, thumbImage: $thumbImage, roomType: $roomType, isArchived: $isArchived, unReadCount: $unReadCount, lastMessage: $lastMessage, isDeleted: $isDeleted, createdAt: $createdAt,}';
  }

  ///getters
  bool get isRoomMuted {
    final current = this;
    if (roomType.isSingle) {
      return current.isMuted;
    }
    if (roomType.isGroup) {
      return current.isMuted;
    }
    return false;
  }

  String? get roomTypingText {
    final current = this;
    if (roomType.isSingle) {
      return current.typingStatus.inSingleText;
    }
    if (roomType.isGroup) {
      return current.typingStatus.inGroupText;
    }
    return null;
  }

  bool get isRoomOnline {
    final current = this;
    if (roomType.isSingle) {
      return current.isOnline;
    }
    return false;
  }

  bool get isRoomUnread => unReadCount != 0;
  bool get isThereBlock => blockerId != null;

  bool get isMeBlocker {
    if (blockerId == null) return false;
    return VAppConstants.myProfile.baseUser.vChatId == blockerId;
  }

  String get lastMessageTimeString =>
      DateFormat.jm().format(lastMessage.createdAtDate);

  static VRoom fakeRoom(int id) {
    return VRoom(
      id: id.toString(),
      peerIdentifier: null,
      title: "${id == 0 ? "Group" : ""} $id",
      enTitle: "enTitle",
      thumbImage: "https://picsum.photos/300/${id + 299}",
      isArchived: false,
      roomType: id == 0 ? VRoomType.g : VRoomType.s,
      isMuted: id % 2 == 0,
      unReadCount: id % 2 == 0 ? 0 : id,
      lastMessage: VTextMessage.buildFakeMessage(index: id),
      createdAt: DateTime.now(),
      isOnline: id % 2 == 0,
      peerId: "peerId",
      blockerId: null,
      typingStatus: id == 0
          ? VSocketRoomTypingModel.typing
          : VSocketRoomTypingModel.offline,
      nickName: null,
    );
  }

  VRoom copyWith({
    String? id,
    String? title,
    String? enTitle,
    String? thumbImage,
    VRoomType? roomType,
    bool? isArchived,
    int? unReadCount,
    VBaseMessage? lastMessage,
    bool? isDeleted,
    DateTime? createdAt,
    bool? isMuted,
    bool? isOnline,
    VSocketRoomTypingModel? typingStatus,
    String? nickName,
    String? peerId,
    String? peerIdentifier,
    String? blockerId,
  }) {
    return VRoom(
      id: id ?? this.id,
      peerIdentifier: peerIdentifier ?? this.peerIdentifier,
      title: title ?? this.title,
      enTitle: enTitle ?? this.enTitle,
      thumbImage: thumbImage ?? this.thumbImage,
      roomType: roomType ?? this.roomType,
      isArchived: isArchived ?? this.isArchived,
      unReadCount: unReadCount ?? this.unReadCount,
      lastMessage: lastMessage ?? this.lastMessage,
      createdAt: createdAt ?? this.createdAt,
      isMuted: isMuted ?? this.isMuted,
      isOnline: isOnline ?? this.isOnline,
      typingStatus: typingStatus ?? this.typingStatus,
      nickName: nickName ?? this.nickName,
      peerId: peerId ?? this.peerId,
      blockerId: blockerId ?? this.blockerId,
    );
  }
}
