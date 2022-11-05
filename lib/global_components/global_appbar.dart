import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GlobalAppBar extends HookConsumerWidget with PreferredSizeWidget {
  GlobalAppBar({Key? key, required this.title, this.actionWidget})
      : super(key: key);

  final String title;
  final Widget? actionWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter.of(context);
    return AppBar(
      centerTitle: true,
      title: actionWidget ?? Text(title),
      leading: (router.location == '/')
          ? null
          : IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_outlined)),
      actions: (router.location == '/settings')
          ? null
          : [
              IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => context.push('/settings'))
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
