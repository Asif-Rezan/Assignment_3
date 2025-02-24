import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final double size;

  const LoadingWidget({super.key, this.size = 50});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: const CircularProgressIndicator(color: Colors.blue,),
    );
  }
}