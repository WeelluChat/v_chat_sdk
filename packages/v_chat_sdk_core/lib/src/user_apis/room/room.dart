import 'package:logging/logging.dart';

import '../../../v_chat_sdk_core.dart';
import '../../http/api_service/channel/channel_api_service.dart';
import '../../service/controller_helper.dart';

class RoomApi {
  final VNativeApi _vNativeApi;
  final ControllerHelper _helper = ControllerHelper.instance;
  final VChatConfig _chatConfig;
  final _log = Logger('user_api.Room');

  ChannelApiService get _channelApiService => _vNativeApi.remote.remoteRoom;

  RoomApi(
    this._vNativeApi,
    this._chatConfig,
  );

  Future<VRoom> getPeerRoom({
    required String peerIdentifier,
  }) async {
    return _channelApiService.getPeerRoom(peerIdentifier);
  }
}