import 'package:flutter/material.dart';
import 'package:forum/core/app_export.dart';
import 'package:forum/presentation/forum_diskusi_komentar_screen/models/forum_diskusi_komentar_model.dart';

/// A provider class for the ForumDiskusiKomentarScreen.
///
/// This provider manages the state of the ForumDiskusiKomentarScreen, including the
/// current forumDiskusiKomentarModelObj

// ignore_for_file: must_be_immutable
class ForumDiskusiKomentarProvider extends ChangeNotifier {
  ForumDiskusiKomentarModel forumDiskusiKomentarModelObj =
      ForumDiskusiKomentarModel();

  @override
  void dispose() {
    super.dispose();
  }
}
