import '../../../core/app_export.dart';

/// This class is used in the [userprofilelist_item_widget] screen.
class UserprofilelistItemModel {
  UserprofilelistItemModel({
    this.username,
    this.judulPost,
    this.diskusiDiskusi,
    this.id,
  }) {
    username = username ?? "username";
    judulPost = judulPost ?? "judul post";
    diskusiDiskusi = diskusiDiskusi ??
        "diskusi diskusi diskusi diskusi diskusi diskusi disku...";
    id = id ?? "";
  }

  String? username;

  String? judulPost;

  String? diskusiDiskusi;

  String? id;
}
