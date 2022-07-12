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
  Widget build(BuildContext context) {
    var finalLeading = leading;
    if (leading == null && Navigator.canPop(context)) {
      finalLeading = IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } else {
      finalLeading = leading;
    }

    return AppBar(
      leading: finalLeading,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
