// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:sheek/Locale/app_localization.dart';
import 'package:sheek/core/utils/app_colors.dart';

import '../widgets/atachment_widgets.dart';

enum MediaType { image, video }

class SelectedMedia {
  final File file;
  final MediaType type;

  SelectedMedia(this.file, this.type);
}

class VideoSelector extends StatefulWidget {
  const VideoSelector({super.key});

  @override
  State<VideoSelector> createState() => _VideoSelectorState();
}

class _VideoSelectorState extends State<VideoSelector> {
  List<SelectedMedia?> selectedMedia = [];
  final picker = ImagePicker();
  bool allowsImages = true;
  bool allowsVideos = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(AppColors.primaryColor),
            ),
            child: Text('select_image_or_video'.tr(context)),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Gallery (Image)'),
                          onTap: () {
                            allowsImages = true;
                            allowsVideos = false;
                            selectMedia(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Camera (Image)'),
                          onTap: () {
                            allowsImages = true;
                            allowsVideos = false;
                            selectMedia(ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.videocam),
                          title: const Text('Gallery (Video)'),
                          onTap: () {
                            allowsImages = false;
                            allowsVideos = true;
                            selectMedia(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.video_camera_back_rounded),
                          title: const Text('Camera (Video)'),
                          onTap: () {
                            allowsImages = false;
                            allowsVideos = true;
                            selectMedia(ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
          selectedMedia.isEmpty
              ? const Center(child: Text(''))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectedMedia.length,
                  itemBuilder: (context, index) {
                    return (selectedMedia[index]!.type == MediaType.image)
                        ? SizedBox(
                            height: 0.3.sh,
                            width: 0.8.sw,
                            child: Image.file(selectedMedia[index]!.file))
                        : Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: SizedBox(
                              height: 0.3.sh,
                              width: 0.8.sw,
                              child: VideoPlayerForSelectedViedeo(
                                videoUrl: selectedMedia[index]!.file.path,
                              ),
                            ),
                          );
                  },
                )
        ],
      ),
    );
  }

  Future selectMedia(ImageSource source) async {
    XFile? pickedFile;
    if (allowsImages && allowsVideos) {
      pickedFile = await picker.pickImage(source: source);
    } else if (allowsImages && !allowsVideos) {
      pickedFile = await picker.pickImage(source: source);
    } else {
      pickedFile = await picker.pickVideo(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10),
      );
    }
    if (pickedFile != null) {
      setState(() {
        selectedMedia.add(SelectedMedia(File(pickedFile!.path),
            allowsImages ? MediaType.image : MediaType.video));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selection cancelled')),
      );
    }
  }
}
