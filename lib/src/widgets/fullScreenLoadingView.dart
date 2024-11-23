import 'package:flutter/material.dart';

class FullScreenLoadingView extends StatefulWidget {
  @override
  _FullScreenLoadingDemoState createState() => _FullScreenLoadingDemoState();
}

class _FullScreenLoadingDemoState extends State<FullScreenLoadingView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [ // Background mờ
            ModalBarrier(
              dismissible: false,
              color: Colors.black26,
            ),
            // Circular Progress Indicator
            Center(
              child: CircularProgressIndicator(color: Colors.blueAccent,),
            ),
        ],
    );
  }
}
