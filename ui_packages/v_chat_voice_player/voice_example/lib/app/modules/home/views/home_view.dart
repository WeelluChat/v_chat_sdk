import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_chat_utils/v_chat_utils.dart';
import 'package:v_chat_voice_player/v_chat_voice_player.dart';
import 'package:voice_example/app/modules/home/views/voice_player.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final controller = Get.find<HomeController>();
  final voicesList = <VoiceMessageModel>[];

  @override
  void initState() {
    super.initState();
    voicesList.addAll(List.generate(
      100,
      (i) => VoiceMessageModel(
        id: "$i",
        dataSource: PlatformFileSource.fromUrl(
          url: "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3",
          isFullUrl: true,
        ),
      ),
    ));
  }

  // void onComplete(String id) {
  //   final cIndex = list.indexWhere((e) => e.id == id);
  //   if (cIndex == -1) {
  //     return;
  //   }
  //   if (cIndex == list.length - 1) {
  //     return;
  //   }
  //   if (list.length - 1 != cIndex) {
  //     list[cIndex + 1].controller.initAndPlay();
  //   }
  // }
  //
  // void onPlaying(String id) {
  //   for (var e in list) {
  //     if (e.id != id) {
  //       if (e.controller.isPlaying) {
  //         e.controller.pausePlaying();
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example"),
        centerTitle: true,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            elevation: 0,
            heroTag: "cc",
            onPressed: () {
              final id = "${Random().nextInt(2364566745)}".toString();
              voicesList.insert(
                0,
                VoiceMessageModel(
                    id: "${DateTime.now().millisecond}",
                    dataSource: PlatformFileSource.fromUrl(
                      url:
                          "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3",
                      isFullUrl: true,
                    )),
              );
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 10,
          ),
          kIsWeb
              ? const SizedBox()
              : FloatingActionButton(
                  elevation: 0,
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return const VoicePlayer(
                          duration: Duration(seconds: 7, minutes: 3),
                          url:
                              "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3",
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.music_note),
                ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        reverse: false,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
          return VoiceMessageView(
            controller: controller.getVoiceController(voicesList[i]),
            key: ValueKey(voicesList[i].id),
          );
        },
        itemCount: voicesList.length,
      ),
    );
  }
}

class VoiceMessageModel {
  final String id;
  final PlatformFileSource dataSource;
  final int? maxDuration;

  VoiceMessageModel({
    required this.id,
    required this.dataSource,
    this.maxDuration,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoiceMessageModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
