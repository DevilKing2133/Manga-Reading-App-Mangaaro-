import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';

// ignore: unused_import
import '../models/manga_info_module.dart';
import '../services/data_source.dart';
import '../utils/constants.dart';

// ignore: must_be_immutable
class Pages extends StatelessWidget {
  Pages(this.chapterLink, {Key? key}) : super(key: key);
  String chapterLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(// Your screen background color
            ),
        FutureBuilder(
          future: DataSource.getChapterPages(chapterLink),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              );
            } else {
              return Swiper(
                itemCount: snapshot.data.length,
                loop: false,
                itemHeight: 300,
                layout: SwiperLayout.DEFAULT,
                itemBuilder: (context, index) {
                  return Image.network(
                    snapshot.data[index].img,
                    fit: BoxFit.contain,
                    headers: const {"Referer": Constant.referer},
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.blue.withOpacity(0), //transparent
            elevation: 0.0, //No shadow
          ),
        ),
      ]),
    );
  }
}
