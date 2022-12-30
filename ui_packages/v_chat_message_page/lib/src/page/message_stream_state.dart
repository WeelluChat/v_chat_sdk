import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';
import 'package:v_chat_utils/v_chat_utils.dart';

import 'message_page/states/app_bar_state_controller.dart';
import 'message_page/states/input_state_controller.dart';
import 'message_page/states/message_state.dart';

class MessageStreamState with VMessageStream, VRoomStream {
  final MessageState messageState;
  final AppBarStateController appBarStateController;
  final InputStateController inputStateController;
  final VNativeApi nativeApi;
  final VRoom currentRoom;

  MessageStreamState({
    required this.messageState,
    required this.nativeApi,
    required this.appBarStateController,
    required this.inputStateController,
    required this.currentRoom,
  }) {
    ///listen to all message
    initMessageStream(
      nativeApi.local.message.messageStream.takeWhile(
        (e) => e.roomId == currentRoom.id,
      ),
    );
    initRoomStream(
      nativeApi.local.room.roomStream.takeWhile(
        (e) => e.roomId == currentRoom.id,
      ),
    );
  }

  void close() {
    closeRoomStream();
    closeMessageStream();
  }

  @override
  void onNewMsg(VInsertMessageEvent event) {
    return messageState.insertMessage(event.messageModel);
  }

  /////////////// room events ////////////
  @override
  void onUpdateOnline(VUpdateRoomOnlineEvent event) {
    return appBarStateController.updateOnline(event.model.isOnline);
  }

  @override
  void onUpdateRoomImage(VUpdateRoomImageEvent event) {
    return appBarStateController.updateImage(VFullUrlModel(event.image));
  }

  @override
  void onUpdateRoomName(VUpdateRoomNameEvent event) {
    return appBarStateController.updateTitle(event.name);
  }

  @override
  void onUpdateTyping(VUpdateRoomTypingEvent event) {
    return appBarStateController.updateTyping(event.typingModel);
  }

  @override
  void onAddOneToUnRead(VUpdateRoomUnReadCountByOneEvent event) {}

  @override
  void onBlockSingleRoom(VBlockSingleRoomEvent event) {
    if (event.banModel.banned) {
      return inputStateController.closeChat();
    }
    return inputStateController.openChat();
  }

  @override
  void onChangeMute(VUpdateRoomMuteEvent event) {}

  @override
  void onDeleteRoom(VDeleteRoomEvent event) {}

  @override
  void onInsertRoom(VInsertRoomEvent event) {}

  @override
  void onResetRoomCounter(VUpdateRoomUnReadCountToZeroEvent event) {}

  /////////////// message methods//////////
  @override
  void onDeleteMsg(VDeleteMessageEvent event) {
    return messageState.deleteMessage(event.localId);
  }

  @override
  void onDeliverAllMgs(VUpdateMessageDeliverEvent event) {
    return messageState.deliverAll(event.model);
  }

  @override
  void onSeenAllMgs(VUpdateMessageSeenEvent event) {
    return messageState.seenAll(event.model);
  }

  @override
  void onUpdateMsg(VUpdateMessageEvent event) {
    return messageState.updateMessage(event.messageModel);
  }

  @override
  void onUpdateMsgStatus(VUpdateMessageStatusEvent event) {
    return messageState.updateMessageStatus(event.localId, event.emitState);
  }

  @override
  void onUpdateMsgType(VUpdateMessageTypeEvent event) {
    return messageState.updateMessageType(event.localId, event.messageType);
  }
}