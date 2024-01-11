import 'dart:io';
import 'package:absumarket/constants/colors.dart';
import 'package:absumarket/constants/constant.dart';
import 'package:absumarket/models/productmodel.dart';
import 'package:absumarket/pages/auth/login.dart';
import 'package:absumarket/providers/firebase_authproviders.dart';
import 'package:absumarket/utils/myutils.dart';
import 'package:absumarket/widgets/user_or_seller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../../widgets/textinput.dart';

class UpLoadProducts extends StatefulWidget {
  const UpLoadProducts({super.key});

  @override
  State<UpLoadProducts> createState() => _UpLoadProductsState();
}

class _UpLoadProductsState extends State<UpLoadProducts> {
  late MultiImagePickerController controller;
  late CollectionReference imageRef;
  late firebase_storage.Reference ref;

  List<File> _image = [];
  List<String> _imagesDownloadURL = [];
  final picker = ImagePicker();
  var uuid = Uuid();
  String selectedCategory = 'Electronics';
  List<String> categories = [
    'Electronics',
    'Food',
    'Shoes',
    'Cloths',
    'Cosmetics',
    'Services',
  ];

  @override
  void initState() {
    super.initState();
    controller = MultiImagePickerController(
        maxImages: 15,
        allowedImageTypes: ['png', 'jpg', 'jpeg'],
        withData: true,
        withReadStream: true,
        images: <ImageFile>[] // array of pre/default selected images
        );
  }

  bool _isLoading = false;
  uploadProduct(BuildContext context, String name, String category,
      List<String> images, double price, String fcm, String storeName) async {
    String productID = uuid.v4();
    String seller_id = FirebaseAuth.instance.currentUser!.uid;
    final product = ProductModel(
        productName: name,
        storeName: storeName,
        storeFCM: fcm,
        storeOwnerUID: seller_id,
        productDes: _productDes.text,
        productCounpon: _productCoupon.text,
        price: price,
        discountprice: _productDiscountPrice.text.isEmpty
            ? 00
            : double.parse(_productDiscountPrice.text),
        images: images,
        sizes: [],
        category: category,
        productId: productID,
        quantity: 1,
        location: _productLocation.text, rate: []);
    uploadImages().whenComplete(() async {
      await FirebaseFirestore.instance
          .collection(productsCollection)
          .doc(productID)
          .set(product.toMap())
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        successMessageSnack(context, 'Product uploaded', 'Great Job');
      });
    });
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
  }

  uploadImages() async {
    for (var img in _image) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          setState(() {
            _imagesDownloadURL.add(value);
            _image.clear();
          });
        });
      });
      print('${_imagesDownloadURL.length}------------------------>');
    }
  }

  final _productName = TextEditingController();
  final _productPrice = TextEditingController();
  final _productDiscountPrice = TextEditingController();
  final _productCoupon = TextEditingController();
  final _productDes = TextEditingController();
  final _productLocation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload A product'),
          // actions: [
          //   ElevatedButton(
          //       onPressed: () {
          //         uploadImages();
          //       },
          //       child: Text('Upload'))
          // ],
        ),
        body: StreamBuilder(
            stream: AuthRepository(
                    firebaseAuth: FirebaseAuth.instance,
                    firebaseFirestore: FirebaseFirestore.instance)
                .getSellerData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: height * 0.35,
                        child: GridView.builder(
                            itemCount: _image.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (_, index) {
                              return index == 0
                                  ? Center(
                                      child: IconButton(
                                          onPressed: () {
                                            chooseImage();
                                          },
                                          icon: const Column(
                                            children: [
                                              Icon(Icons.add),
                                              Text('Add Images')
                                            ],
                                          )),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  FileImage(_image[index - 1]),
                                              fit: BoxFit.cover)),
                                    );
                            }),
                      ),

                      SizedBox(
                        height: height * 0.01,
                      ),
                      const Text(
                        'Select a category:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      DropdownButton<String>(
                        value: selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                          });
                        },
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),

                      //product name
                      MyTextInput(
                          hint: 'Enter Product Name',
                          textEditingController: _productName,
                          textInputType: TextInputType.name,
                          isPassword: false,
                          icon: Icons.production_quantity_limits),
                      SizedBox(
                        height: height * 0.01,
                      ),

                      //product price
                      MyTextInput(
                          hint: 'Enter Product Price',
                          textEditingController: _productPrice,
                          textInputType: TextInputType.number,
                          isPassword: false,
                          icon: Icons.price_check),
                      SizedBox(
                        height: height * 0.01,
                      ),

                      //product discountPrice
                      MyTextInput(
                          hint: 'Enter Discount price if any',
                          textEditingController: _productDiscountPrice,
                          textInputType: TextInputType.number,
                          isPassword: false,
                          icon: Icons.price_change_outlined),
                      SizedBox(
                        height: height * 0.01,
                      ),

                      //product Coupon
                      MyTextInput(
                          hint: 'Enter Coupon code if any',
                          textEditingController: _productCoupon,
                          textInputType: TextInputType.name,
                          isPassword: false,
                          icon: Icons.discount_outlined),
                      SizedBox(
                        height: height * 0.01,
                      ),

                      //product descrip
                      MyTextInput(
                          hint: 'Enter product Description',
                          textEditingController: _productDes,
                          textInputType: TextInputType.name,
                          isPassword: false,
                          icon: Icons.abc),

                      //product location
                      MyTextInput(
                          hint: 'Enter location',
                          textEditingController: _productLocation,
                          textInputType: TextInputType.streetAddress,
                          isPassword: false,
                          icon: Icons.local_activity),
                      SizedBox(
                        height: 20,
                      ),

                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: deepBlue,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                if (selectedCategory.isEmpty ||
                                    _productName.text.isEmpty ||
                                    _productPrice.text.isEmpty ||
                                    _productDes.text.isEmpty ||
                                    _productDes.text.isEmpty) {
                                  errorSnack(context,
                                      'Please fill the empty fields', 'Error');
                                  return;
                                }
                                setState(() {
                                  _isLoading = true;
                                });
                                /* context,
                            _productName.text,
                            selectedCategory,
                            _imagesDownloadURL,
                            double.parse(_productPrice.text)*/
                                uploadProduct(
                                    context,
                                    _productName.text,
                                    selectedCategory,
                                    _imagesDownloadURL,
                                    double.parse(_productPrice.text),
                                    snapshot.data!.fcm,
                                    snapshot.data!.storeName);
                              },
                              child: const Button(
                                  backroundColor: deepBlue,
                                  borderColor: deepyellow,
                                  text: 'Upload Product'),
                            )
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
