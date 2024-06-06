import 'package:dars_3_12_uy_ishi/controllers/contact_controller.dart';
import 'package:dars_3_12_uy_ishi/models/contact.dart';
import 'package:dars_3_12_uy_ishi/services/local_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final addNameController = TextEditingController();

  final addNumberController = TextEditingController();

  final editNameController = TextEditingController();

  final editNumberController = TextEditingController();

  final localDatabase = LocalDatabase();

  final contactController = ContactController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    contactController.database;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contacts"),
      ),
      body: FutureBuilder(
          future: contactController.getContacts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("Kontaktlar topilmadi"),
              );
            }
            List<Contact> contacts = snapshot.data!;
            return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 130, 226, 133),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contacts[index].name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  contacts[index].number,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 66, 61, 61),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Edit Contact"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller:
                                                      editNameController,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          suffixIcon: Icon(
                                                            Icons.person,
                                                          ),
                                                          hintText:
                                                              "Enter new  name"),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                TextField(
                                                  controller:
                                                      editNumberController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          suffixIcon: Icon(
                                                            Icons.phone,
                                                          ),
                                                          hintText:
                                                              "Enter new number"),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            "Cancel")),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors.blue),
                                                      onPressed: () {
                                                        contactController.editContact(
                                                            contacts[index]
                                                                .name,
                                                            contacts[index]
                                                                .number,
                                                            editNameController
                                                                .text,
                                                            editNumberController
                                                                .text);
                                                        editNameController
                                                            .clear();
                                                        editNumberController
                                                            .clear();
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() {});
                                                      },
                                                      child: const Text(
                                                        "Edit contact",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      contactController.deleteContact(
                                          contacts[index].name,
                                          contacts[index].number);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Contact"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: addNameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              Icons.person,
                            ),
                            hintText: "Enter name"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: addNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              Icons.phone,
                            ),
                            hintText: "Enter number"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          contactController.addContact(
                              addNameController.text, addNumberController.text);
                          addNameController.clear();
                          addNumberController.clear();
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: const Text(
                          "Add contact",
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
