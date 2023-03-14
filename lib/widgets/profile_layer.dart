import 'package:flutter/material.dart';

class ProfileLayer extends StatelessWidget {
  final String userName;
  final String email;

  const ProfileLayer(this.userName, this.email, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                      style: const TextStyle(
                          fontSize: 32,
                          height: 0.9,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Neue Plak Extended',
                          color: Color.fromRGBO(40, 27, 67, 1)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: Color.fromRGBO(66, 94, 203, 1),
                      ),
                    ),
                  ],
                ),
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
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
