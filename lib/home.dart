import 'package:flutter/material.dart';
import 'package:my_contact/widgets/contact_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _contactList = [];
  String searchTerm = "";

  void _nofifyUser(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Process the data
      Map<String, dynamic> person = {
        "id": _contactList.length,
        "username": _nameController.text,
        "useremail": _emailController.text,
        "isFavourite": false,
      };

      // print(person);

      setState(() {
        _contactList.add(person);
      });

      _nofifyUser(context, "Contact added successfully");

      _nameController.clear();
      _emailController.clear();
    }
  }

  void _toggleFavourite(int selectedId) {
    // print(_contactList[id]);
    setState(() {
      // _contactList[id]["isFavourite"] = !_contactList[id]["isFavourite"];

      Map<String, dynamic> selectedContact = _contactList.firstWhere(
        (contact) => contact["id"] == selectedId,
      );
      selectedContact["isFavourite"] = !selectedContact["isFavourite"];
    });
    // print(_contactList[id]);
  }

  dynamic getFavouriteContacts() {
    List<Map<String, dynamic>> favouriteContacts =
        _contactList.where((contact) => contact["isFavourite"]).toList();

    int countFavouriteContacts = favouriteContacts.length;

    return {
      "favouriteContacts": favouriteContacts,
      "countFavouriteContacts": countFavouriteContacts,
    };
  }

  void _deleteContact(int selectedId) {
    setState(() {
      List<Map<String, dynamic>> remainingContacts =
          _contactList.where((contact) => contact["id"] != selectedId).toList();

      _contactList = [...remainingContacts];
    });

    _nofifyUser(context, "Contact has been deleted successfully.");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favouriteContacts = getFavouriteContacts();

    // print(favouriteContacts["countFavouriteContacts"]);
    // print(favouriteContacts["favouriteContacts"]);

    // print(searchTerm);

    List<Map<String, dynamic>> filteredContacts =
        searchTerm != ""
            ? _contactList.where((contact) {
              // print(contact);
              if (contact["username"].toLowerCase().contains(
                    searchTerm.toLowerCase(),
                  ) ||
                  contact["useremail"].toLowerCase().contains(
                    searchTerm.toLowerCase(),
                  )) {
                return true;
              }
              return false;
            }).toList()
            : _contactList;

    // print(filteredContacts);
    print(searchTerm);

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Contacts"),
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],

          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade400,
            tabs: [
              Tab(text: "Add Contact", icon: Icon(Icons.person_add)),
              Tab(text: "All Contacts", icon: Icon(Icons.contacts)),
              Tab(text: "Favourites", icon: Icon(Icons.star)),
            ],
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 60,
                        color: Colors.blueGrey,
                      ),

                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "User Name...",
                          labelText: "User Name",
                          border: OutlineInputBorder(),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "User Email...",
                          labelText: "User Email",
                          border: OutlineInputBorder(),
                        ),

                        validator: (value) {
                          RegExp emailRegExp = RegExp(
                            r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                          );

                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          } else if (!emailRegExp.hasMatch(value)) {
                            return "Given email ID is not valid";
                          }

                          return null;
                        },
                      ),

                      ElevatedButton.icon(
                        onPressed: _handleSubmit,
                        icon: Icon(Icons.save),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                        ),
                        label: Text("Save"),
                      ),
                    ],
                  ),
                ),
              ),

              // For all contacts
              Column(
                spacing: 20,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchTerm = value;
                      });
                    },

                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            searchTerm = "";
                            _searchController.clear();
                          });
                        },
                        icon: Icon(Icons.close),
                      ),
                      hintText: "Search...",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredContacts.length,
                      itemBuilder: (context, index) {
                        return ContactCard(
                          person: filteredContacts[index],
                          toggleFavourite: _toggleFavourite,
                          deleteContact: _deleteContact,
                        );
                      },
                    ),
                  ),
                ],
              ),

              // For favourite contacts
              // ListView.builder(
              //   itemCount: getFavouriteContacts().length,
              //   itemBuilder: (context, index) {
              //     return ContactCard(
              //       person: getFavouriteContacts()[index],
              //       toggleFavourite: _toggleFavourite,
              //     );
              //   },
              // ),

              // For favourite contacts
              ListView.builder(
                // O(N)
                itemCount: favouriteContacts["countFavouriteContacts"],
                itemBuilder: (context, index) {
                  return ContactCard(
                    person: favouriteContacts["favouriteContacts"][index],
                    toggleFavourite: _toggleFavourite,
                    deleteContact: _deleteContact,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
