library TransparentNoIconButton;

import 'package:flutter/material.dart';

import '../models/tags.dart';

/// {@category Widgets}
///<b> TextButton() </b>
/// with certain styling used for:
///
///   • Apply filters button

class TransparentButtonNoIcon extends StatefulWidget {
  final String text;
  final Function onPressed;
  bool buttonState;

  /// It takes:
  ///
  ///   • Text to display inside button
  ///
  ///   • Function handler
  /// 
  ///   • Button state (Activate or not)
  ///
  TransparentButtonNoIcon(this.text, this.onPressed, this.buttonState,
      {super.key});

  @override
  State<TransparentButtonNoIcon> createState() =>
      _TransparentButtonNoIconState();
}

class _TransparentButtonNoIconState extends State<TransparentButtonNoIcon> {
  /* Method to check disable or enable the button */
  void buttonState() {
    setState(() {
      widget.buttonState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.9,
        child: !widget.buttonState
            ? TextButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(
                        width: 2, color: Color.fromARGB(255, 238, 238, 238)),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 184, 184, 184)),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                onPressed: null,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            : TextButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(width: 2, color: Colors.grey),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.black87),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                onPressed: () => widget.onPressed(context),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
      ),
    );
  }
}
