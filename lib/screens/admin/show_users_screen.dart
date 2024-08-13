import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowUsersScreen extends StatefulWidget {
  const ShowUsersScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShowUsersScreenState createState() => _ShowUsersScreenState();
}

class _ShowUsersScreenState extends State<ShowUsersScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedSegment = 'Users'; // Initial segment

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Users', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          const SizedBox(
              height: 16), // Add space between AppBar and SegmentedButton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors
                    .orange[100], // Background color for the segment control
                borderRadius: BorderRadius.circular(30.0), // Rounded corners
              ),
              child: SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'Users',
                    label: Text('Users'),
                  ),
                  ButtonSegment(
                    value: 'Admins',
                    label: Text('Admins'),
                  ),
                ],
                selected: {_selectedSegment},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    _selectedSegment = newSelection.first;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.orange;
                    }
                    return Colors.transparent;
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.white;
                    }
                    return Colors.orange;
                  }),
                ),
              ),
            ),
          ),
          const SizedBox(
              height: 16), // Add space between SegmentedButton and content
          Expanded(
            child: _selectedSegment == 'Users'
                ? _buildUserList('user')
                : _buildUserList('admin'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList(String role) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .where('role', isEqualTo: role)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final userEmail = user['email'];
            final userRole = user['role'];

            return ListTile(
              title: Text(userEmail),
              subtitle: Text('Role: $userRole'),
              trailing: DropdownButton<String>(
                value: userRole,
                items: ['user', 'admin']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newRole) {
                  if (newRole != null && newRole != userRole) {
                    _updateUserRole(user.id, newRole);
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _updateUserRole(String userId, String newRole) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'role': newRole});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Role updated to $newRole')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update role: $e')),
      );
    }
  }
}
