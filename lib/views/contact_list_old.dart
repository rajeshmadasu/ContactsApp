// import 'dart:io';

// import 'package:flutter/material.dart';
// import '../bloc/contact_bloc.dart';
// import '../models/contact.dart';
// //
// class ContactList extends StatefulWidget {
//   bool isFromFav;

//   ContactList({super.key, required this.isFromFav});
//   static Route<void> route() {
//     return MaterialPageRoute<void>(
//         builder: (_) => ContactList(
//               isFromFav: false,
//             ));
//   }

//   @override
//   State<ContactList> createState() => _ContactListState();
// }

// class _ContactListState extends State<ContactList> {
//   void updateFav(Contact contact) {
//     setState(() {
//       var updateContact = contact;
//       updateContact.favourite = contact.favourite == 1 ? 0 : 1;
//       //contactBloc.updateContact(contact);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.isFromFav) {
//       //  contactBloc.getFavContacts();
//     } else {
//       //    contactBloc.getContacts();
//     }

//     return Container(
//         decoration: BoxDecoration(color: Colors.white),
//         child: StreamBuilder<List<Contact>>(
//             //  future: contactBloc.getContacts(),
//             builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   elevation: 5,
//                   child: ListTile(
//                       leading: CircleAvatar(
//                           radius: 26,
//                           backgroundColor: Colors.white,
//                           child: ClipRRect(
//                               borderRadius: new BorderRadius.circular(60.0),
//                               child: Image.file(
//                                   width: 60,
//                                   height: 60,
//                                   fit: BoxFit.cover,
//                                   File(snapshot.data![index].image
//                                       .toString())))),
//                       title: Text(
//                         snapshot.data![index].name.toString(),
//                         style: const TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(
//                         snapshot.data![index].mobileNumber.toLowerCase(),
//                       ),
//                       isThreeLine: true,
//                       onTap: () {},
//                       trailing: GestureDetector(
//                           onTap: (() {
//                             updateFav(snapshot.data![index]);
//                           }),
//                           child: snapshot.data![index].favourite == 1
//                               ? const Icon(
//                                   Icons.favorite,
//                                   color: Colors.red,
//                                 )
//                               : const Icon(
//                                   Icons.favorite,
//                                 ))),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             // the code below is used to print the error on the screen
//             return Text(snapshot.error.toString());
//           } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text(
//                 "Add your first contact",
//               ),
//             );
//           }
//           return const Center(child: CircularProgressIndicator());
//         }));
//   }
// }
