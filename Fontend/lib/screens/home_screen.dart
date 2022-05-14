import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/search_screen.dart';
import '../widgets/home_drawer.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
import '../models/home_manga_module.dart';
import '../services/data_source.dart';
import '../services/database_helper.dart';
import '../utils/constants.dart';
import '../widgets/popular_manga_widget.dart';
import '../widgets/recent_chapters_widget.dart';

class MangaHome extends StatefulWidget {
  const MangaHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MangaHomeState();
  }
}

class MangaHomeState extends State<MangaHome> {
  MangaHomeState({Key? key}) : super();
  Future? recentMangaFuture;
  Future? popularMangaFuture;
  // refresh data every 15 minutes
  static const int minutes = 10;

  get press => null;
  void openSearch() async {
    await showSearch(context: context, delegate: DataSearch());
  }

  @override
  void initState() {
    super.initState();
    recentMangaFuture = getMangas('R', 'recent_manga');
    popularMangaFuture = getMangas('P', 'popular_manga');
  }

  getMangas(String tag, String table) async {
    if (await getOfflineManga(table) != null) {
      List<MangaModule> res = await getOfflineManga(table) as List<MangaModule>;
      if (DateTime.fromMillisecondsSinceEpoch(res[0].timeStamp)
                  .add(const Duration(minutes: minutes))
                  .millisecondsSinceEpoch <
              DateTime.now().millisecondsSinceEpoch &&
          await DataSource.isConnectedToInternet() == true) {
        if (kDebugMode) {
          print('data expired');
        }
        var ress = (tag == 'R')
            ? await DataSource.getLatestManga()
            : await DataSource.getPopularManga();
        await DatabaseHelper.db.clearTable(table);
        for (MangaModule manga in ress) {
          await DatabaseHelper.db.insertHomeManga(manga, table);
        }
        return ress;
      } else {
        if (kDebugMode) {
          print("data is usable");
        }
        return res;
      }
    } else if (await DataSource.isConnectedToInternet() == true) {
      var res = (tag == 'R')
          ? await DataSource.getLatestManga()
          : await DataSource.getPopularManga();
      for (MangaModule manga in res) {
        await DatabaseHelper.db.insertHomeManga(manga, table);
      }
      return res;
    } else {
      return null;
    }
  }

  getOfflineManga(String table) async {
    var res = await DatabaseHelper.db.getManga(table);
    return res;
  }

  refresh() async {}

  @override
  Widget build(context) {
    return Scaffold(
      // padding: const EdgeInsets.symmetric(vertical: 20),
      drawer: const HomeDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false, //hide back button
        backgroundColor: Colors.blue.shade500,
        leading: Builder(
        builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Text(
          Constant.APP_NAME,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: <Widget>[
          IconButton(
          icon: const Icon(
            Icons.search_outlined,
          ),
          onPressed: () => openSearch(),
          iconSize: 27.0,
          enableFeedback: true,
          splashRadius: 20.0,
        )
        ],
      ),

      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
         // it enable scrolling on small device
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              // Recent Chapter Text
              Container(
                margin: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                width: double.infinity,
                child: const Text(
                  "Latest Chapters",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              // Recent Chapter Manga
              Container(
                height: 250,
                margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: FutureBuilder(
                  future: recentMangaFuture,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, int index) => recentChapterCard(
                            manga: snapshot.data[index], context: context),
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                width: double.infinity,
                child: const Text(
                  "Popular Manga",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Wrap(
                // width: double.infinity,
                children: [
                  FutureBuilder(
                    future: popularMangaFuture,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, int index) => popularMangaCard(
                              manga: snapshot.data[index], context: context),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
