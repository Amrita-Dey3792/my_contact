import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, void Function(int) deleteContact, int contactId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          spacing: 10,
          children: [
            Icon(Icons.warning, color: Colors.red),
            Text("Are you sure?"),
          ],
        ),
        content: Text("Do you really want to delete these records?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          ElevatedButton(
            child: Text("Yes"),
            onPressed: () {
              deleteContact(contactId);
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
