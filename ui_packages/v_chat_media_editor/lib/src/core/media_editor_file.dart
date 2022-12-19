import 'package:v_chat_utils/v_chat_utils.dart';

abstract class BaseMediaEditor {
  bool isSelected = false;
  final String id;

  BaseMediaEditor({
    required this.id,
  });

  @override
  bool operator ==(Object other) => other is BaseMediaEditor && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class MediaEditorImage extends BaseMediaEditor {
  VMessageImageData data;

  MediaEditorImage({
    String? id,
    required this.data,
  }) : super(
          id: id ?? DateTime.now().microsecondsSinceEpoch.toString(),
        );

  @override
  String toString() {
    return 'MediaEditorImage{data: $data }';
  }
}

class MediaEditorVideo extends BaseMediaEditor {
  VMessageVideoData data;

  MediaEditorVideo({
    String? id,
    required this.data,
  }) : super(id: id ?? DateTime.now().microsecondsSinceEpoch.toString());

  @override
  String toString() {
    return 'MediaEditorVideo{data $data}';
  }
}

class MediaEditorFile extends BaseMediaEditor {
  VPlatformFileSource data;

  MediaEditorFile({
    String? id,
    required this.data,
  }) : super(id: id ?? DateTime.now().microsecondsSinceEpoch.toString());

  @override
  String toString() {
    return 'MediaEditorFile{data $data}';
  }
}