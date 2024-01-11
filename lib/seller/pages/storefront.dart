import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import '../../constants/constant.dart';
import '../../pages/auth/login.dart';
import '../../providers/firebase_authproviders.dart';
import '../../screens/view_product.dart';
import '../../widgets/recent_card.dart';
import '../../widgets/store_front_wid.dart';
import '../../widgets/user_or_seller.dart';

class StoreFront extends StatefulWidget {
  const StoreFront({super.key});

  @override
  State<StoreFront> createState() => _StoreFrontState();
}

class _StoreFrontState extends State<StoreFront> {
  late CollectionReference imageRef;
  late firebase_storage.Reference ref;
  File? _image;
  String _bannerDownloadURL = '';
  final picker = ImagePicker();

  chooseImageBanner() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('bannerImages/${Path.basename(_image!.path)}');
    await ref.putFile(_image!).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        setState(() {
          _bannerDownloadURL = value;
        });
        print(_bannerDownloadURL);
        // AuthRepository(
        //         firebaseAuth: FirebaseAuth.instance,
        //         firebaseFirestore: FirebaseFirestore.instance)
        //     .uploadBannerImage(_bannerDownloadURL, context,
        //         FirebaseAuth.instance.currentUser!.uid);
      });
    });
  }

  void uploadBannerImage() async {
    chooseImageBanner();
    // .whenComplete(() async {
    //   ref = firebase_storage.FirebaseStorage.instance
    //       .ref()
    //       .child('images/${Path.basename(_image!.path)}');
    //   await ref.putFile(_image!).whenComplete(() async {
    //     await ref.getDownloadURL().then((value) {
    //       setState(() {
    //         _bannerDownloadURL = value;
    //       });
    //     });
    //     AuthRepository(
    //             firebaseAuth: FirebaseAuth.instance,
    //             firebaseFirestore: FirebaseFirestore.instance)
    //         .uploadBannerImage(_bannerDownloadURL, context,
    //             FirebaseAuth.instance.currentUser!.uid);
    //   });
    // });
  }

  void uploadPic() async {}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Store Preview'),
        ),
        body: StreamBuilder(
            stream: AuthRepository(
                    firebaseAuth: FirebaseAuth.instance,
                    firebaseFirestore: FirebaseFirestore.instance)
                .getSellerData(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      snapshot.data!.storeBannerImage == ''
                          ? Container(
                              height: height * 0.35,
                              width: width,
                              color: Colors.blue,
                              child: Center(
                                child: IconButton(
                                    onPressed: () => uploadBannerImage(),
                                    icon: const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    )),
                              ),
                            )
                          : Container(
                              height: height * 0.35,
                              width: width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data!.storeBannerImage),
                                      fit: BoxFit.cover)),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: snapshot.data!.profilePic == ''
                                ? NetworkImage(userImageCollection)
                                : NetworkImage(snapshot.data!.profilePic),
                          ),
                          Text(
                            snapshot.data!.storeName,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      //one

                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      StoreFrontCard(
                          category: 'Electronics',
                          sellerId: snapshot.data!.uuid,),

                      //two
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      StoreFrontCard(
                          category: 'Food', sellerId: snapshot.data!.uuid),

                      //three

                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      StoreFrontCard(
                          category: 'Shoes', sellerId: snapshot.data!.uuid),
                      //for
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      StoreFrontCard(
                          category: 'Cloths', sellerId: snapshot.data!.uuid),

                      //five
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      StoreFrontCard(
                          category: 'Cosmetics', sellerId: snapshot.data!.uuid),

                      //six
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      StoreFrontCard(
                          category: 'Services', sellerId: snapshot.data!.uuid),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                    child: UserOrSeller(
                  name:
                      'You can\'t login with clients\'s details in seller app',
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
            }));
  }
}
