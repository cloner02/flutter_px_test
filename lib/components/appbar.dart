import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Widget? previousScreen;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.previousScreen,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        leading: showBackButton? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            if (previousScreen != null) {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => previousScreen!),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ) : null,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
