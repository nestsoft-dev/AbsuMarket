import 'dart:io';

import 'package:absumarket/constants/colors.dart';
import 'package:absumarket/functions/functions.dart';
import 'package:absumarket/utils/myutils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../models/post_model.dart';
import '../../pages/auth/login.dart';
import '../../providers/firebase_authproviders.dart';
import '../../widgets/button.dart';
import 'package:path/path.dart' as Path;

import '../../widgets/user_or_seller.dart';

class UploadAds extends StatefulWidget {
  const UploadAds({super.key});

  @override
  State<UploadAds> createState() => _UploadAdsState();
}

class _UploadAdsState extends State<UploadAds> {
  late CollectionReference imageRef;
  late firebase_storage.Reference ref;
  String? _imagePath;
  String? _selectedDays;
  Future<void> _checkImageDimensions() async {
    if (_selectedImage != null) {
      final decodedImage =
          await decodeImageFromList(_selectedImage!.readAsBytesSync());

      if (decodedImage.width == 1024 && decodedImage.height == 500) {
        // Image has the correct dimensions
      } else {
        // Show an error or provide feedback
        errorSnack(
            context,
            'Image dimensions are not valid. Please choose a 1024x500 image.',
            'Image size');

        // Optionally, reset the selected image
        setState(() {
          _selectedImage = null;
        });
      }
    }
  }

  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      // Check the dimensions
      await _checkImageDimensions();
    }
  }

  String downLoadLink = '';
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Post an Advert'),
        actions: [
          IconButton(
              onPressed: () => advertInfo(context),
              icon: const Icon(
                Iconsax.info_circle,
                color: Colors.grey,
              ))
        ],
      ),
      body: StreamBuilder(
          stream: AuthRepository(
                  firebaseAuth: FirebaseAuth.instance,
                  firebaseFirestore: FirebaseFirestore.instance)
              .getSellerData(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),

                    //Container to display image
                    _selectedImage == null
                        ? GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: Container(
                              height: height * 0.2,
                              width: width,
                              color: Colors.grey,
                              child: Center(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Please Pic an Image (1024*500)',
                                    style: GoogleFonts.podkova(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Icon(
                                    Icons.broken_image,
                                    size: 35,
                                  )
                                ],
                              )),
                            ),
                          )
                        : Container(
                            height: 150.0,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            child: Image.file(
                              _selectedImage!,
                              height: 150.0,
                            ),
                          ),
                    // const SizedBox(
                    //   height: 15,
                    // ),

                    // //Dropdown menu for number of days to run ads
                    SizedBox(
                      height: height * 0.2,
                    ),
                    _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: deepBlue,
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              if (_selectedImage == null) {
                                errorSnack(context, 'Please Select an image',
                                    'Ads image');
                                return;
                              }
                              if (snapshot.data!.balance < 2500) {
                                errorSnack(context, 'Low Balance', 'Ads Error');
                                return;
                              }
                              // else if (_selectedDays == null) {
                              //   errorSnack(context, 'Please Select Length of ads',
                              //       'Error Ads Days');
                              //   return;
                              // }
                              setState(() {
                                _isLoading = true;
                              });

                              ref = firebase_storage.FirebaseStorage.instance
                                  .ref()
                                  .child(
                                      'images/${Path.basename(_selectedImage!.path)}');
                              await ref
                                  .putFile(_selectedImage!)
                                  .whenComplete(() async {
                                await ref.getDownloadURL().then((value) {
                                  setState(() {
                                    downLoadLink = value;
                                  });
                                  DateTime now = DateTime.now();
                                  DateTime expirationTime =
                                      now.add(const Duration(hours: 24));
                                  final post = PostModel(
                                      imageUrl: downLoadLink,
                                      storeId: snapshot.data!.uuid,
                                      createdAt: expirationTime,
                                      expirationTime: expirationTime);
                                  payAds(context, snapshot.data!.storeName,
                                      post, snapshot.data!.balance.toInt());
                                });
                              });
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            child: Button(
                                backroundColor: deepBlue,
                                borderColor: deepyellow,
                                text: 'Post Ads'),
                          )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                  child: UserOrSeller(
                name: 'You can\'t login with clients\'s details in seller app',
                destinaltion: LoginPage(),
              ));

              // return const Center(
              //   child: Text('Error: 404'),
              // );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
