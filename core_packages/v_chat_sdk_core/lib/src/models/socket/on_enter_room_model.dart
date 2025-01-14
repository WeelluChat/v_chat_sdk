// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:v_chat_sdk_core/src/utils/api_constants.dart';

class VSocketOnRoomSeenModel {
  final String roomId;
  final String userId;
  final String date;

  const VSocketOnRoomSeenModel({
    required this.roomId,
    required this.userId,
    required this.date,
  });

  DateTime get localDate => DateTime.parse(date).toLocal();

  @override
  String toString() {
    return 'OnEnterRoomModel{roomId: $roomId, userId: $userId, date: $date}';
  }

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'userId': userId,
      'date': date,
    };
  }

  bool get isMe => VAppConstants.myId == userId;

  factory VSocketOnRoomSeenModel.fromMap(Map<String, dynamic> map) {
    return VSocketOnRoomSeenModel(
      roomId: map['roomId'] as String,
      userId: map['userId'] as String,
      date: map['date'] as String,
    );
  }
}
