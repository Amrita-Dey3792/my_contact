import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final Map<String, dynamic> person;
  final void Function(int) toggleFavourite;

  const ContactCard({
    super.key,
    required this.person,
    required this.toggleFavourite,
  });

  @override
  Widget build(BuildContext context) {
    // print(person);
    // print(toggleFavourite);
    return Card(
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
    );
  }
}
