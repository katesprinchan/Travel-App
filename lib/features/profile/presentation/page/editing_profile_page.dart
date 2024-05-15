import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/core/presentation/button/app_bar_action_button.dart';
import 'package:travel_application/features/profile/presentation/page/profile_vm.dart';
import 'package:travel_application/routing.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileViewModel vm;
  const EditProfilePage({super.key, required this.vm});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  Uint8List? _image;
  ProfileViewModel get vm => widget.vm;
  void selectImage() async {
    Uint8List img = await widget.vm.pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Widget _imageBuilder(BuildContext context) => Stack(
        alignment: Alignment.bottomRight,
        children: [
          if (_image != null)
            CircleAvatar(
              radius: 50,
              backgroundImage: MemoryImage(_image!),
            )
          else
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.background,
              child: Icon(Icons.account_box_rounded,
                  size: 90, color: Theme.of(context).colorScheme.primary),
            ),
          Positioned(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () {
                  selectImage();
                },
              ),
            ),
          ),
        ],
      );

  Widget _contentBuilder(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(top: 8, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: vm.nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                label: Text(S.of(context).name),
                labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                hintText: S.of(context).enterNewName,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: vm.emailController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                label: const Text('E-mail'),
                labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                hintText: S.of(context).enterNewEmail,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: vm.passwordController,
              decoration: InputDecoration(
                label: Text(S.of(context).password),
                labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                hintText: S.of(context).enterNewPassword,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).editingProfile,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          AppBarActionButton(
            onTap: () {
              widget.vm.onSaveProfile(_image);
              context.go(AppRouteList.profilePage);
            },
            child: const Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _imageBuilder(context),
          const SizedBox(height: 16),
          _contentBuilder(context)
        ],
      ),
    );
  }
}
