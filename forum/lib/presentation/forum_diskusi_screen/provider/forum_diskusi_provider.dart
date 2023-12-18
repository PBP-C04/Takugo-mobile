import 'package:flutter/material.dart';
import 'package:forum/core/app_export.dart';
import 'package:forum/presentation/forum_diskusi_screen/models/forum_diskusi_model.dart';
import '../models/userprofilelist_item_model.dart';

/// A provider class for the ForumDiskusiScreen.
///
/// This provider manages the state of the ForumDiskusiScreen, including the
/// current forumDiskusiModelObj

// ignore_for_file: must_be_immutable
class ForumDiskusiProvider extends ChangeNotifier {
  ForumDiskusiModel forumDiskusiModelObj = ForumDiskusiModel();

  @override
  void dispose() {
    super.dispose();
  }
}
