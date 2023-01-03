import 'dart:io';

import 'package:contactsapp/bloc/contact_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_widget.dart';

// class ContactList extends StatefulWidget {
//   bool isFromFav;
//   bool isFromHome;
//   String title;

//   bool refreshData;
//   ContactList(
//       {super.key,
//       required this.isFromFav,
//       required this.title,
//       required this.isFromHome,
//       required this.refreshData});
//   static Route<void> route() {
//     return MaterialPageRoute<void>(
//         builder: (_) => ContactList(
//               isFromFav: false,
//               title: "Contacts",
//               isFromHome: true,
//               refreshData: false,
//             ));
//   }

//   @override
//   State<ContactList> createState() => _ContactListState();
// }

// class _ContactListState extends State<ContactList> {
//   Widget contactsList =
//       BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
//     return state.status.isSuccess
//         ? state.contacts.isEmpty
//             ? const Text("No Contacts found")
//             : ListView.builder(
//                 itemBuilder: (context, index) {
//                   state.contacts.sort((a, b) => a.name.compareTo(b.name));
//                   return Card(
//                     elevation: 5,
//                     child: ListTile(
//                         leading: CircleAvatar(
//                             radius: 26,
//                             backgroundColor: Colors.white,
//                             child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(60.0),
//                                 child: Image.file(
//                                     width: 60,
//                                     height: 60,
//                                     fit: BoxFit.cover,
//                                     File(state.contacts[index].image
//                                         .toString())))),
//                         title: Text(
//                           state.contacts[index].name.toString(),
//                           style: const TextStyle(
//                               fontSize: 18,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(
//                           '${state.contacts[index].mobileNumber}"\n"${state.contacts[index].landlineNumber}',
//                         ),
//                         isThreeLine: true,
//                         onTap: () {},
//                         trailing: GestureDetector(
//                             onTap: (() {
//                               context.read<ContactBloc>().add((UpdateContact(
//                                   contact: state.contacts[index])));

//                               //  updateFav(state.contacts![index]);
//                             }),
//                             child: state.contacts[index].favourite == 1
//                                 ? const Icon(
//                                     Icons.favorite,
//                                     color: Colors.red,
//                                   )
//                                 : const Icon(
//                                     Icons.favorite,
//                                   ))),
//                   );
//                 },
//                 itemCount: state.contacts.length,
//               )
//         : state.status.isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : state.status.isError
//                 ? const ErrorTodoWidget()
//                 : SizedBox();
//   });

//   Widget buildContactList() => BlocProvider<ContactBloc>(
//       create: (context) => widget.isFromFav
//           ? (ContactBloc()..add(GetFavContacts()))
//           : (ContactBloc()..add(GetContacts())),
//       child: widget.isFromHome
//           ? contactsList
//           : Scaffold(
//               appBar: AppBar(title: Text(widget.title)), body: contactsList));

//   @override
//   Widget build(BuildContext context) {
//     if (widget.refreshData) {
//     //   context.read<ContactBloc>().add(GetContacts());
//         return buildContactList();
//     }
//     return buildContactList();
//   }
// }
