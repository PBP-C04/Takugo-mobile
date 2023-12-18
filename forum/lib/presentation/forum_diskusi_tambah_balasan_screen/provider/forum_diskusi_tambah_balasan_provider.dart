import 'package:flutter/material.dart';
import 'package:forum/core/app_export.dart';
import 'package:forum/presentation/forum_diskusi_tambah_balasan_screen/models/forum_diskusi_tambah_balasan_model.dart';

/// A provider class for the ForumDiskusiTambahBalasanScreen.
///
/// This provider manages the state of the ForumDiskusiTambahBalasanScreen, including the
/// current forumDiskusiTambahBalasanModelObj

// ignore_for_file: must_be_immutable
class ForumDiskusiTambahBalasanProvider extends ChangeNotifier {
  TextEditingController inputPlaceholderController = TextEditingController();

  ForumDiskusiTambahBalasanModel forumDiskusiTambahBalasanModelObj =
      ForumDiskusiTambahBalasanModel();

  @override
  void dispose() {
    super.dispose();
    inputPlaceholderController.dispose();
  }
}
