import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/bloc/show_users/show_users_bloc.dart';
import 'package:harrowsithivinayagar/bloc/show_users/show_users_event.dart';
import 'package:harrowsithivinayagar/bloc/show_users/show_users_state.dart';

class ShowUsersScreen extends StatefulWidget {
  const ShowUsersScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShowUsersScreenState createState() => _ShowUsersScreenState();
}

class _ShowUsersScreenState extends State<ShowUsersScreen> {
  String _selectedSegment = 'Users';

  @override
  void initState() {
    super.initState();
    // Triggering the initial event to fetch users
    context
        .read<ShowUsersBloc>()
        .add(FetchUsersByRole(_selectedSegment == 'Users' ? 'user' : 'admin'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Users', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(30.0),
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
                  context.read<ShowUsersBloc>().add(
                        FetchUsersByRole(
                            _selectedSegment == 'Users' ? 'user' : 'admin'),
                      );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.orange;
                    }
                    return Colors.transparent;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.white;
                    }
                    return Colors.orange;
                  }),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<ShowUsersBloc, ShowUsersState>(
              builder: (context, state) {
                if (state is ShowUsersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ShowUsersError) {
                  return Center(child: Text(state.error));
                } else if (state is ShowUsersLoaded) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return ListTile(
                        title: Text(user.email),
                        subtitle: Text('Role: ${user.role}'),
                        trailing: DropdownButton<String>(
                          value: user.role,
                          items: ['user', 'admin']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newRole) {
                            if (newRole != null && newRole != user.role) {
                              context
                                  .read<ShowUsersBloc>()
                                  .add(UpdateUserRole(user.id, newRole));
                            }
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No users found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
