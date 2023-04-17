import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'constants.dart';

class UploadImage {
  static Future<String> uploadImage(File imageFile) async {
    // open a bytestream
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("https://api.imgbb.com/1/upload");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart

    request.fields['key'] = Constants.imgUploadApiKey;

    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      var data = jsonDecode(res);
      return data['data']['url'];
    } else {
      return '';
    }
  }
}
