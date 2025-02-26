// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:v_chat_input_ui/src/models/models.dart';

class MessageRecordBtn extends StatelessWidget {
  final VoidCallback onRecordClick;

  const MessageRecordBtn({super.key, required this.onRecordClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRecordClick,
      child: context.vInputTheme.recordBtn,
    );
  }
}
