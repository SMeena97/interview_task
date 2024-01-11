import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:interview_task/bloc/home_bloc/home_bloc.dart';
import 'package:interview_task/utiles/extension.dart';
import 'package:interview_task/view/component/item_division.dart';

import '../bloc/home_bloc/home_state.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(GetHomeEvent()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status.isError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message ?? 'Something went wrong!')));
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return DefaultTabController(
              length: 5,
              child: Scaffold(
                  body: Container(
                margin: EdgeInsets.symmetric(horizontal: 3.2.wp),
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(SearchScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 6.hp, bottom: 2.hp),
                      padding: EdgeInsets.only(right: 2.wp, left: 2.wp),
                      height: 6.hp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Search Keywords..."),
                          Icon(
                            Icons.search_sharp,
                            size: 8.wp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    indicatorWeight: 2,
                    indicatorColor: Color(0xff7ae6c6),
                    labelColor: Colors.black,
                    tabs: [
                      Tab(text: "All"),
                      Tab(
                        text: "Animals",
                      ),
                      Tab(text: "Birds"),
                      Tab(text: "Flowers"),
                      Tab(text: "Mountains"),
                    ],
                  ),
                  state.status.isLoading
                      ? Container(
                          margin: EdgeInsets.only(top: 6.hp),
                          child: const CircularProgressIndicator(),
                        )
                      : state.status.isSucess && state.data.length >= 5
                          ? SizedBox(
                              height: 80.hp,
                              child: TabBarView(
                                children: [
                                  ItemDivision(data: state.data[0].subData),
                                  ItemDivision(data: state.data[1].subData),
                                  ItemDivision(data: state.data[2].subData),
                                  ItemDivision(data: state.data[3].subData),
                                  ItemDivision(data: state.data[4].subData),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 6.hp),
                              child: Text(
                                  state.message ?? 'Something went wrong!'),
                            ),
                ]),
              )),
            );
          },
        ),
      ),
    );
  }
}
