import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    required BuildContext context,
    final Widget? title,
    final List<Widget>? actions,
    final Widget? leading,
  }) : super(
          title: title,
          leadingWidth: leading != null
              ? null
              : context.canPop()
                  ? null
                  : 0,
          leading: leading ??
              (context.canPop()
                  ? IconButton(
                      onPressed: context.pop,
                      icon: const Icon(Icons.arrow_back_outlined))
                  : const SizedBox.shrink()),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
          actions: actions,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.outline,
          ),
        );
}
