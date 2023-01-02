import 'package:contactsapp/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorTodoWidget extends StatelessWidget {
  const ErrorTodoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ignore: prefer_const_constructors
        Center(
          child: const Text(
            'Something went wrong',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Center(
          child: Text(
            'Give it another try',
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: TextButton(
            child: const Text(
              'RELOAD',
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              context.read<ContactBloc>().add(GetContacts());
            },
          ),
        ),
      ],
    );
  }
}
