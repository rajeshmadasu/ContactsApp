import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddContactView extends StatefulWidget {
  const AddContactView({super.key});

  @override
  State<AddContactView> createState() => _AddContactViewState();
}

class _AddContactViewState extends State<AddContactView> {
  late XFile imageFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController name = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController landlineNumber = TextEditingController();
  dynamic _pickImageError;

  void _setImageFileListFromFile(XFile? value) {
    imageFile = (value)!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Align(
        alignment: const Alignment(0, -2 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                child: imageFile == null
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              color: Colors.greenAccent,
                              onPressed: () {
                                _onImageButtonPressed(ImageSource.gallery,
                                    context: context);
                              },
                              icon: Icon(Icons.add_a_photo),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 120,
                        width: 120,
                        child: Image.file(
                          File(imageFile.path),
                          fit: BoxFit.cover,
                        ),
                      )),
            const Padding(padding: EdgeInsets.all(12)),
            _NameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _MobileNumberInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LandlineNumberInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
          ],
        ),
      ),
    );
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    _displayPickImageDialog(context!,
        (double? maxWidth, double? maxHeight, int? quality) async {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        setState(() {
          _setImageFileListFromFile(pickedFile);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pick Image from Gallery/Camera'),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    const double width = 1800;
                    const double height = 1800;
                    const int quality = 1080;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

/// Get from gallery
_getFromGallery() async {
  PickedFile? pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {}
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (username) => {},
      //context.read<LoginBloc>().add(LoginUsernameChanged(username)),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
      ),
    );
  }
}

class _MobileNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (mobilenumber) => {},
      //context.read<LoginBloc>().add(LoginUsernameChanged(username)),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
      ),
    );
  }
}

class _LandlineNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (landlinenumber) => {},
      //context.read<LoginBloc>().add(LoginUsernameChanged(username)),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name',
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: null,
      child: const Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
