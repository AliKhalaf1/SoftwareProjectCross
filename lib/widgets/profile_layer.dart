import 'package:flutter/material.dart';

class ProfileLayer extends StatelessWidget {
  final String userName;
  final String email;

  const ProfileLayer(this.userName, this.email, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //we should navigate to edit page
        // ignore: avoid_print
        print("help");
      },
      child: Container(
        margin: const EdgeInsetsDirectional.only(top: 40),
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          children: [
            const SizedBox(
              height: 125,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      userName,
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          fontSize: 32,
                          height: 0.9,
                          fontFamily: 'Neue Plak Extended',
                          color: const Color.fromRGBO(40, 27, 67, 1)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      // ignore: prefer_const_constructors
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
