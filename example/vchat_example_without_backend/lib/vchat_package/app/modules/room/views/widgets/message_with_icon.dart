import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:textless/textless.dart';
import '../../../../enums/message_type.dart';
import '../../../../enums/room_type.dart';
import '../../../../models/vchat_room.dart';
import '../../../../services/vchat_app_service.dart';
import '../../../../utils/custom_widgets/circle_image.dart';



class MessageWithIcon extends StatelessWidget {
  final VchatRoom _room;
  final _myModel = VChatAppService.to.vChatUser!;

  MessageWithIcon(this._room);

  @override
  Widget build(BuildContext context) {
    if (_room.lastMessage.value.messageType == MessageType.info) {
      return _room.lastMessage.value.content.s1
          .maxLine(1)
          .size(17)
          .alignStart
          .overflowEllipsis;
    }

    return Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        Flexible(
            child: AutoDirection(
                text: _room.lastMessage.value.content,
                child: getMessageText())),
      ],
    );
  }

  Widget getMessageText() {
    if (_room.lastMessage.value.senderId != _myModel.id) {
      // i the receiver
      final _isMeSeen = _room.lastMessageSeenBy.contains(_myModel.id);
      if (_isMeSeen) {
        return _room.lastMessage.value.content.s1
            .maxLine(1)
            .size(17)
            .alignStart
            .overflowEllipsis;
      } else {
        return _room.lastMessage.value.content.s1
            .maxLine(1)
            .size(17)
            .alignStart
            .overflowEllipsis
            .bold;
      }
    } else {
      // i the sender
      final _isPeerSeen = _room.lastMessageSeenBy.length == 2;
      if (_room.roomType == RoomType.single && _isPeerSeen) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: _room.lastMessage.value.content.s1
                  .maxLine(1)
                  .size(17)
                  .alignStart
                  .overflowEllipsis,
            ),
            CircleImage.network(path: _room.thumbImage, height: 25, width: 25),
          ],
        );
      }

      return _room.lastMessage.value.content.s1
          .maxLine(1)
          .size(17)
          .alignStart
          .overflowEllipsis;
    }
  }
}