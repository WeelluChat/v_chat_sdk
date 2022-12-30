import 'package:flutter/material.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';

import '../../chat.dart';

class VChatPage extends StatefulWidget {
  const VChatPage({
    Key? key,
    required this.controller,
    this.onRoomItemPress,
    this.onRoomItemLongPress,
    this.floatingActionButton,
    this.appBar,
  }) : super(key: key);
  final VRoomController controller;
  final Function(VRoom room)? onRoomItemPress;
  final Function(VRoom room)? onRoomItemLongPress;
  final Widget? appBar;
  final Widget? floatingActionButton;

  @override
  State<VChatPage> createState() => _VChatPageState();
}

class _VChatPageState extends State<VChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: widget.appBar ??
            AppBar(
              title: const Text("Rooms"),
              centerTitle: true,
            ),
      ),
      body: Container(
        decoration: context.vRoomTheme.scaffoldDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const VSocketStatusWidget(),
            ValueListenableBuilder<VPaginationModel<VRoom>>(
              valueListenable: widget.controller.roomState.roomNotifier,
              builder: (_, value, __) {
                return Expanded(
                  child: ListView.builder(
                    key: UniqueKey(),
                    cacheExtent: 300,
                    itemBuilder: (context, index) {
                      final room = value.values[index];
                      return StreamBuilder<VRoom>(
                        stream: widget
                            .controller.roomState.roomStateStream.stream
                            .skipWhile(
                          (e) => e.id != room.id,
                        ),
                        initialData: room,
                        builder: (context, snapshot) {
                          return VRoomItem(
                            room: snapshot.data!,
                            onRoomItemLongPress: (room) {
                              if (widget.onRoomItemLongPress != null) {
                                widget.onRoomItemLongPress!(room);
                              }
                              widget.controller
                                  .onRoomItemLongPress(room, context);
                            },
                            onRoomItemPress: (room) {
                              if (widget.onRoomItemPress != null) {
                                widget.onRoomItemPress!(room);
                              }
                              widget.controller.onRoomItemPress(room, context);
                            },
                          );
                        },
                      );
                    },
                    itemCount: value.values.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}