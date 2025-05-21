import 'package:flutter/material.dart';

class LoginRegisterAppBar extends StatelessWidget {
  const LoginRegisterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white

            ),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Color(0xFF3C7A3C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
