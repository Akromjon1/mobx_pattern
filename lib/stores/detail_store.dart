import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../models/post_model.dart';
import '../pages/detail_page.dart';
import '../services/http_service.dart';



part 'detail_store.g.dart';

class DetailStore = _DetailStore with _$DetailStore;

abstract class _DetailStore with Store {
  @observable TextEditingController titleController = TextEditingController();
  @observable TextEditingController bodyController = TextEditingController();
  @observable bool isLoading = false;



  void updatePost(context) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    Post post = Post(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading = true;
    Network.PUT(Network.API_UPDATE, post.toJson()).then((value) {
      Navigator.pop(context, "refresh");
    });
    isLoading = false;
  }

  void addPage(context) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    Post post = Post(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading = true;
    Network.POST(Network.API_UPDATE, post.toJson()).then((value) {
      Navigator.pop(context, "add");
    });
    isLoading = false;
  }

}





