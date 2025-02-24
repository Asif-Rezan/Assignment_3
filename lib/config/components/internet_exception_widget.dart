import 'package:flutter/material.dart';

class InternetExceptionWidget extends StatelessWidget {
  const InternetExceptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('No internet connection'),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}