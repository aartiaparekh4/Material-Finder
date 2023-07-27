import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:material_finder/model/imges_model.dart';
import 'package:material_finder/global.dart' as global;

class ImgesDetailScreen extends StatefulWidget {
  final ImagesModel? imagesData;
  const ImgesDetailScreen({this.imagesData, super.key});

  @override
  State<ImgesDetailScreen> createState() => _ImgesDetailScreenState();
}

class _ImgesDetailScreenState extends State<ImgesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Details", style: TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
          onPressed: () {
            global.hideLoader(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Name ", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.w600)),
                        Text(
                          widget.imagesData!.name != null && widget.imagesData!.name != '' ? "${widget.imagesData!.name}" : 'Demo',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Confidence ",
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.imagesData!.confidence != null && widget.imagesData!.confidence != '' ? "${widget.imagesData!.confidence}" : '0.0',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 10, right: 10),
            //     child: Row(
            //       children: [
            //         Text(
            //           "Confidence : ",
            //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.w600),
            //         ),
            //         Text(
            //           widget.imagesData!.confidence != null && widget.imagesData!.confidence != '' ? "${widget.imagesData!.confidence}" : '0.0',
            //           style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.normal),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                padding: const EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: widget.imagesData!.imgUrl != null
                      ? CachedNetworkImage(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          imageUrl: "${widget.imagesData!.imgUrl}",
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(widget.imagesData!.imgUrl!), fit: BoxFit.contain),
                              ),
                            );
                          },
                          progressIndicatorBuilder: (context, url, progress) {
                            return const Center(child: CircularProgressIndicator());
                          },
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.width,
                          width: 200,
                        ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 10, right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Additional Data Point", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.imagesData!.additionalList!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Text(
                                widget.imagesData!.additionalList![index] != '' ? widget.imagesData!.additionalList![index] : '',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                              ),
                              index < widget.imagesData!.additionalList!.length - 1
                                  ? Text(
                                      ',',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                                    )
                                  : const SizedBox()
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
