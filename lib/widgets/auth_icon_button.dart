import 'package:flutter/material.dart';

class AuthIconButton extends StatefulWidget {
  final String labelText;
  final dynamic icon;
  final bool isSvg;
  final VoidCallback onPress;

  const AuthIconButton({
    super.key,
    required this.labelText,
    required this.isSvg,
    required this.icon,
    required this.onPress,
  });

  @override
  State<AuthIconButton> createState() => _AuthIconButtonState();
}

class _AuthIconButtonState extends State<AuthIconButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.8,
      height: 60,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
          backgroundColor: MaterialStatePropertyAll(Colors.grey.shade200),
          shadowColor: const MaterialStatePropertyAll(Colors.transparent),
          side: const MaterialStatePropertyAll(
            BorderSide(color: Colors.black),
          ),
        ),
        onPressed: widget.onPress,
        icon: widget.isSvg
            ? widget.icon
            : Icon(
                widget.icon,
                color: Colors.black,
                size: 30,
              ),
        label: Padding(
          padding: const EdgeInsets.only(left: 7.0),
          child: Text(
            widget.labelText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
