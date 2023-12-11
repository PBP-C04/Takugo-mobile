import 'models/forum_diskusi_tambah_balasan_model.dart';
import 'package:flutter/material.dart';
import 'package:forum/core/app_export.dart';
import 'package:forum/widgets/custom_elevated_button.dart';
import 'package:forum/widgets/custom_text_form_field.dart';
import 'provider/forum_diskusi_tambah_balasan_provider.dart';

class ForumDiskusiTambahBalasanScreen extends StatefulWidget {
  const ForumDiskusiTambahBalasanScreen({Key? key}) : super(key: key);

  @override
  ForumDiskusiTambahBalasanScreenState createState() =>
      ForumDiskusiTambahBalasanScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ForumDiskusiTambahBalasanProvider(),
        child: ForumDiskusiTambahBalasanScreen());
  }
}

class ForumDiskusiTambahBalasanScreenState
    extends State<ForumDiskusiTambahBalasanScreen> {
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
                  SizedBox(height: 31.v),
                  Text("lbl_judul_post2".tr,
                      style: CustomTextStyles.titleLargeBlack900),
                  Text("lbl_username".tr, style: theme.textTheme.bodySmall),
                  SizedBox(height: 30.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 42.h),
                          child: Text("lbl_balasan".tr,
                              style: theme.textTheme.titleLarge))),
                  SizedBox(height: 17.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 42.h),
                      child: Selector<ForumDiskusiTambahBalasanProvider,
                              TextEditingController?>(
                          selector: (context, provider) =>
                              provider.inputPlaceholderController,
                          builder:
                              (context, inputPlaceholderController, child) {
                            return CustomTextFormField(
                                controller: inputPlaceholderController,
                                hintText: "lbl_enter_input".tr,
                                textInputAction: TextInputAction.done,
                                maxLines: 18);
                          })),
                  Spacer(),
                  SizedBox(height: 89.v),
                  CustomElevatedButton(
                      text: "lbl_add_reply".tr,
                      margin: EdgeInsets.only(left: 50.h, right: 34.h),
                      onPressed: () {
                        onTapAddReply(context);
                      })
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

  /// Navigates to the forumDiskusiKomentarScreen when the action is triggered.
  onTapAddReply(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.forumDiskusiKomentarScreen,
    );
  }
}
