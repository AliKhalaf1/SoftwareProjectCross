import 'package:flutter/material.dart';
import '../widgets/google_icon.dart';



class TransparentButton extends StatelessWidget {
  final int id;
  final String text;
  final Function onPressed;
  final Icon icon;
  const TransparentButton(this.id,this.text, this.onPressed, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 5),
      child: SizedBox(
        height: 66,
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 90,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(Colors.black87),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                  side: BorderSide( color: Colors.black,)
                  
                ),
              ),
            ),
            onPressed: () => onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                id == 0? icon: const GoogleLogo(size:20),
                Text(
                  text,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
