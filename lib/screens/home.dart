import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/screens/login.dart';
import 'package:hackathon/util/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class home extends StatefulWidget {
  home({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String name = '';
  String contactInfo = '';
  String address = '';
  String category = 'Category A';
  String urgency = 'Low';
  String description = '';
  // File? selectedImage;

// Function to request storage permission

  // Future<void> pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       selectedImage = File(pickedFile.path);
  //     });
  //   }
  //
  //   if (formKey.currentState!.validate()) {
  //     formKey.currentState!.save();
  //
  //     // Upload image to Firebase Storage
  //     if (selectedImage != null) {
  //       Reference storageReference = FirebaseStorage.instance
  //           .ref()
  //           .child("images/${user!.email}.jpg");
  //       await storageReference.putFile(selectedImage!);
  //
  //       // Get the URL of the uploaded image
  //       String imageUrl = await storageReference.getDownloadURL();
  //       print('Image URL: $imageUrl');
  //     }
  //   }
  // }

  List<String> categories = [
    'Category A',
    'Category B',
    'Category C',
    'Category D'
  ];
  List<String> urgencys = ['Low', 'Medium', 'High'];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Container(
            // width: MediaQuery
            //     .of(context)
            //     .size
            //     .width,
            // height: MediaQuery
            //     .of(context)
            //     .size
            //     .height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          name = value!;
                        },
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Contact Info',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          contactInfo = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          address = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // TextFormField(
                      //   decoration: const InputDecoration(labelText: 'Category'),
                      //   onSaved: (value) {
                      //     category = value!;
                      //   },
                      // ),

                      DropdownButtonFormField(
                        value: category,
                        // Ensure this matches one of the available categories
                        items: [
                          const DropdownMenuItem(
                            value: 'Select a category', // Add a default value
                            child: Text('Select a category'),
                          ),
                          ...categories.map((cat) {
                            return DropdownMenuItem(
                                value: cat, child: Text(cat));
                          }).toList(),
                        ],
                        onChanged: (value) {
                          setState(() {
                            category = value!;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          category = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      DropdownButtonFormField(
                        value: urgency,
                        // Ensure this matches one of the available categories
                        items: [
                          const DropdownMenuItem(
                            value: 'Select a category', // Add a default value
                            child: Text('Select a category'),
                          ),
                          ...urgencys.map((cat) {
                            return DropdownMenuItem(
                                value: cat, child: Text(cat));
                          }).toList(),
                        ],
                        onChanged: (value) {
                          setState(() {
                            urgency = value!;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                        onSaved: (value) {
                          urgency = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                        maxLines: 3,
                        onSaved: (value) {
                          description = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // ElevatedButton(
                      //   onPressed: pickImage,
                      //   child: const Text('Pick Image'),
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),

                      // Container(
                      //   width: 250,
                      //   height: 250,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10.0),
                      //     child: Column(
                      //       children: [
                      //         if (selectedImage !=
                      //             null) // Show the image if it's selected
                      //           Image.file(selectedImage!,width: 200,height: 200,),
                      //         const SizedBox(
                      //           height: 15,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            // Save data to Firebase Firestore with error handling
                            try {
                              await firestore.collection('complaints').add({
                                'name': name,
                                'contactInfo': contactInfo,
                                'address': address,
                                'category': category,
                                'description': description,
                                'user-mail-address': user!.email,
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Complaint submitted!'),
                              ));
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'An error occurred while submitting the complaint.'),
                              ));
                              print('Error: $e');
                            }
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      // Container(width: 250,height: 250,child: Image.network("${selectedImage}")
                      //   ,)
                    ],
                  ),
                ),

                // const Text("You are SuccessFully Logged In",style: TextStyle(fontSize: 20,),),
                // const SizedBox(height: 5,),
                // Text('Logged in user is ${user!.email}',style: TextStyle(fontSize: 20),),
                // const SizedBox(height: 15,),
                // ElevatedButton(
                //   onPressed: () async {
                //     await FirebaseAuth.instance.signOut();
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => const login()),);
                // },
                //   child: const Text("Log Out",style: TextStyle(fontSize: 16),),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
