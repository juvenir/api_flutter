import 'package:flutter/material.dart';
import 'package:flutter_api/controllers/api_controller.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PostController _postController = PostController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: Listenable.merge(
                      [_postController.posts, _postController.inLoader]),
                  builder: (
                    _,
                    __,
                  ) =>
                      _postController.inLoader.value
                          ? CircularProgressIndicator()
                          : Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _postController.posts.value.length,
                                itemBuilder: (_, idx) => ListTile(
                                  title: Text(
                                    _postController.posts.value[idx].title,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _postController.callAPI();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
