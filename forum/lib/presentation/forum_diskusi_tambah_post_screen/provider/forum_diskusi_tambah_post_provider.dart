import 'package:flutter/material.dart';
import 'package:forum/core/app_export.dart';
import 'package:forum/presentation/forum_diskusi_tambah_post_screen/models/forum_diskusi_tambah_post_model.dart';

/// A provider class for the ForumDiskusiTambahPostScreen.
///
/// This provider manages the state of the ForumDiskusiTambahPostScreen, including the
/// current forumDiskusiTambahPostModelObj

// ignore_for_file: must_be_immutable
class ForumDiskusiTambahPostProvider extends ChangeNotifier {
  TextEditingController enterinputvalueController = TextEditingController();

  TextEditingController enterinputvalueController1 = TextEditingController();

  ForumDiskusiTambahPostModel forumDiskusiTambahPostModelObj =
      ForumDiskusiTambahPostModel();

  @override
  void dispose() {
    super.dispose();
    enterinputvalueController.dispose();
    enterinputvalueController1.dispose();
  }
}
