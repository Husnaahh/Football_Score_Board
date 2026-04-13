import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constant/app_color.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final TextEditingController titleController = TextEditingController();

  final CollectionReference matches =
  FirebaseFirestore.instance.collection('matches');

  // 🔥 ADD DATA
  Future<void> addMatch() async {
    if (titleController.text.isEmpty) return;

    await matches.add({
      'title': titleController.text.trim(),
      'createdAt': Timestamp.now(),
    });

    titleController.clear();
  }

  // 🔥 UPDATE DATA
  Future<void> updateMatch(String id, String newTitle) async {
    await matches.doc(id).update({
      'title': newTitle,
    });
  }

  // 🔥 DELETE DATA
  Future<void> deleteMatch(String id) async {
    await matches.doc(id).delete();
  }

  // 🔥 UPDATE DIALOG
  void showUpdateDialog(String id, String oldTitle) {
    final TextEditingController editController =
    TextEditingController(text: oldTitle);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Match"),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: "Enter new title",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                updateMatch(id, editController.text.trim());
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGrey,

      // 👑 APP BAR
      appBar: AppBar(
        title: const Text("Admin Dashboard 👑"),
        backgroundColor: AppColor.accentGreen,
      ),

      // ➕ ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.accentGreen,
        onPressed: addMatch,
        child: const Icon(Icons.add),
      ),

      // 📊 LIVE DATA
      body: Column(
        children: [
          // INPUT BOX
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter match title",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // LIST
          Expanded(
            child: StreamBuilder(
              stream: matches.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: ListTile(
                        title: Text(doc['title']),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Colors.blue),
                              onPressed: () {
                                showUpdateDialog(
                                  doc.id,
                                  doc['title'],
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red),
                              onPressed: () {
                                deleteMatch(doc.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}