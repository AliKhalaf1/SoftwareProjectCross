import 'package:flutter/material.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

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
                  "See your favourites in one place",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 42, height: 0.9),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 10, top: 0),
                child: const Text(
                  "Log in to see your favourites",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 6),
                child: TextButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Explore events",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
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
    );
  }
}
