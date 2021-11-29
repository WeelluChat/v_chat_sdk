import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textless/textless.dart';
import '../../services/v_chat_app_service.dart';
import '../../utils/custom_widgets/connection_checker.dart';
import 'cubit/room_cubit.dart';
import 'widgets/room_item.dart';

class VChatRoomsView extends StatelessWidget {
  const VChatRoomsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: RoomCubit.instance,
      child: const VChatRoomsScreen(),
    );
  }
}

class VChatRoomsScreen extends StatelessWidget {
  const VChatRoomsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RoomCubit.instance.setListViewListener();
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(children: [
        const ConnectionChecker(),
        const SizedBox(
          height: 12,
        ),
        BlocBuilder<RoomCubit, RoomState>(
          builder: (context, state) {
            if (state is RoomInitial) {
              return const SizedBox.shrink();
            } else if (state is RoomEmpty) {
              return "No rooms yet".text;
            } else if (state is RoomLoaded) {
              final rooms = state.rooms;
              final v = VChatAppService.instance.getTrans(context);
              return Expanded(
                child: Scrollbar(
                  child: ListView.separated(
                    controller: context.read<RoomCubit>().scrollController,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                    key: const PageStorageKey<String>('RoomsTabView'),
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      return Material(
                        child: SizedBox(
                          height: 70,
                          child: RoomItem(rooms[index]),
                        ),
                      );
                    },
                    itemCount: rooms.length,
                  ),
                ),
              );
            }
            throw UnimplementedError();
          },
        ),
      ]),
    );
  }
}