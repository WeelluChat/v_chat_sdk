import 'package:sqflite/sqflite.dart';

import '../../../../../v_chat_sdk_core.dart';
import '../../../../models/socket/on_deliver_room_messages_model.dart';
import '../../../tables/message_table.dart';
import '../../abstraction/base_local_message_repo.dart';

class SqlMessageImp extends BaseLocalMessageRepo {
  final Database _database;
  final _localId = MessageTable.columnLocalId;
  final _roomId = MessageTable.columnRoomId;
  final _table = MessageTable.tableName;

  SqlMessageImp(this._database);

  @override
  Future<int> delete(VDeleteMessageEvent event) {
    return _database.delete(
      _table,
      where: "$_localId =?",
      whereArgs: [event.localId],
    );
  }

  @override
  Future<VBaseMessage?> findByLocalId(String localId) async {
    final map = await _database.query(
      _table,
      where: "$_localId =?",
      whereArgs: [localId],
    );
    if (map.isEmpty) return null;
    return MessageFactory.createBaseMessage(map.first);
  }

  @override
  Future<int> insert(VInsertMessageEvent event) {
    return _database.insert(
      _table,
      event.messageModel.toLocalMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<List<VBaseMessage>> search({
    required String text,
    required String roomId,
    int limit = 150,
  }) async {
    final maps = await _database.query(
      _table,
      where: "$_roomId =? AND ${MessageTable.columnContent} LIKE '$text%'",
      whereArgs: [roomId],
      orderBy: "${MessageTable.columnCreatedAt} DESC",
      limit: limit,
    );
    return maps.map((e) => MessageFactory.createBaseMessage(e)).toList();
  }

  @override
  Future<int> updateMessageStatus(VUpdateMessageStatusEvent event) {
    return _database.update(
      _table,
      {
        MessageTable.columnMessageEmitStatus: event.emitState.name,
      },
      where: "$_localId =?",
      whereArgs: [event.localId],
    );
  }

  @override
  Future<int> updateMessageType(VUpdateMessageTypeEvent event) {
    return _database.update(
      _table,
      {
        MessageTable.columnMessageType: event.messageType.name,
      },
      where: "$_localId =?",
      whereArgs: [event.localId],
    );
  }

  @override
  Future<int> updateMessagesToDeliver(VUpdateMessageDeliverEvent event) {
    return _database.update(
      _table,
      {
        MessageTable.columnDeliveredAt: event.model.date,
      },
      where: '''
      ${MessageTable.columnRoomId} =?
      AND ${MessageTable.columnSenderId} =?
      AND  ${MessageTable.columnDeliveredAt} IS NULL 
      ''',
      whereArgs: [event.roomId, event.model.userId],
    );
  }

  @override
  Future<int> updateMessagesToSeen(VUpdateMessageSeenEvent event) async {
    await updateMessagesToDeliver(
      VUpdateMessageDeliverEvent(
        model: VSocketOnDeliverMessagesModel(
          roomId: event.roomId,
          userId: event.model.userId,
          date: event.model.date,
        ),
        roomId: event.roomId,
        localId: event.localId,
      ),
    );
    return _database.update(
      MessageTable.tableName,
      {
        MessageTable.columnSeenAt: event.model.date,
      },
      where: '''
          ${MessageTable.columnRoomId} =? 
          AND ${MessageTable.columnSenderId} =?
          AND ${MessageTable.columnSeenAt} IS NULL
          ''',
      whereArgs: [event.model.roomId, event.model.userId],
    );
  }

  @override
  Future<List<VBaseMessage>> getMessagesByStatus({
    required MessageEmitStatus status,
    int limit = 50,
  }) async {
    final maps = await _database.query(
      _table,
      where: "${MessageTable.columnMessageEmitStatus} =?",
      whereArgs: [status.name],
      orderBy: "${MessageTable.columnId} DESC",
      limit: limit,
    );
    return maps.map((e) => MessageFactory.createBaseMessage(e)).toList();
  }

  @override
  Future<VBaseMessage?> findOneMessageBeforeThis(
    String createdAt,
    String roomId,
  ) async {
    final maps = await _database.query(
      _table,
      where: "${MessageTable.columnCreatedAt} <? AND $_roomId =?",
      whereArgs: [createdAt, roomId],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return MessageFactory.createBaseMessage(maps.first);
  }

  @override
  Future<List<VBaseMessage>> getRoomMessages({
    required String roomId,
    int limit = 100,
    String? lastId,
  }) async {
    final maps = await _database.query(
      _table,
      orderBy: "${MessageTable.columnId} DESC",
      limit: limit,
      where: "$_roomId =?",
      whereArgs: [roomId],
    );
    return maps.map((e) => MessageFactory.createBaseMessage(e)).toList();
  }

  @override
  Future<int> updateMessagesFromSendingToError() {
    return _database.update(
      _table,
      {
        MessageTable.columnMessageEmitStatus: MessageEmitStatus.error.name,
      },
      where: "${MessageTable.columnMessageEmitStatus} =?",
      whereArgs: [MessageEmitStatus.sending.name],
    );
  }

  @override
  Future<int> insertMany(List<VBaseMessage> messages) async {
    final batch = _database.batch();
    for (final e in messages) {
      batch.insert(
        _table,
        e.toLocalMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
    return 1;
  }

  @override
  Future<void> reCreate() async {
    return _database.transaction((txn) => MessageTable.recreateTable(txn));
  }

  @override
  Future<int> deleteAllMessagesByRoomId(String roomId) {
    return _database.delete(_table, where: "$_roomId =?", whereArgs: [roomId]);
  }

  @override
  Future<int> updateFullMessage({
    required VBaseMessage baseMessage,
  }) {
    return _database.insert(
      _table,
      baseMessage.toLocalMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}