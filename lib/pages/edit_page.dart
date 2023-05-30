import 'package:bloccrud_muhammedessa/blocs/post/post_bloc.dart';
import 'package:bloccrud_muhammedessa/repository/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/postmodel.dart';

class EditPostPage extends StatefulWidget {
  final String id;
  const EditPostPage({super.key, required this.id});

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  final TextEditingController _userId = TextEditingController();
  String postId = '';

  @override
  void initState() {
    postId = widget.id.toString();
    super.initState();
    PostRepository().getPostById(int.parse(postId)).then((value) {
      _title.value = TextEditingValue(text: value.title.toString());
      _body.value = TextEditingValue(text: value.body.toString());
      _userId.value = TextEditingValue(text: value.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => PostBloc(PostRepository()),
          ),
        ],
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("UPDATE PAGE"),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle))
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const Text(
                    'title',
                    style: TextStyle(fontSize: 12),
                  ),
                  TextFormField(
                    controller: _title,
                  ),
                  const Text(
                    'body',
                    style: TextStyle(fontSize: 12),
                  ),
                  TextFormField(
                    controller: _body,
                  ),
                  const Text(
                    'userId',
                    style: TextStyle(fontSize: 12),
                  ),
                  TextFormField(
                    enabled: false,
                    controller: _userId,
                  ),
                  BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          if (_title.text.isNotEmpty &&
                              _body.text.isNotEmpty &&
                              _userId.text.isNotEmpty) {
                            context.read<PostBloc>().add(
                                  UpdatePostEvent(
                                      post: PostModel(
                                          id: int.parse(_userId.toString()),
                                          title: _title.toString(),
                                          body: _body.toString())),
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Duration(seconds: 3),
                                    content: Text("ADD Successfully")));
                            context.read<PostBloc>().add(LoadPostEvent());
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Duration(seconds: 3),
                                    content: Text("Field  required")));
                            context.read<PostBloc>().add(LoadPostEvent());
                          }
                        },
                        child: const Text("ADD POST"));
                  })
                ],
              ),
            ),
          ),
        ));
  }
}
