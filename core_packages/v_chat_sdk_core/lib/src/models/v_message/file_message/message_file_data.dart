// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:v_chat_utils/v_chat_utils.dart';

class VMessageFileData {
  VPlatformFileSource fileSource;

//<editor-fold desc="Data Methods">

  VMessageFileData({
    required this.fileSource,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VMessageFileData &&
          runtimeType == other.runtimeType &&
          fileSource == other.fileSource);

  @override
  int get hashCode => fileSource.hashCode;

  @override
  String toString() {
    return 'MessageFileData{ fileSource: $fileSource,}';
  }

  VMessageFileData copyWith({
    VPlatformFileSource? fileSource,
  }) {
    return VMessageFileData(
      fileSource: fileSource ?? this.fileSource,
    );
  }

  Map<String, dynamic> toMap() {
    return fileSource.toMap();
  }

  factory VMessageFileData.fromMap(Map<String, dynamic> map) {
    return VMessageFileData(
      fileSource: VPlatformFileSource.fromMap(map),
    );
  }

//</editor-fold>
}
