import 'package:flutter/material.dart';
import 'package:my_contact/alert.dart';

class ContactCard extends StatelessWidget {
  final Map<String, dynamic> person;
  final void Function(int) toggleFavourite;
  final void Function(int) deleteContact;

  const ContactCard({
    super.key,
    required this.person,
    required this.toggleFavourite,
    required this.deleteContact,
  });

  @override
  Widget build(BuildContext context) {
    // print(person);
    // print(toggleFavourite);
    return GestureDetector(
      onLongPress: () => showAlertDialog(context, deleteContact, person["id"]),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(
            person["username"],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          subtitle: Text(person["useremail"]),

          trailing: IconButton(
            onPressed: () {
              toggleFavourite(person["id"]);
            },
            icon: Icon(
              Icons.star,
              color:
                  person["isFavourite"] == true
                      ? Colors.indigoAccent
                      : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
