import 'dart:io';

import 'package:ads_app/feature/account/cubit/profile_cubit.dart';
import 'package:ads_app/feature/resources/colors/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserCubit()..getUser(FirebaseAuth.instance.currentUser?.uid ?? ''),
      child: BlocBuilder<UserCubit, Map<String, dynamic>?>(
        builder: (context, userData) {
          if (userData == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Contact Info'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (pickedFile != null) {
                          context.read<UserCubit>().uploadProfileImage(
                              FirebaseAuth.instance.currentUser!.uid,
                              File(pickedFile.path));
                        }
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(userData['imageUrl'] ??
                            'https://via.placeholder.com/150'),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                      'Name', userData['name'] ?? '', context, 'name'),
                  _buildTextField('Birthdate', userData['birthdate'] ?? '',
                      context, 'birthdate'),
                  _buildGenderDropdown(
                      'Gender', userData['gender'] ?? '', context, 'gender'),
                  _buildTextField(
                      'Email', userData['email'] ?? '', context, 'email'),
                  _buildTextField('Phone Number', userData['phone'] ?? '',
                      context, 'phone'),
                  _buildTextField(
                      'Address', userData['address'] ?? '', context, 'address'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue,
      BuildContext context, String fieldKey) {
    TextEditingController controller =
        TextEditingController(text: initialValue);
    TextInputType keyboardType = TextInputType.text; // Default
    if (fieldKey == 'phone' || fieldKey == 'birthdate') {
      keyboardType = TextInputType.datetime;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: TextButton(
            child: const Text(
              "Change",
              style: TextStyle(color: AppColors.red),
            ),
            onPressed: () {
              context.read<UserCubit>().updateUser(
                  FirebaseAuth.instance.currentUser!.uid,
                  {fieldKey: controller.text});
            },
          ),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown(String label, String initialValue,
      BuildContext context, String fieldKey) {
    String? selectedGender = initialValue.isEmpty ? null : initialValue;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        decoration: InputDecoration(
          labelText: label,
        ),
        items: <String>[
          'Male',
          'Female',
        ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          context.read<UserCubit>().updateUser(
              FirebaseAuth.instance.currentUser!.uid,
              {fieldKey: newValue ?? ''});
          selectedGender = newValue; // Update the local state
        },
      ),
    );
  }
}
