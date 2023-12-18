import 'widgets/userprofilelist_item_widget.dart';
import 'models/forum_diskusi_model.dart';
import 'models/userprofilelist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:forum/core/app_export.dart';
import 'package:forum/widgets/custom_floating_button.dart';
import 'provider/forum_diskusi_provider.dart';

class ForumDiskusiScreen extends StatefulWidget {
  const ForumDiskusiScreen({Key? key}) : super(key: key);

  @override
  ForumDiskusiScreenState createState() => ForumDiskusiScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ForumDiskusiProvider(),
        child: ForumDiskusiScreen());
  }
}

class ForumDiskusiScreenState extends State<ForumDiskusiScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      NavigatorService.popAndPushNamed(
        AppRoutes.forumDiskusiKomentarScreen,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  _buildForumDiskusiRow(context),
                  SizedBox(height: 25.v),
                  Text("lbl_posts".tr,
                      style: CustomTextStyles.titleLargeBlack900),
                  SizedBox(height: 29.v),
                  _buildUserProfileList(context)
                ])),
            floatingActionButton: _buildFloatingActionButton(context)));
  }

  /// Section Widget
  Widget _buildForumDiskusiRow(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 16.v),
        decoration: AppDecoration.fillBlueGray,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 59.v, bottom: 8.v),
                  child: Column(children: [
                    SizedBox(width: 21.h, child: Divider()),
                    SizedBox(height: 5.v),
                    SizedBox(width: 21.h, child: Divider()),
                    SizedBox(height: 6.v),
                    SizedBox(width: 21.h, child: Divider())
                  ])),
              Padding(
                  padding: EdgeInsets.only(top: 37.v),
                  child: Text("lbl_forum_diskusi".tr,
                      style: theme.textTheme.headlineLarge))
            ]));
  }

  /// Section Widget
  Widget _buildUserProfileList(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child: Consumer<ForumDiskusiProvider>(
                builder: (context, provider, child) {
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20.v);
                  },
                  itemCount: provider
                      .forumDiskusiModelObj.userprofilelistItemList.length,
                  itemBuilder: (context, index) {
                    UserprofilelistItemModel model = provider
                        .forumDiskusiModelObj.userprofilelistItemList[index];
                    return UserprofilelistItemWidget(model,
                        onTapImgUserImage: () {
                      onTapImgUserImage(context);
                    });
                  });
            })));
  }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
        height: 56,
        width: 56,
        backgroundColor: theme.colorScheme.primary,
        child: CustomImageView(
            imagePath: ImageConstant.imgGroup239,
            height: 28.0.v,
            width: 28.0.h));
  }

  /// Navigates to the forumDiskusiKomentarScreen when the action is triggered.
  onTapImgUserImage(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.forumDiskusiKomentarScreen);
  }
}
