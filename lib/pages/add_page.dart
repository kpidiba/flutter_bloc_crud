import 'package:bloccrud_muhammedessa/blocs/post/post_bloc.dart';
import 'package:bloccrud_muhammedessa/repository/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  final TextEditingController _userId = TextEditingController();
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
              title: const Text("ADD PAGE"),
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
                    controller: _userId,
                  ),
                  BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          if (_title.text.isNotEmpty &&
                              _body.text.isNotEmpty &&
                              _userId.text.isNotEmpty) {
                            context.read<PostBloc>().add(
                                  AddPostEvent(
                                      title: _title.text,
                                      body: _body.text,
                                      userId: int.parse(_userId.text)),
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("ADD Successfully")));
                            context.read<PostBloc>().add(LoadPostEvent());
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
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
