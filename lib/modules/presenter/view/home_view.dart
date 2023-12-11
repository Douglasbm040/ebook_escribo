import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../domain/entity/book_entity.dart';
import '../../domain/usecases/request_book_usecase.dart';
import '../../external/datasource/http_datasource.dart';
import '../../infra/repositories/resquest_book_repository_impl.dart';
/*
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<BookEntity>>(
            future: usecase.call("/books.json").then((value) => value.fold(
                (l) => [
                      BookEntity(
                          id: 0,
                          title: "",
                          author: "",
                          coverUrl: "",
                          downloadUrl: "",
                          favorite: 1
                          )
                    ],
                (r) => r)),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Text('Item ${snapshot.data?.length}');
            }),
      ),
    );
  }
}
*/