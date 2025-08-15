import 'package:flutter/material.dart';
import 'package:mockapi_flutter/models/user.dart';
import 'package:mockapi_flutter/screens/user_edit_screen.dart';
import 'package:mockapi_flutter/services/api_service.dart';
import 'package:mockapi_flutter/widgets/user_list_item.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});
  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final ApiService apiService = ApiService();
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      users = await apiService.getUsers();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error fetching data: $e'), backgroundColor: Colors.red));
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _navigateAndRefresh(Widget screen) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    if (result == true) {
      loadUsers();
    }
  }

  Future<void> deleteUser(String id) async {
    if (!mounted) return;

    try {
      await apiService.deleteUser(id);
      // await loadUsers(); // optional
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User deleted successfully'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error deleting user: $e'), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      floatingActionButton: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              _navigateAndRefresh(UserEditScreen());
            },
            icon: Icon(Icons.add),
            label: Text('Add Student'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : users.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 80, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    'No users found',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text('Tap the + button to add a new student', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: loadUsers,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text('Dunijet Student List'),
                    floating: true,
                    snap: true,
                    pinned: false,
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(bottom: bottomPadding + 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final user = users[index];
                        return UserListItem(
                          user: user,
                          onTap: () {
                            _navigateAndRefresh(UserEditScreen(user: user));
                          },
                          onDismissed: () {
                            deleteUser(user.id);
                          },
                        );
                      }, childCount: users.length),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
