import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_task/model/home_model.dart';
import '../../service/service.dart';
import 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<GetHomeEvent>(_getHomeEventToState);
  }

  void _getHomeEventToState(GetHomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(newStatus: HomeStatus.loading));
    final response = await ApiService.getItems();
    if (response != null) {
      String message = json.decode(response.body)["message"];
      if (response.statusCode == 200) {
        emit(state.copyWith(
            newStatus: HomeStatus.success,
            updatemessage: message,
            updatedData: homeModelFromJson(response.body).data));
      } else {
        emit(state.copyWith(
            newStatus: HomeStatus.error, updatemessage: message));
      }
    }
  }
}
