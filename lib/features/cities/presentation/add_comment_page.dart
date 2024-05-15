import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/core/presentation/button/app_bar_action_button.dart';
import 'package:travel_application/features/cities/presentation/add_comment_vm.dart';
import 'package:travel_application/features/cities/presentation/cities_detail_pade.dart';
import 'package:travel_application/features/cities/presentation/detail_page.dart';
import 'package:travel_application/routing.dart';

class AddCommentPage extends StatefulWidget {
  final AddCommentViewModel vm;

  const AddCommentPage({
    super.key,
    required this.vm,
  });

  @override
  State<AddCommentPage> createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage>
    with SingleTickerProviderStateMixin {
  Uint8List? _image;
  AddCommentViewModel get vm => widget.vm;
  void selectImage() async {
    Uint8List img = await widget.vm.pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).addComment,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          AppBarActionButton(
            onTap: () async {
              await vm.addCommentToDocument(
                ListName.listName,
                IdDocPlace.id,
                _image,
              );
              context.go(AppRouteList.detailPage);
            },
            child: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: vm.commentController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: S.of(context).writeComment,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => selectImage(),
                child: Text(S.of(context).selectImage),
              ),
              const SizedBox(height: 16),
              _image != null
                  ? Image.memory(
                      _image!,
                      height: 200,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
