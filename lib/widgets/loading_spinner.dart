library LoadingSpinner;

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// {@category Widgets}
///
/// stateless widget called LoadingSpinner that displays a loading animation with a text "Loading" below it.
///
/// The loading animation is a circular progress indicator provided by the LoadingAnimationWidget class.
/// 
class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.discreteCircle(
              secondRingColor: Colors.grey,
              thirdRingColor: Colors.grey,
              color: Colors.grey,
              size: 60),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const Text("Loading"),
        ],
      ),
    );
  }
}
