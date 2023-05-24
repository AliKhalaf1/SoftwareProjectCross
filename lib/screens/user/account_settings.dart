library AccountSettingsScreen;

import 'package:Eventbrite/helper_functions/upload_image.dart';
import 'package:Eventbrite/main.dart';
import 'package:Eventbrite/screens/user/update_name.dart';
import 'package:Eventbrite/screens/user/update_password.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper_functions/constants.dart';
import '../../helper_functions/log_in.dart';
import '../../models/user.dart';
import '../../objectbox.dart';
import '../../objectbox.g.dart';
import '../../widgets/profile_picture.dart';
import 'dart:io';
import '../../models/db_mock.dart';
import 'package:http/http.dart' as http;

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
  final String email;
  var firstname;
  var lastname;
  AccountSettings(this.email, this.firstname, this.lastname, this.imageurl,
      {super.key});

  static const accountSettingsRoute = '/Account-Settings';

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

void updateName(BuildContext ctx, String firstname, String lastname) {
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return UpdateNamePage(firstname, lastname);
  }));
}

void updatePassword(BuildContext ctx) {
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return UpdatePassPage();
  }));
}

class _AccountSettingsState extends State<AccountSettings> {
  ImagePicker picker = ImagePicker();
  XFile? image;
  String url = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).orientation == Orientation.landscape
          ? null
          : AppBar(
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

              // DBMock.updateUserImage(widget.email, url);
///////////////////////////////////////////////////////////////////////////////////////////////////////////
              //mock server implementation
              int responseCode = 200;
              if (Constants.MockServer == true) {
                var userbox = ObjectBox.userBox;
                var user = userbox
                    .query(User_.email.equals(widget.email))
                    .build()
                    .findFirst();
                user!.imageUrl = url;
                userbox.put(user);
                Navigator.of(context).pop(true);
                responseCode = 200;
              } else {
///////////////////////////////////////////////////////////////////////////////////////////////////////////
                //api implementation
                String token = await getToken();
                var uri = Uri.parse(
                    '${Constants.host}/users/me/edit?avatar_url=$url');

                //create multipart request
                Map<String, String> reqHeaders = {
                  'Authorization': 'Bearer ${token}',
                };
                var response = await http.put(
                  uri,
                  headers: reqHeaders,
                );
                int responseCode = response.statusCode;

                Navigator.of(context).pop(true);
///////////////////////////////////////////////////////////////////////////////////////////////////////////
              }
              print(responseCode);
              if (responseCode != 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error updating profile picture'),
                  ),
                );
              }
            },
            key: const Key('update_Picture'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),

          AccSettingsOption(
            'Name',
            '${widget.firstname} ${widget.lastname}',
            () => updateName(context, widget.firstname, widget.lastname),
            key: const Key('name_acc_settings'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * 0.05
                : MediaQuery.of(context).size.height * 0.1,
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        overflow: TextOverflow.fade,
                        widget.email,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),

          AccSettingsOption(
            'Password',
            'Update Password',
            () => updatePassword(context),
            key: const Key('pass_acc_settings'),
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
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height * 0.05
            : MediaQuery.of(context).size.height * 0.1,
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
