// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import '../../models/contact.dart';
import '../add_contact_widget/bloc/add_edit_contact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddContactView extends StatefulWidget {
  final Contact? contact;
  bool isFavEnabled = false;

  AddContactView(this.contact, this.isFavEnabled, {super.key});

  @override
  State<AddContactView> createState() => _AddContactViewState();
}

class _AddContactViewState extends State<AddContactView> {
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController name = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController landlineNumber = TextEditingController();

  void _setImageFileListFromFile(XFile? value) {
    imageFile = (value)!;
  }

  bool editContact = false;
  int favourite = 0;
  int contactId = 0;
  void _onSubmitSave() {
    if (name.text.isNotEmpty &&
        mobileNumber.text.isNotEmpty &&
        landlineNumber.text.isNotEmpty) {
      context.read<AddEditContactBloc>().add(editContact
          ? UpdateContact(Contact(
              id: contactId,
              name: name.text.toString(),
              mobileNumber: mobileNumber.text.toString(),
              landlineNumber: landlineNumber.text.toString(),
              image: imageFile!.path.toString(),
              favourite: favourite))
          : SaveContact(Contact(
              id: 0, // this is ignored while mapping to database model
              name: name.text.toString(),
              mobileNumber: mobileNumber.text.toString(),
              landlineNumber: landlineNumber.text.toString(),
              image: imageFile != null ? imageFile!.path.toString() : "",
              favourite: favourite)));
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      Contact? contact = widget.contact;
      name.text = contact!.name.toString();
      mobileNumber.text = contact.mobileNumber.toString();
      landlineNumber.text = contact.landlineNumber.toString();
      setState(() {
        favourite = contact.favourite;
        _setImageFileListFromFile(XFile(contact.image.toString()));
        editContact = true;
        contactId = contact.id;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    mobileNumber.dispose();
    landlineNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    favourite = widget.isFavEnabled ? 1 : 0;

    return BlocListener<AddEditContactBloc, AddEditContactState>(
        listener: (context, state) {
          if (state.status.isError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Failed to add contact')),
              );
          } else if (state.status.isSuccess) {
            Navigator.pop(context, true);
          }
        },
        child: Column(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: const Alignment(0, -2 / 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _onImageButtonPressed(ImageSource.camera,
                            context: context);
                      },
                      child: Container(
                          child: imageFile == null
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.all(8),
                                        child: GestureDetector(
                                          // Image tapped
                                          child: Image.asset(
                                            'assets/images/add_image.png',
                                            fit: BoxFit
                                                .cover, // Fixes border issues
                                            width: 110.0,
                                            height: 110.0,
                                          ),
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
                    ),
                    const Padding(padding: EdgeInsets.all(8)),
                    _NameInput(name),
                    const Padding(padding: EdgeInsets.all(8)),
                    _MobileNumberInput(mobileNumber),
                    const Padding(padding: EdgeInsets.all(8)),
                    _LandlineNumberInput(landlineNumber),
                    const Padding(padding: EdgeInsets.all(8)),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: _SaveButton(voidCallback: _onSubmitSave),
            )),
          ],
        ));
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
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
        setState(() {});
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

class _NameInput extends StatelessWidget {
  TextEditingController nameEditingParameter;

  _NameInput(this.nameEditingParameter);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameEditingParameter,
      decoration: const InputDecoration(
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
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
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
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Landline Number',
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback voidCallback;

  const _SaveButton({required this.voidCallback});

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
                    color: Colors.amber[900],
                    borderRadius: BorderRadius.circular(10)),
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
