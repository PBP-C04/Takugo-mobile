import 'package:flutter/material.dart';
import 'package:forum/presentation/forum_diskusi_screen/forum_diskusi_screen.dart';
import 'package:forum/presentation/forum_diskusi_komentar_screen/forum_diskusi_komentar_screen.dart';
import 'package:forum/presentation/forum_diskusi_tambah_post_screen/forum_diskusi_tambah_post_screen.dart';
import 'package:forum/presentation/forum_diskusi_tambah_balasan_screen/forum_diskusi_tambah_balasan_screen.dart';
import 'package:forum/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String forumDiskusiScreen = '/forum_diskusi_screen';

  static const String forumDiskusiKomentarScreen =
      '/forum_diskusi_komentar_screen';

  static const String forumDiskusiTambahPostScreen =
      '/forum_diskusi_tambah_post_screen';

  static const String forumDiskusiTambahBalasanScreen =
      '/forum_diskusi_tambah_balasan_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        forumDiskusiScreen: ForumDiskusiScreen.builder,
        forumDiskusiKomentarScreen: ForumDiskusiKomentarScreen.builder,
        forumDiskusiTambahPostScreen: ForumDiskusiTambahPostScreen.builder,
        forumDiskusiTambahBalasanScreen:
            ForumDiskusiTambahBalasanScreen.builder,
        appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: ForumDiskusiScreen.builder
      };
}
