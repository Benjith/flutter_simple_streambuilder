import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:zoondia_test/model.dart';

class Block {
  final _allItems = PublishSubject();
  Block() {
    fetchAllItems();
  }
  var url =
      'https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1';
  Stream get itemsStream => _allItems.stream;

  fetchAllItems() async {
    try {
      var response = await http.get(url);
      // _allItems.sink.close();
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        print(json['items'].length);
        return _allItems.sink.add(List.generate(json['items'].length,
            (index) => ItemsModel.fromJson(json['items'][index])));
      }
      if (response.statusCode == 404) {
        return _allItems.close();
      }
      if (response.statusCode == 401) {
        return _allItems.close();
      }
    } catch (e) {
      return _allItems.sink.close();
    }
  }

  void dispose() {
    _allItems.close();
  }
}
