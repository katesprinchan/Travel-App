import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/core/presentation/app_bar.dart';
import 'package:travel_application/core/presentation/app_filled_button.dart';
import 'package:travel_application/core/presentation/app_text_field.dart';
import 'package:travel_application/core/presentation/button/app_bar_action_button.dart';
import 'package:travel_application/core/presentation/password_text_field.dart';
import 'package:travel_application/features/auth/presentation/auth_vm.dart';
import 'package:travel_application/routing.dart';

class AuthPage extends StatefulWidget {
  final AuthViewModel vm;

  const AuthPage({
    super.key,
    required this.vm,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  AuthViewModel get vm => widget.vm;
  String get imAgreedWith => S
      .of(context)
      .imAgreedWithPrivacyAndPolicyUsage
      .split(' ')
      .getRange(0, 3)
      .join(' ');

  String get PnPUsage {
    final wordList = S.of(context).imAgreedWithPrivacyAndPolicyUsage.split(' ');
    return wordList.getRange(3, wordList.length).join(' ');
  }

  @override
  void initState() {
    vm.init(tabController: TabController(length: 2, vsync: this));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AuthPage oldWidget) {
    if (oldWidget.vm != widget.vm) {
      vm.init(tabController: oldWidget.vm.tabController);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  Widget get _tabBarBuilder => TabBar(
        controller: vm.tabController,
        tabs: [
          Tab(
            text: S.of(context).login,
          ),
          Tab(
            text: S.of(context).registration,
          ),
        ],
        labelStyle: const TextStyle(
          fontSize: 14,
        ),
      );

  Widget get _tabViewBuilder => TabBarView(
        controller: vm.tabController,
        children: [
          _loginTabBuilder,
          _registerTabBuilder,
        ],
      );

  Widget get _loginTabBuilder => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 100),
            AppTextField(
              keyboardType: TextInputType.emailAddress,
              controller: vm.emailLoginTextCtrl,
              labelText: S.of(context).email,
              prefixIcon: const Icon(
                Icons.email_outlined,
              ),
            ),
            const SizedBox(height: 20),
            PasswordTextField(
              controller: vm.passwordLoginTextCtrl,
              labelText: S.of(context).password,
            ),
            const SizedBox(height: 20),
            vm.isLoginPossible.observer(
              (context, value) => AppFilledButton(
                onPressed: value ? () => vm.signIn(context) : null,
                child: Text(S.of(context).signIn),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                context.go(AppRouteList.forgotPassword);
              },
              child: Text(S.of(context).forgotPassword),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );

  Widget get _registerTabBuilder => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 100),
            AppTextField(
              keyboardType: TextInputType.name,
              controller: vm.nameRegisterTextCtrl,
              labelText: S.of(context).name,
              prefixIcon: const Icon(
                Icons.account_box_outlined,
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: vm.emailRegisterTextCtrl,
              labelText: S.of(context).email,
              prefixIcon: const Icon(
                Icons.email_outlined,
              ),
            ),
            const SizedBox(height: 20),
            PasswordTextField(
              controller: vm.passwordRegisterTextCtrl,
              labelText: S.of(context).password,
            ),
            const SizedBox(height: 20),
            PasswordTextField(
              controller: vm.repeatPasswordRegisterTextCtrl,
              labelText: S.of(context).repeatPassword,
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vm.isUserAgreedWithPnPUsage.observer(
                  (context, value) => Checkbox(
                    value: value,
                    onChanged: vm.onCheckBoxChecked,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: RichText(
                      maxLines: 2,
                      textHeightBehavior: const TextHeightBehavior(),
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$imAgreedWith ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextSpan(
                            text: PnPUsage,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            vm.isRegisterPossible.observer(
              (context, value) => AppFilledButton(
                onPressed: value ? () => vm.signUp(context) : null,
                child: Text(S.of(context).signUp),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: Text(S.of(context).authorization),
        context: context,
        actions: [
          AppBarActionButton(
            onTap: () => vm.onSettingsTap(context),
            child: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _tabBarBuilder,
          Expanded(child: _tabViewBuilder),
        ],
      ),
    );
  }
}
