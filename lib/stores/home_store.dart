import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../models/post_model.dart';
import '../pages/detail_page.dart';
import '../services/http_service.dart';



part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable List<Post> items = [];
  @observable bool isLoading = false;

  void apiPostList(BuildContext context) async {
    isLoading = true;
    String? response =
    await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items = Network.parsePostList(response);
    } else {
      items = [];
    }
    isLoading = false;

  }

  void apiPostDelete(BuildContext context, Post post) async {
    isLoading = true;
    String? response = await Network.DEL(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    if (response != null) {
      apiPostList(context);
    }
    // apiPostList();
    isLoading = false;
  }

  void goToDetailPage(context) async {
    String? response =
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const DetailPage(
        state: DetailState.create,
      );
    }));
    if (response == "add") {
      apiPostList(context);
    }
  }

  void goToDetailPageUpdate(Post post, context) async {
    String? response =
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailPage(
        post: post,
        state: DetailState.update,
      );
    }));
    if (response == "refresh") {
      apiPostList(context);
    }
  }
}