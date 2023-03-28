library TransparentButton;

import 'package:flutter/material.dart';
import '../widgets/google_icon.dart';

/// {@category Widgets}
///<b> TextButton() </b>
/// with certain styling used for:
///  
///   • Continue with facbook button
/// 
///   • Continue with google button
/// 
class TransparentButton extends StatelessWidget {
  final int id;
  final String text;
  final Function onPressed;
  final Icon icon;
  /// It takes: 
  ///
  ///   • Text to display inside button
  /// 
  ///   • Function handler
  /// 
  ///   • Icon to display
  const TransparentButton(this.id, this.text, this.onPressed, this.icon,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // padding: const EdgeInsets.only(top: 5),
      child: SizedBox(
        height: 65,
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
          // height: 80,
          child: TextButton(
            style: ButtonStyle(
              padding:
                  const MaterialStatePropertyAll(EdgeInsets.only(left: 35)),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(Colors.black87),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: const BorderSide(
                      color: Colors.black,
                    )),
              ),
            ),
            onPressed: () => onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                id == 0
                    ? icon
                    : const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: GoogleLogo(size: 16),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
