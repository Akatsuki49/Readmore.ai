import 'package:flutter/material.dart';

class GoogleIconButton extends StatefulWidget {
  final String labelText;
  final String imagePath;
  final VoidCallback onPress;

  const GoogleIconButton({
    super.key,
    required this.labelText,
    required this.imagePath,
    required this.onPress,
  });

  @override
  State<GoogleIconButton> createState() => _GoogleIconButtonState();
}

class _GoogleIconButtonState extends State<GoogleIconButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.8,
      height: 60,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.grey.shade200),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          side: MaterialStateProperty.all(
            const BorderSide(color: Colors.black),
          ),
        ),
        onPressed: widget.onPress,
        icon: Image.asset(
          widget.imagePath,
          width: 30, // Adjust the width as needed
          height: 30, // Adjust the height as needed
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
