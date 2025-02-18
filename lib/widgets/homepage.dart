import 'package:cycles/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          height: 60,
          width: 200,
          cornerRadius: 12,
          buttonColor: Colors.blue,
          text: 'Click Me',
          onPressed: () {
            debugPrint('3D Button Pressed!');
          },
        ),
      ),
    );
  }
}