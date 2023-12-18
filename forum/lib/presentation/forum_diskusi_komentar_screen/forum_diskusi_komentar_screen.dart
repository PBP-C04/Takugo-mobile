import 'models/forum_diskusi_komentar_model.dart';
import 'package:flutter/material.dart';
import 'package:forum/core/app_export.dart';
import 'package:forum/widgets/app_bar/appbar_title.dart';
import 'package:forum/widgets/app_bar/appbar_title_image.dart';
import 'package:forum/widgets/app_bar/custom_app_bar.dart';
import 'package:forum/widgets/custom_floating_button.dart';
import 'package:forum/widgets/custom_icon_button.dart';
import 'provider/forum_diskusi_komentar_provider.dart';

class ForumDiskusiKomentarScreen extends StatefulWidget {
  const ForumDiskusiKomentarScreen({Key? key}) : super(key: key);

  @override
  ForumDiskusiKomentarScreenState createState() =>
      ForumDiskusiKomentarScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ForumDiskusiKomentarProvider(),
        child: ForumDiskusiKomentarScreen());
  }
}

class ForumDiskusiKomentarScreenState
    extends State<ForumDiskusiKomentarScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: mediaQueryData.size.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 24.v),
                    child: Padding(
                        padding: EdgeInsets.only(left: 17.h, right: 24.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: Text("lbl_judul_post2".tr,
                                      style:
                                          CustomTextStyles.titleLargeBlack900)),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text("lbl_username".tr,
                                      style: theme.textTheme.bodySmall)),
                              SizedBox(height: 21.v),
                              _buildFrame(context),
                              SizedBox(height: 18.v),
                              Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: Text("lbl_replies".tr,
                                      style: theme.textTheme.labelLarge)),
                              SizedBox(height: 6.v),
                              Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: Text("lbl_username".tr,
                                      style: theme.textTheme.bodySmall)),
                              SizedBox(height: 8.v),
                              _buildFrame1(context),
                              SizedBox(height: 9.v),
                              Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: Text("lbl_username".tr,
                                      style: theme.textTheme.bodySmall)),
                              SizedBox(height: 8.v),
                              _buildFrame2(context),
                              SizedBox(height: 9.v),
                              Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: Text("lbl_username".tr,
                                      style: theme.textTheme.bodySmall)),
                              SizedBox(height: 8.v),
                              _buildStack(context),
                              SizedBox(height: 8.v),
                              _buildFrame3(context),
                              SizedBox(height: 9.v),
                              Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: Text("lbl_username".tr,
                                      style: theme.textTheme.bodySmall)),
                              SizedBox(height: 8.v),
                              _buildFrame4(context),
                              SizedBox(height: 10.v),
                              Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: Text("lbl_username".tr,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodySmall)),
                              SizedBox(height: 10.v),
                              _buildFrame5(context),
                              SizedBox(height: 10.v),
                              Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: Text("lbl_username".tr,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodySmall)),
                              Container(
                                  margin: EdgeInsets.only(right: 49.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.h, vertical: 9.v),
                                  decoration: AppDecoration.fillGray200
                                      .copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .customBorderBL15),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 4.v),
                                        SizedBox(
                                            width: 280.h,
                                            child: Text(
                                                "msg_diskusi_diskusi3".tr,
                                                maxLines: null,
                                                overflow: TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme.bodySmall!
                                                    .copyWith(height: 1.40)))
                                      ])),
                              SizedBox(height: 37.v),
                              _buildFrame6(context)
                            ])))),
            floatingActionButton: _buildFloatingActionButton(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        centerTitle: true,
        title: Column(children: [
          Row(children: [
            Padding(
                padding: EdgeInsets.only(top: 66.v, bottom: 11.v),
                child: Column(children: [
                  SizedBox(width: 21.h, child: Divider()),
                  SizedBox(height: 5.v),
                  SizedBox(width: 21.h, child: Divider()),
                  SizedBox(height: 6.v),
                  SizedBox(width: 21.h, child: Divider())
                ])),
            Padding(
                padding: EdgeInsets.only(left: 11.h),
                child: Column(children: [
                  SizedBox(
                      height: 37.v,
                      width: 302.h,
                      child: Stack(alignment: Alignment.center, children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                height: 37.v,
                                width: 126.h,
                                margin:
                                    EdgeInsets.only(left: 79.h, right: 97.h),
                                decoration: BoxDecoration(
                                    color: appTheme.black900,
                                    borderRadius:
                                        BorderRadius.circular(18.h)))),
                        AppbarTitleImage(
                            imagePath: ImageConstant.imgStatusBar,
                            margin: EdgeInsets.only(top: 11.v, bottom: 13.v))
                      ])),
                  SizedBox(height: 10.v),
                  AppbarTitle(
                      text: "lbl_forum_diskusi".tr,
                      margin: EdgeInsets.only(left: 37.h, right: 32.h))
                ]))
          ])
        ]),
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildFrame(BuildContext context) {
    return Container(
        width: 342.h,
        margin: EdgeInsets.only(left: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 19.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.v),
              Container(
                  width: 306.h,
                  margin: EdgeInsets.only(right: 9.h),
                  child: Text("msg_diskusi_diskusi2".tr,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall!.copyWith(height: 1.40)))
            ]));
  }

  /// Section Widget
  Widget _buildFrame1(BuildContext context) {
    return Container(
        width: 342.h,
        margin: EdgeInsets.only(left: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 10.v),
        decoration: AppDecoration.fillGray200
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.v),
              Container(
                  width: 292.h,
                  margin: EdgeInsets.only(right: 31.h),
                  child: Text("msg_comment_comment".tr,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall!.copyWith(height: 1.40)))
            ]));
  }

  /// Section Widget
  Widget _buildFrame2(BuildContext context) {
    return Container(
        width: 342.h,
        margin: EdgeInsets.only(left: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 10.v),
        decoration: AppDecoration.fillGray200
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.v),
              Container(
                  width: 292.h,
                  margin: EdgeInsets.only(right: 31.h),
                  child: Text("msg_comment_comment".tr,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall!.copyWith(height: 1.40)))
            ]));
  }

  /// Section Widget
  Widget _buildStack(BuildContext context) {
    return Container(
        height: 105.v,
        width: 342.h,
        margin: EdgeInsets.only(left: 10.h),
        child: Stack(alignment: Alignment.bottomLeft, children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 9.h, vertical: 10.v),
                  decoration: AppDecoration.fillGray200.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderBL15),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 7.v),
                        Container(
                            width: 292.h,
                            margin: EdgeInsets.only(right: 31.h),
                            child: Text("msg_comment_comment".tr,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall!
                                    .copyWith(height: 1.40)))
                      ]))),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text("lbl_username".tr, style: theme.textTheme.bodySmall)),
          Padding(
              padding: EdgeInsets.only(right: 3.h),
              child: CustomIconButton(
                  height: 56.adaptSize,
                  width: 56.adaptSize,
                  padding: EdgeInsets.all(13.h),
                  alignment: Alignment.bottomRight,
                  onTap: () {
                    onTapBtnArrowLeft(context);
                  },
                  child:
                      CustomImageView(imagePath: ImageConstant.imgArrowLeft)))
        ]));
  }

  /// Section Widget
  Widget _buildFrame3(BuildContext context) {
    return Container(
        width: 342.h,
        margin: EdgeInsets.only(left: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 10.v),
        decoration: AppDecoration.fillGray200
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.v),
              Container(
                  width: 292.h,
                  margin: EdgeInsets.only(right: 31.h),
                  child: Text("msg_comment_comment".tr,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall!.copyWith(height: 1.40)))
            ]));
  }

  /// Section Widget
  Widget _buildFrame4(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 10.v),
        decoration: AppDecoration.fillGray200
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL15),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: 9.v),
          SizedBox(
              width: 322.h,
              child: Text("msg_comment_comment".tr,
                  maxLines: null,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(height: 1.40)))
        ]));
  }

  /// Section Widget
  Widget _buildFrame5(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 10.v),
        decoration: AppDecoration.fillGray200
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL15),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: 9.v),
          SizedBox(
              width: 322.h,
              child: Text("msg_comment_comment".tr,
                  maxLines: null,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(height: 1.40)))
        ]));
  }

  /// Section Widget
  Widget _buildFrame6(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 10.v),
        decoration: AppDecoration.fillGray200
            .copyWith(borderRadius: BorderRadiusStyle.customBorderBL15),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: 9.v),
          SizedBox(
              width: 322.h,
              child: Text("msg_comment_comment".tr,
                  maxLines: null,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(height: 1.40)))
        ]));
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

  /// Navigates to the forumDiskusiScreen when the action is triggered.
  onTapBtnArrowLeft(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.forumDiskusiScreen,
    );
  }
}
