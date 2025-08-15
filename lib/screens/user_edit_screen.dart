import 'package:flutter/material.dart';
import 'package:mockapi_flutter/models/user.dart';
import 'package:mockapi_flutter/services/api_service.dart';

class UserEditScreen extends StatefulWidget {
  final User? user;

  const UserEditScreen({super.key, this.user});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  bool isLoading = false;
  final ApiService apiService = ApiService();

  Future<void> saveUser() async {
    if (!formKey.currentState!.validate() || !mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      if (widget.user == null) {
        // add student ->

        await apiService.createUser(nameController.text, cityController.text);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('New student added successfully!'), backgroundColor: Colors.green),
          );
        }
      } else {
        // edit student ->

        await apiService.updateUser(widget.user!.id, nameController.text, cityController.text);

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('User information updated!'), backgroundColor: Colors.green));
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving data: $e'), backgroundColor: Colors.red));
      }
    }

    // if (mounted) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();

    if (widget.user != null) {
      nameController.text = widget.user!.name;
      cityController.text = widget.user!.city;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user == null ? 'Add Student' : 'Edit Student')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Student Name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter a Name';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    prefixIcon: Icon(Icons.location_city_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter a City';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => saveUser(),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: isLoading ? () {} : saveUser,
                  child: isLoading
                      ? const SizedBox(
                          height: 19,
                          width: 19,
                          child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
                        )
                      : Text(widget.user == null ? 'Add Student' : 'Update Information'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    cityController.dispose();

    super.dispose();
  }
}
