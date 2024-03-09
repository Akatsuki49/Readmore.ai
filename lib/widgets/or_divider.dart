import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'OR',
              style: TextStyle(
                color: Color(0xff9EAFB0),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
