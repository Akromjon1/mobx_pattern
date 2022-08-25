import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/post_model.dart';
import '../stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var store = HomeStore();

  @override
  void initState() {
    super.initState();
    store.apiPostList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pattern MobX"),
      ),
      body: Observer(
        builder: (context) {
          return Stack(
            children: [
              ListView.builder(
                  itemCount: store.items.length,
                  itemBuilder: (context, index) {
                    return itemsOfPost(store.items[index]);
                  }),
              Visibility(
                visible: store.isLoading,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          store.goToDetailPage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemsOfPost(Post post) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        extentRatio: 0.5,
        dismissible: DismissiblePane(onDismissed: () {
          store.apiPostDelete(context, post);
        }),
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              store.apiPostDelete(context, post);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
          ),
          SlidableAction(
            onPressed: (context) {
              store.goToDetailPageUpdate(post, context);
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.update,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Text(
              post.title.toUpperCase(),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              post.body,
              style: const TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
