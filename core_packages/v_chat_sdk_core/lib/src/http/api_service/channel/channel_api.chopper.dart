// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ChannelApi extends ChannelApi {
  _$ChannelApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ChannelApi;

  @override
  Future<Response<dynamic>> getPeerRoom(String identifier) {
    final Uri $url = Uri.parse('channel/peer-room/${identifier}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> closeChat(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/close');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRoomById(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> changeRoomNotification(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/notification');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteRoom(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRooms(Map<String, dynamic> query) {
    final Uri $url = Uri.parse('channel/');
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deliverRoomMessages(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/deliver');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createBroadcast(
    List<PartValue<dynamic>> body,
    MultipartFile? file,
  ) {
    final Uri $url = Uri.parse('channel/broadcast');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<MultipartFile?>(
        'file',
        file,
      )
    ];
    $parts.addAll(body);
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateBroadcastTitle(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/title');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateBroadcastImage(
    String roomId,
    MultipartFile file,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/image');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<MultipartFile>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBroadcastMembers(
    String roomId,
    Map<String, dynamic> query,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/members');
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addParticipantsToBroadcast(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/members');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> kickBroadcastUser(
    String roomId,
    String peerId,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/members/${peerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyBroadcastInfo(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/broadcast/my-info');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createGroup(
    List<PartValue<dynamic>> body,
    MultipartFile? file,
  ) {
    final Uri $url = Uri.parse('channel/group');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<MultipartFile?>(
        'file',
        file,
      )
    ];
    $parts.addAll(body);
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> leaveGroup(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/group/leave');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateGroupTitle(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/title');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateGroupImage(
    String roomId,
    MultipartFile file,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/image');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<MultipartFile>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyGroupInfo(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/group/my-info');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyGroupStatus(String roomId) {
    final Uri $url = Uri.parse('channel/${roomId}/group/my-status');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getGroupMembers(
    String roomId,
    Map<String, dynamic> query,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/members');
    final Map<String, dynamic> $params = query;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addParticipantsToGroup(
    String roomId,
    Map<String, dynamic> body,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/members');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> changeUserGroupRole(
    String roomId,
    String peerId,
    String role,
  ) {
    final Uri $url =
        Uri.parse('channel/${roomId}/group/members/${peerId}/${role}');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> kickGroupUser(
    String roomId,
    String peerId,
  ) {
    final Uri $url = Uri.parse('channel/${roomId}/group/members/${peerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
