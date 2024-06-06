import 'package:dars_3_12_uy_ishi/services/local_database.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final localDatabase = LocalDatabase();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    localDatabase.database;
  }

  void addContact() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const Column(
                      children: [Text("dcvjgcvdjvjga")],
                    );
                  },
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text("Notes")),
    );
  }
}
