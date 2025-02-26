// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:v_chat_utils/v_chat_utils.dart';

class VAppLifeCycle extends VAppEvent {
  final bool isGoBackground;

  const VAppLifeCycle({
    required this.isGoBackground,
  });

  @override
  List<Object?> get props => [isGoBackground];
}
