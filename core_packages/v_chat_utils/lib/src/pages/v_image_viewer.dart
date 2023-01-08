import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../v_chat_utils.dart';

class VImageViewer extends StatefulWidget {
  final VPlatformFileSource platformFileSource;
  final String appName;
  final String successfullyDownloaded;

  const VImageViewer({
    Key? key,
    required this.platformFileSource,
    required this.appName,
    required this.successfullyDownloaded,
  }) : super(key: key);

  @override
  State<VImageViewer> createState() => _VImageViewerState();
}

class _VImageViewerState extends State<VImageViewer> {
  @override
  Widget build(BuildContext context) {
    if (!widget.platformFileSource.isImage) {
      return Text("the file must be image ${widget.platformFileSource}");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: PhotoView(
        imageProvider: _getImageProvider(),
      ),
      floatingActionButton: widget.platformFileSource.isFromUrl
          ? FloatingActionButton(
              child: const Icon(Icons.save_alt),
              onPressed: () async {
                VAppAlert.showLoading(context: context);
                await VFileUtils.safeToPublicPath(
                  fileAttachment: widget.platformFileSource,
                  appName: widget.appName,
                );
                VAppAlert.showSuccessSnackBar(
                  msg: widget.successfullyDownloaded,
                  context: context,
                );
              },
            )
          : null,
    );
  }

  ImageProvider _getImageProvider() {
    if (widget.platformFileSource.isFromPath) {
      return FileImage(File(widget.platformFileSource.filePath!));
    }
    if (widget.platformFileSource.isFromBytes) {
      return MemoryImage(Uint8List.fromList(widget.platformFileSource.bytes!));
    }
    return CachedNetworkImageProvider(widget.platformFileSource.url!);
  }
}