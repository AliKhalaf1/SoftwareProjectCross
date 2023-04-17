library AccountSettingsScreen;

import 'package:Eventbrite/helper_functions/upload_image.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper_functions/log_in.dart';
import '../../widgets/profile_picture.dart';
import 'dart:io';
import '../../models/db_mock.dart';

/// {@category user}
/// {@category Screens}
class AccountSettings extends StatefulWidget {
  var imageurl;
  AccountSettings({this.imageurl, super.key});

  static const accountSettingsRoute = '/Account-Settings';

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  ImagePicker picker = ImagePicker();
  XFile? image;
  String url = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const AppBarText('Account Settings'),
        elevation: 0,
      ),
      body: Column(
        children: [
          ProfilePicture(widget.imageurl, 'assets/images/camera.jfif'),
          TextLink(
            'Update Picture',
            1,
            () async {
              image = await picker.pickImage(source: ImageSource.gallery);

              url = await UploadImage.uploadImage(File(image!.path));
              setState(() {
                widget.imageurl = url;
              });
              String email = await getEmail();

              DBMock.updateUserImage(email, url);
            },
            key: const Key('update_Picture'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),

          //To be continued when edit user info api's is provided
        ],
      ),
    );
  }
}
