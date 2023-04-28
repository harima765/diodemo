import 'dart:convert';

import 'package:dioapidemo/repository/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScrollProvider with ChangeNotifier {
  List postList = [];

  int page = 0;

  final int increment = 10;

  bool isLoading = false;

  Future loadMore() async {
    isLoading = true;
    notifyListeners();

    final posts = await Repository.getData(page);
    postList.addAll(posts);
    page++;

    isLoading = false;
    notifyListeners();
  }
}
