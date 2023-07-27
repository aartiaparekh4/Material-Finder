// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_finder/global.dart' as global;
import 'package:material_finder/model/imges_model.dart';
import 'package:material_finder/screens/imges_list_screen.dart';
import 'package:material_finder/services/apihelper.dart';

import 'imges_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? selectedImageFile;
  String? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Material Finder",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ImagesListScreen()),
              );
            },
            icon: const Icon(
              Icons.image,
              size: 25,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  padding: const EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: selectedImageFile != null
                        ? Container(
                            height: 200,
                            width: 250,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: FileImage(selectedImageFile!), fit: BoxFit.cover),
                            ),
                          )
                        : SizedBox(
                            height: 200,
                            width: 250,
                            // child: ElevatedButton.icon(
                            //   style: ElevatedButton.styleFrom(
                            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            //     disabledBackgroundColor: Theme.of(context).primaryColor,
                            //     disabledForegroundColor: Theme.of(context).primaryColor,
                            //     backgroundColor: Theme.of(context).primaryColor,
                            //     textStyle: const TextStyle(color: Colors.white, fontSize: 12, fontStyle: FontStyle.normal),
                            //   ),
                            //   onPressed: () {
                            //     imagePickerSheetImage(context);
                            //   },

                            //   icon: const Icon(
                            //     Icons.file_upload_outlined,
                            //     color: Colors.white,
                            //   ), //icon data for elevated button
                            //   label: const Text(
                            //     'Select Image', style: TextStyle(color: Colors.white, fontSize: 12, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500), //label text
                            //   ),
                            // ),
                            child: InkWell(
                              onTap: () {
                                selectedImage = null;
                                imagePickerSheetImage(context);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.file_upload_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Text(
                                    'Select Image', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500), //label text
                                  ),
                                ],
                              ),
                            ),
                            // child: Image.asset('assets/images/UserImage.png', height: 30),
                          ),
                  ),
                ),
              ),
              selectedImageFile != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              disabledBackgroundColor: Theme.of(context).primaryColor,
                              disabledForegroundColor: Theme.of(context).primaryColor,
                              backgroundColor: Theme.of(context).primaryColor,
                              textStyle: const TextStyle(color: Colors.white, fontSize: 12, fontStyle: FontStyle.normal),
                            ),
                            onPressed: () {
                              if (selectedImageFile != null) {
                                uploadImges();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(global.showSnackBar('Warring', 'Please select image'));
                              }
                            },
                            child: const Text('Upload', style: TextStyle(color: Colors.white, fontSize: 12, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              disabledBackgroundColor: Theme.of(context).primaryColor,
                              disabledForegroundColor: Theme.of(context).primaryColor,
                              backgroundColor: Theme.of(context).primaryColor,
                              textStyle: const TextStyle(color: Colors.white, fontSize: 12, fontStyle: FontStyle.normal),
                            ),
                            onPressed: () {
                              selectedImage = null;
                              imagePickerSheetImage(context);
                            },
                            child: const Text('Retake', style: TextStyle(color: Colors.white, fontSize: 12, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Future<XFile> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );

    print(file.lengthSync());
    print(result!.length());

    return result;
  }

  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2000,
      minHeight: 1000,
      quality: 94,
      rotate: 90,
    );
    print(file.lengthSync());
    print(result!.length);
    return result;
  }

  Future<void> uploadImges() async {
    try {
      global.showOnlyLoaderDialog(context);
      if (selectedImage == 'Camera') {
        final data = await testCompressFile(selectedImageFile!);
        log(data.toString());
        final imageUrl = MultipartFile.fromBytes(
          data,
          // headers: {
          //   "Content-Type": ["multipart/form-data; boundary=<calculated when request is sent>"]
          // },
          // contentType: MediaType("image", "jpeg", {"Content-Type": "multipart/form-data; boundary=<calculated when request is sent>"}),
        );
        await APIHelper().uploadImages(imageUrl).then((result) async {
          global.hideLoader(context);
          if (result != null) {
            if (result.statusCode == 200) {
              ImagesModel imagesModel = result.data;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImgesDetailScreen(imagesData: imagesModel)),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(global.showSnackBar('Warring', 'Please select image'));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(global.showSnackBar('Warring', 'Detail Not Found. Please upload proper image.'));
          }
        });
      } else {
        final imageUrl = await MultipartFile.fromFile(
          selectedImageFile!.path,
          // contentType: new MediaType("image", "jpeg"),
        );
        await APIHelper().uploadImages(imageUrl).then((result) async {
          global.hideLoader(context);
          if (result != null) {
            if (result.statusCode == 200) {
              if (result.data != 'No data') {
                ImagesModel imagesModel = result.data;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImgesDetailScreen(imagesData: imagesModel)),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(global.showSnackBar('Warring', 'Detail Not Found. Please upload proper image.'));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(global.showSnackBar('Warring', 'Please select image'));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(global.showSnackBar('Warring', 'Detail Not Found. Please upload proper image.'));
          }
        });
      }
    } catch (err) {
      print("Exception: homeController.dart uploadImges():-$err");
    }
  }

  imagePickerSheetImage(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
            height: 210,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: const Text(
                    "Select Image",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.image,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Gallery",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor),
                      ),
                      onTap: () async {
                        selectedImageFile = await global.imageService(ImageSource.gallery);
                        setState(() {
                          selectedImage = "Gallery";
                        });
                        if (selectedImageFile != null) {
                          global.hideLoader(context);
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.camera,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        "Camera",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor),
                      ),
                      onTap: () async {
                        selectedImageFile = await global.imageService(ImageSource.camera);
                        setState(() {
                          selectedImage = "Camera";
                        });
                        if (selectedImageFile != null) {
                          global.hideLoader(context);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
