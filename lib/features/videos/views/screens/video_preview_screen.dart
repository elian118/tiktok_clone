import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tiktok_clone/common/widgets/cst_text_field.dart';
import 'package:tiktok_clone/features/videos/view_models/upload_video_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isPicked;

  const VideoPreviewScreen({
    Key? key,
    required this.video,
    required this.isPicked,
  }) : super(key: key);

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool _isVideoSaved = false;

  Future<void> _initVideo() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    // await _videoPlayerController.play();

    setState(() {});
  }

  Future<void> _saveToGallery() async {
    if (_isVideoSaved) return;
    await GallerySaver.saveVideo(widget.video.path, albumName: "TikTok Clone!");
    _isVideoSaved = true;
    setState(() {});
  }

  void _onUploadPressed() {
    // XFile -> File
    ref.read(uploadVideoProvider.notifier).uploadVideo(File(widget.video.path),
        _titleController.text, _descController.text, context, mounted);
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Preview video'),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(_isVideoSaved
                  ? FontAwesomeIcons.check
                  : FontAwesomeIcons.download),
            ),
          IconButton(
            onPressed: ref.watch(uploadVideoProvider).isLoading
                ? () {} // 아무것도 안 함
                : _onUploadPressed,
            icon: ref.watch(uploadVideoProvider).isLoading
                ? const CircularProgressIndicator()
                : const FaIcon(FontAwesomeIcons.cloudArrowUp),
          ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? Stack(children: [
              VideoPlayer(_videoPlayerController),
              Positioned(
                left: 25,
                bottom: 80,
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                  ),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    children: [
                      CstTextField(
                        controller: _titleController,
                        hintText: 'Title',
                      ),
                      CstTextField(
                        controller: _descController,
                        hintText: 'Description',
                      ),
                    ],
                  ),
                ),
              )
            ])
          : null,
    );
  }
}
