import 'package:flutter/material.dart';

import '../custom/custom_tile.dart';
import '../models/home_manga_module.dart';
import '../screens/manga_info_screen.dart';
import '../services/data_source.dart';
// ignore: unused_import
import '../utils/constants.dart';

DataSource dataSource = DataSource();

Widget popularMangaCard({
  required MangaModule manga,
  required BuildContext context,
}) =>
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MangaInfo(manga),
          ),
        );
      },
      child: CustomListItemTwo(
        thumbnail: Image.network(
          manga.img,
          fit: BoxFit.cover,
        ),
        title: manga.title,
        latestChapter: manga.chapter,
        author: manga.author,
        synopsis: manga.synopsis,
        publishDate: manga.uploadedDate,
      ),
    );