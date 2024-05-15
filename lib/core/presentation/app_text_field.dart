import 'package:flutter/material.dart';
import 'package:reactive_variables/reactive_variables.dart';
import 'package:travel_application/core/presentation/app_text_field/app_text_editing_controller.dart';

class AppTextField extends StatelessWidget {
  final String labelText;
  final AppTextEditingController controller;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool obscureText;

  const AppTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obs(
        rvList: [controller.errorText],
        builder: (context) {
          return TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              floatingLabelStyle:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              prefixIconColor: Theme.of(context).colorScheme.outline,
              suffixIconColor: Theme.of(context).colorScheme.outline,
              errorText: controller.errorText(),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          );
        });
  }
}

class AppNumberTextField extends StatelessWidget {
  final AppTextEditingController controller;

  const AppNumberTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obs(
        rvList: [controller.errorText],
        builder: (context) {
          return TextField(
            controller: controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              floatingLabelStyle:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
              errorText: controller.errorText(),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          );
        });
  }
}
