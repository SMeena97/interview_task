// lib/screens/search_screen.dart

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:interview_task/bloc/search_bloc/search_bloc.dart';
import 'package:interview_task/utiles/extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'image_viewer.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchBloc = SearchBloc();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchBloc,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SmartRefresher(
              controller: searchBloc.refreshController,
              enablePullUp: true,
              enablePullDown: true,
              onLoading: () {
                var page = state.currentPage + 1;
                searchBloc
                    .add(OnLoad(query: _searchController.text, page: page));
              },
              onRefresh: () async {
                searchBloc.add(OnRefresh(query: _searchController.text));
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(top: 2.hp, bottom: 2.hp),
                        height: 6.hp,
                        child: TextField(
                          controller: _searchController,
                          onChanged: (query) {
                            searchBloc.add(PerformSearch(
                                query: _searchController.text, page: 1));
                          },
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.8),
                            ),
                            contentPadding:
                                EdgeInsets.only(top: 2.hp, left: 4.wp),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                searchBloc.add(PerformSearch(
                                    query: _searchController.text, page: 1));
                              },
                            ),
                            border: const OutlineInputBorder(),
                            hintText: 'Search Keywords...',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              childAspectRatio: 1.1),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final searchModel = state.searchResults[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(ImageViewer(
                                imgUrl: searchModel.imageUrl,
                                name: searchModel.collectionName,
                              ));
                            },
                            child: GridTile(
                              footer: GridTileBar(
                                backgroundColor: Colors.black54,
                                title: Text(searchModel.name),
                                subtitle: Text(searchModel.collectionName),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: searchModel.imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          );
                        },
                        childCount: state.searchResults.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    searchBloc.add(PerformSearch(query: _searchController.text, page: 1));
  }

  Future<void> onclear() async {
    searchBloc.add(ClearSearch());
  }
}
