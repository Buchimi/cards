import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  const TextBox({super.key, this.initText, required this.onChange});
  final void Function(String val) onChange;
  final String? initText;
  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initText);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
    );
  }
}
