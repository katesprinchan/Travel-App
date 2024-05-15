import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/core/presentation/app_bar.dart';
import 'package:travel_application/core/presentation/app_filled_button.dart';
import 'package:travel_application/core/presentation/app_text_field.dart';
import 'package:travel_application/core/presentation/button/app_bar_action_button.dart';
import 'package:travel_application/features/recovery/presentation/recovery_vm.dart';
import 'package:travel_application/routing.dart';
import 'package:travel_application/theme/colors_collection.dart';

class ForgotPasswordPage extends StatefulWidget {
  final RecoveryViewModel vm;
  const ForgotPasswordPage({
    super.key,
    required this.vm,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  RecoveryViewModel get vm => widget.vm;
  @override
  void initState() {
    vm.init();
    super.initState();
  }

  Widget get _inscription => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          S.of(context).enterEmailToWhichPasswordResetCodeWillBeSent,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorsCollection.onSurfaceVariant,
              ),
        ),
      );
  Widget get _emailTextField => AppTextField(
        controller: vm.emailLoginTextCtrl,
        labelText: S.of(context).email,
        prefixIcon: const Icon(
          Icons.email_outlined,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(S.of(context).recoveryPassword),
        context: context,
        actions: [
          AppBarActionButton(
            onTap: () => vm.onSettingsTap(context),
            child: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 100),
            _inscription,
            const SizedBox(height: 20),
            _emailTextField,
            const SizedBox(height: 20),
            vm.isLoginPossible.observer(
              (context, value) => AppFilledButton(
                onPressed: value
                    ? () {
                        vm.sendVerificationCode();
                        context.go(AppRouteList.passwordResetPage);
                      }
                    : null,
                child: Text(S.of(context).send),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
