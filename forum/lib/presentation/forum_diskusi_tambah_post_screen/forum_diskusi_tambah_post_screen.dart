import 'models/forum_diskusi_tambah_post_model.dart';
import 'package:flutter/material.dart';
import 'package:forum/core/app_export.dart';
import 'package:forum/widgets/custom_elevated_button.dart';
import 'package:forum/widgets/custom_text_form_field.dart';
import 'provider/forum_diskusi_tambah_post_provider.dart';

class ForumDiskusiTambahPostScreen extends StatefulWidget {
  const ForumDiskusiTambahPostScreen({Key? key}) : super(key: key);

  @override
  ForumDiskusiTambahPostScreenState createState() =>
      ForumDiskusiTambahPostScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ForumDiskusiTambahPostProvider(),
        child: ForumDiskusiTambahPostScreen());
  }
}

class ForumDiskusiTambahPostScreenState
    extends State<ForumDiskusiTambahPostScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  _buildForumDiskusiTambah(context),
                  SizedBox(height: 32.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 40.h),
                          child: Text("lbl_judul_post3".tr,
                              style: theme.textTheme.titleLarge))),
                  SizedBox(height: 13.v),
                  Padding(
                      padding: EdgeInsets.only(left: 40.h, right: 44.h),
                      child: Selector<ForumDiskusiTambahPostProvider,
                              TextEditingController?>(
                          selector: (context, provider) =>
                              provider.enterinputvalueController,
                          builder: (context, enterinputvalueController, child) {
                            return CustomTextFormField(
                                controller: enterinputvalueController,
                                hintText: "lbl_enter_input".tr);
                          })),
                  SizedBox(height: 17.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 40.h),
                          child: Text("lbl_content".tr,
                              style: theme.textTheme.titleLarge))),
                  SizedBox(height: 14.v),
                  Padding(
                      padding: EdgeInsets.only(left: 40.h, right: 44.h),
                      child: Selector<ForumDiskusiTambahPostProvider,
                              TextEditingController?>(
                          selector: (context, provider) =>
                              provider.enterinputvalueController1,
                          builder:
                              (context, enterinputvalueController1, child) {
                            return CustomTextFormField(
                                controller: enterinputvalueController1,
                                hintText: "lbl_enter_input".tr,
                                textInputAction: TextInputAction.done,
                                maxLines: 18);
                          })),
                  SizedBox(height: 88.v),
                  CustomElevatedButton(
                      text: "lbl_add_post".tr,
                      margin: EdgeInsets.only(left: 50.h, right: 34.h),
                      onPressed: () {
                        onTapAddPost(context);
                      }),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  Widget _buildForumDiskusiTambah(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 13.v),
        decoration: AppDecoration.fillBlueGray,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 62.v, bottom: 11.v),
                  child: Column(children: [
                    SizedBox(width: 21.h, child: Divider()),
                    SizedBox(height: 5.v),
                    SizedBox(width: 21.h, child: Divider()),
                    SizedBox(height: 6.v),
                    SizedBox(width: 21.h, child: Divider())
                  ])),
              Padding(
                  padding: EdgeInsets.only(top: 43.v, right: 34.h),
                  child: Text("lbl_forum_diskusi".tr,
                      style: theme.textTheme.headlineLarge))
            ]));
  }

  /// Navigates to the forumDiskusiScreen when the action is triggered.
  onTapAddPost(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.forumDiskusiScreen,
    );
  }
}
