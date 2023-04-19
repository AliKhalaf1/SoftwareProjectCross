library AccountSettingsScreen;

import 'package:Eventbrite/helper_functions/upload_image.dart';
import 'package:Eventbrite/screens/user/update_name.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper_functions/log_in.dart';
import '../../models/user.dart';
import '../../widgets/profile_picture.dart';
import 'dart:io';
import '../../models/db_mock.dart';

/// {@category user}
/// {@category Screens}
///
/// This Page is used to display the user's account settings.
///
/// It contains the following Data:
///
/// * User's Profile Picture
///
/// * User's First Name
///
/// * User's Last Name
///
/// * User's Email
///
class AccountSettings extends StatefulWidget {
  var imageurl;
  String email = '';
  String firstname = '';
  String lastname = '';
  AccountSettings({this.imageurl, super.key});

  static const accountSettingsRoute = '/Account-Settings';

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

void UpdateName(BuildContext ctx, String firstname, String lastname) {
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return UpdateNamePage(firstname, lastname);
  }));
}

class _AccountSettingsState extends State<AccountSettings> {
  ImagePicker picker = ImagePicker();
  XFile? image;
  String url = '';

  @override
  void initState() {
    super.initState();
    getEmail().then((value) {
      setState(() {
        User user = DBMock.getUserData(value);
        widget.email = value;
        widget.firstname = user.firstName;
        widget.lastname = user.lastName;
      });
    });
  }

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
              DBMock.updateUserImage(widget.email, url);
            },
            key: const Key('update_Picture'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),

          AccSettingsOption(
            'Name',
            '${widget.firstname} ${widget.lastname}',
            () => UpdateName(context, widget.firstname, widget.lastname),
            key: const Key('name_acc_settings'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Text('${widget.firstname} ${widget.lastname}'),
                    Text(
                      widget.email,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //To be continued when edit user info api's is provided
        ],
      ),
    );
  }
}

class AccSettingsOption extends StatelessWidget {
  String title;
  String value;
  Function onPressed;
  AccSettingsOption(this.title, this.value, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      focusColor: Colors.grey,
      hoverColor: Colors.grey,
      splashColor: Colors.grey,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Text('${widget.firstname} ${widget.lastname}'),
                Container(
                  width: MediaQuery.of(context).size.width * 0.56,
                  child: TextLink(
                    value,
                    2,
                    onPressed,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 13,
                  color: Colors.grey[600],
                  weight: 4000,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
