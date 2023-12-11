import '../models/userprofilelist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:forum/core/app_export.dart';

// ignore: must_be_immutable
class UserprofilelistItemWidget extends StatelessWidget {
  UserprofilelistItemWidget(
    this.userprofilelistItemModelObj, {
    Key? key,
    this.onTapImgUserImage,
  }) : super(
          key: key,
        );

  UserprofilelistItemModel userprofilelistItemModelObj;

  VoidCallback? onTapImgUserImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.fillGray200.copyWith(
        borderRadius: BorderRadiusStyle.customBorderBL15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userprofilelistItemModelObj.username!,
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: 3.v),
          Text(
            userprofilelistItemModelObj.judulPost!,
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: 2.v),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 2.v),
                child: Text(
                  userprofilelistItemModelObj.diskusiDiskusi!,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgAntDesignCommentOutlined,
                height: 17.adaptSize,
                width: 17.adaptSize,
                margin: EdgeInsets.only(left: 61.h),
                onTap: () {
                  onTapImgUserImage!.call();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
