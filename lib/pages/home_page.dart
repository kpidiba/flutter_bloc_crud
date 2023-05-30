import 'package:bloccrud_muhammedessa/blocs/post/post_bloc.dart';
import 'package:bloccrud_muhammedessa/models/postmodel.dart';
import 'package:bloccrud_muhammedessa/pages/add_page.dart';
import 'package:bloccrud_muhammedessa/pages/edit_page.dart';
import 'package:bloccrud_muhammedessa/repository/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => PostBloc(PostRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("POSTS"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPostPage(),
                      ));
                },
                icon: const Icon(Icons.add_circle)),
          ],
        ),
        body: BlocProvider(
          create: (context) => PostBloc(PostRepository())..add(LoadPostEvent()),
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PostLoadedState) {
                List<PostModel> posts = state.posts;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPostPage(
                                  id: posts[index].id.toString()))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 6),
                        child: Card(
                          color: Colors.yellow,
                          child: ListTile(
                              title: Text(
                                '${posts[index].title}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text('${posts[index].body}'),
                              leading: CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                child: Text('$index'),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  context.read<PostBloc>().add(
                                      DeletePostEvent(id: posts[index].id!));
                                },
                              )),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is PostErrorState) {
                return Center(
                    child: Column(
                  children: [
                    const Text(
                      'ERRORS',
                      style: TextStyle(color: Colors.red),
                    ),
                    IconButton(
                        onPressed: () {
                          context.read<PostBloc>().add(LoadPostEvent());
                        },
                        icon: const Icon(
                          Icons.refresh,
                          size: 40,
                          color: Colors.blue,
                        )),
                  ],
                ));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
