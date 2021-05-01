
import 'news_api_provider.dart';
import 'news_item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    NewsApiProvider(),
  ];


  Future<List<int>> fetchTopId() {
    return sources[1].fetchTopId();
  }

  Future<NewsItemModel> fetchItem(int id) async {
    NewsItemModel item;
    var source;

    for (source in sources) {
      item = await source.fetchItems(id);
      if (item != null) {
        break;
      }
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopId();
  Future<NewsItemModel> fetchItems(int id);
}

