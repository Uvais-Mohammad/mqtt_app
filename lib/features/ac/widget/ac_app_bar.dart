import 'package:flutter/material.dart';

class AcAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AcAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 75,
      elevation: 0,
      title: const Text(
        'Smart AC',
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(78);
}
