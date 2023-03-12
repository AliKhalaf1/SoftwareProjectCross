import 'package:flutter/material.dart';

class Tickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/images.jfif"), fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 5, top: 0),
                child: const Text(
                  "Looking for your mobile tickets?",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 42, height: 0.9),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 10, top: 0),
                child: const Text(
                  "Log into the same account you used to buy your tickets.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 15, top: 0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 207, 62, 18)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 15, top: 0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 207, 62, 18)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
