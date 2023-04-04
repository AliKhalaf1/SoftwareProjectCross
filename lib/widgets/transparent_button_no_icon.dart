library TransparentNoIconButton;

import 'package:flutter/material.dart';
/// {@category Widgets}
///<b> TextButton() </b>
/// with certain styling used for:
///  
///   • Apply filters button

class TransparentButtonNoIcon extends StatelessWidget {
  final String text;
  final Function onPressed;
  /// It takes: 
  ///
  ///   • Text to display inside button
  /// 
  ///   • Function handler
  /// 
  const TransparentButtonNoIcon(this.text, this.onPressed,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 65,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
          child: TextButton(
            style: ButtonStyle(
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
            onPressed: () => onPressed(context),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
