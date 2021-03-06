import 'package:flutter/material.dart';
import '../custom/custom_tile.dart';
import '../models/home_manga_module.dart';
import '../models/manga_search_module.dart';
import '../screens/manga_info_screen.dart';
import '../services/data_source.dart';

class DataSearch extends SearchDelegate<String> {
  DataSearch({Key? key}) : super();

  SearchModule? searchRes;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, ""),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: searchRes?.mangas.length ?? 0,
      itemBuilder: (context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MangaInfo(
                  MangaModule(
                    idx: index,
                    title: searchRes!.mangas[index].title,
                    img: searchRes!.mangas[index].img,
                    src: searchRes!.mangas[index].src,
                    views: searchRes!.mangas[index].views,
                    timeStamp: DateTime.now().millisecondsSinceEpoch,
                  ),
                ),
              ),
            );
          },
          child: CustomListItemTwo(
            thumbnail: Image.network(
              searchRes!.mangas[index].img,
              fit: BoxFit.cover,
            ),
            title: searchRes!.mangas[index].title,
            latestChapter: searchRes!.mangas[index].chapterTitle,
            author: searchRes!.mangas[index].authors,
            synopsis: searchRes!.mangas[index].synopsis,
            publishDate: searchRes!.mangas[index].updatedDate,
          ),
        );
      },
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return SingleChildScrollView(
        child: FutureBuilder(
          future: DataSource.getResults(query),
          builder: (_, AsyncSnapshot<SearchModule> snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    color: Color.fromARGB(255, 3, 0, 0),
                    fontSize: 30,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.mangas.length,
                itemBuilder: (context, int index) {
                  searchRes = snapshot.data!;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MangaInfo(
                            MangaModule(
                              idx: index,
                              title: snapshot.data!.mangas[index].title,
                              img: snapshot.data!.mangas[index].img,
                              src: snapshot.data!.mangas[index].src,
                              views: snapshot.data!.mangas[index].views,
                              timeStamp: DateTime.now().millisecondsSinceEpoch,
                            ),
                          ),
                        ),
                      );
                    },
                    child: CustomListItemTwo(
                      thumbnail: Image.network(
                        snapshot.data!.mangas[index].img,
                        fit: BoxFit.cover,
                      ),
                      title: snapshot.data!.mangas[index].title,
                      latestChapter: snapshot.data!.mangas[index].chapterTitle,
                      author: snapshot.data!.mangas[index].authors,
                      synopsis: snapshot.data!.mangas[index].synopsis,
                      publishDate: snapshot.data!.mangas[index].updatedDate,
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    } else {
      return const Center(
        child: Text(
          "",
        ),
      );
    }
  }
}
