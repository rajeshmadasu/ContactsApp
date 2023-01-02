import 'dart:io';

import '../../models/contact.dart';
import '../add_contact_widget/bloc/add_edit_contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddContactView extends StatefulWidget {
  const AddContactView({super.key});

  @override
  State<AddContactView> createState() => _AddContactViewState();
}

class _AddContactViewState extends State<AddContactView> {
  XFile? imageFile = null;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController name = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController landlineNumber = TextEditingController();
  dynamic _pickImageError;

  void _setImageFileListFromFile(XFile? value) {
    imageFile = (value)!;
  }

  void _onSubmitSave() {
    //int id = (const Uuid().v4().toString()) as int;
    context.read<AddEditContactBloc>().add(SaveContact(Contact(
        id: 0,
        name: name.text.toString(),
        mobileNumber: mobileNumber.text.toString(),
        landlineNumber: landlineNumber.text.toString(),
        image: imageFile!.path.toString(),
        favourite: 0)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddEditContactBloc, AddEditContactState>(
        listener: (context, state) {
          if (state.status.isError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Failed to add contact')),
              );
          } else if (state.status.isSuccess) {
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
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
                                Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(8),
                                  child: IconButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      _onImageButtonPressed(ImageSource.camera,
                                          context: context);
                                    },
                                    icon: const Icon(Icons.add_a_photo),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 120,
                            width: 120,
                            child: Image.file(
                              File(imageFile!.path),
                              fit: BoxFit.cover,
                            ),
                          )),
                const Padding(padding: EdgeInsets.all(8)),
                _NameInput(name),
                const Padding(padding: EdgeInsets.all(8)),
                _MobileNumberInput(mobileNumber),
                const Padding(padding: EdgeInsets.all(8)),
                _LandlineNumberInput(landlineNumber),
                const Padding(padding: EdgeInsets.all(8)),
                Container(
                  child: _SaveButton(voidCallback: _onSubmitSave),
                ),
              ],
            ),
          ),
        ));
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
            title: const Text('Pick Image from Camera'),
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
                    const int quality = 100;
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
  TextEditingController nameEditingParameter;

  _NameInput(this.nameEditingParameter);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameEditingParameter,
      decoration: InputDecoration(
        labelText: 'Name',
      ),
    );
  }
}

class _MobileNumberInput extends StatelessWidget {
  TextEditingController mobileNoEditingParameter;
  _MobileNumberInput(this.mobileNoEditingParameter);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: mobileNoEditingParameter,
      //context.read<LoginBloc>().add(LoginUsernameChanged(username)),
      decoration: InputDecoration(
        labelText: 'Mobile Number',
      ),
    );
  }
}

class _LandlineNumberInput extends StatelessWidget {
  TextEditingController landlineEditingParameter;
  _LandlineNumberInput(this.landlineEditingParameter);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: landlineEditingParameter,
      decoration: InputDecoration(
        labelText: 'Landline Number',
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback voidCallback;

  _SaveButton({required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditContactBloc, AddEditContactState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: voidCallback,
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              );
      },
    );
  }
}
