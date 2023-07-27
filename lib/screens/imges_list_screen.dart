// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_finder/global.dart' as global;
import 'package:material_finder/model/imges_list_model.dart';
import 'package:material_finder/services/apihelper.dart';

class ImagesListScreen extends StatefulWidget {
  const ImagesListScreen({super.key});

  @override
  State<ImagesListScreen> createState() => _ImagesListScreenState();
}

class _ImagesListScreenState extends State<ImagesListScreen> {
  bool isLoading = false;
  DateTime? selectDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    isLoading = true;
    imagesListGet();
  }

  List<ImageListModel> imgesList = [];
  List<dynamic> imgesListForAll = [];
  List<dynamic> imgesListForFilter = [];

  Future<void> imagesListGet() async {
    try {
      // global.showOnlyLoaderDialog(context);

      await APIHelper().getImagesList().then((result) async {
        // global.hideLoader(context);
        if (result != null) {
          if (result.statusCode == 200) {
            setState(() {
              imgesListForAll = result.data;
              imgesListForFilter = result.data;
              isLoading = false;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(global.showSnackBar('Warring', 'Detail Not Found.'));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(global.showSnackBar('Warring', 'Detail Not Found.'));
        }
      });
    } catch (err) {
      print("Exception: homeController.dart uploadImges():-$err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Images",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () {
            global.hideLoader(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: IconButton(
                onPressed: () async {
                  selectDate = await global.selectDateFrom(context);
                  isLoading = true;
                  List<String> removeList = [];
                  for (var i = 0; i < imgesListForFilter.length; i++) {
                    List<String> tempList = imgesListForFilter[i].split('_');
                    String link = '';
                    if (tempList.length > 1) {
                      link = tempList[1];
                    }
                    String dataList = link.split('/').last;
                    String date = dataList;
                    String dateWithT = '${date.substring(0, 8)}T${date.substring(8)}';
                    DateTime dateTime = DateTime.parse(dateWithT);
                    // DateTime selectDataTime = DateFormat
                    print("selectDatETime $dateTime");
                    if (selectDate!.day == dateTime.day && selectDate!.month == dateTime.month && selectDate!.year == dateTime.year) {
                      removeList.add(imgesListForFilter[i]);
                    }
                  }
                  print(removeList.length);
                  print(removeList);
                  setState(() {
                    imgesListForAll = removeList;
                    print("select $selectDate");
                    isLoading = false;
                  });
                },
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        'Select the date',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : StatefulBuilder(builder: (context, setStat) {
                      return ListView.builder(
                        itemCount: imgesListForAll.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: CachedNetworkImage(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              imageUrl: "${imgesListForAll[index]}",
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                  ),
                                );
                              },
                              progressIndicatorBuilder: (context, url, progress) {
                                return const Center(child: CircularProgressIndicator());
                              },
                            ),
                          );
                        },
                      );
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
