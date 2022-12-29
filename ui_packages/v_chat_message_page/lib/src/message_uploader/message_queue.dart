import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';

class MessageUploaderQueue {
  final _uploadQueue = <VMessageUploadModel>[];
  final _localStorage = VChatController.I.nativeApi.local.message;
  final _remoteStorage = VChatController.I.nativeApi.remote;

  ///singleton
  MessageUploaderQueue._();

  static MessageUploaderQueue get instance {
    return _instance;
  }

  static final _instance = MessageUploaderQueue._();

  Future<void> addToQueue(VMessageUploadModel uploadModel) async {
    if (!_uploadQueue.contains(uploadModel)) {
      _uploadQueue.add(uploadModel);
      _sendToApi(uploadModel);
    }
  }

  Future<void> _sendToApi(VMessageUploadModel uploadModel) async {
    try {
      final msg = await _remoteStorage.remoteMessage.createMessage(
        uploadModel,
      );
      _onSuccessToSend(msg);
    } on VChatHttpForbidden {
      await _deleteTheMessage(uploadModel);
      // rethrow;
    } on VChatBaseHttpException catch (err) {
      await _deleteTheMessage(uploadModel);
      print("VChatBaseHttpException $err");
      //rethrow;
    } on VUserInternetException catch (err) {
      await _setErrorToMessage(uploadModel);
      print("UserInternetExceptionUserInternetException $err");
    } catch (err) {
      await _deleteTheMessage(uploadModel);
      print("_onUnknownException   $err");
      // rethrow;
    } finally {
      _uploadQueue.remove(uploadModel);
    }
  }

  Future<void> _deleteMessage(String localId) async {
    final VBaseMessage? baseMessage =
        await _localStorage.getMessageByLocalId(localId);
    if (baseMessage != null) {
      await _localStorage.deleteMessageByLocalId(baseMessage);
    }
  }

  Future _setErrorToMessage(VMessageUploadModel uploadModel) async {
    final VBaseMessage? baseMessage =
        await _localStorage.getMessageByLocalId(uploadModel.msgLocalId);
    if (baseMessage != null) {
      baseMessage.messageStatus = MessageEmitStatus.error;
      await _localStorage.updateMessageSendingStatus(
        VUpdateMessageStatusEvent(
          roomId: baseMessage.roomId,
          localId: baseMessage.localId,
          emitState: baseMessage.messageStatus,
        ),
      );
    }
  }

  Future _deleteTheMessage(VMessageUploadModel uploadModel) async {
    await _deleteMessage(uploadModel.msgLocalId);
  }

  Future _onSuccessToSend(VBaseMessage messageModel) async {
    await _localStorage.updateFullMessage(
      messageModel,
    );
  }

  void clearQueue() {
    _uploadQueue.clear();
  }
}
