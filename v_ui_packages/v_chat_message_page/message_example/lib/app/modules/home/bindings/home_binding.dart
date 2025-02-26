// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:get/get.dart';
import 'package:v_chat_sdk_core/v_chat_sdk_core.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(VRoom.fakeRoom(1)),
    );
  }
}
