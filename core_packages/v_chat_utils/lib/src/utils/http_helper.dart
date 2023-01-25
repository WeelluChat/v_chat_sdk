import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../v_chat_utils.dart';

abstract class HttpHelpers {
  static Future<http.MultipartFile> getMultipartFile({
    required VPlatformFileSource source,
    String fieldName = "file",
  }) async {
    if (VPlatforms.isWeb) {
      return http.MultipartFile.fromBytes(
        fieldName,
        filename: source.name,
        source.bytes!,
        contentType: source.mimeType == null
            ? null
            : MediaType.parse(
                source.mimeType!,
              ),
      );
    }
    return http.MultipartFile.fromPath(
      fieldName,
      source.filePath!,
      filename: source.name,
      contentType: source.mimeType == null
          ? null
          : MediaType.parse(
              source.mimeType!,
            ),
    );
  }
}