import 'package:flutter/material.dart';

class NextTestAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NextTestAppBar({
    Key? key,
    this.leading,
    this.title,
    this.actions,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final height = kToolbarHeight;

  @override
  Widget build(BuildContext context) => AppBar(
        leading: leading == null && Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : leading,
        title: title,
        actions: actions,
      );

  @override
  Size get preferredSize => Size.fromHeight(height);
}
