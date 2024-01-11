import 'package:equatable/equatable.dart';

import '../../model/home_model.dart';

enum HomeStatus { initial, loading, success, error }

extension EnquiryX on HomeStatus {
  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSucess => this == HomeStatus.success;
  bool get isError => this == HomeStatus.error;
}

class HomeState extends Equatable {
  const HomeState(
      {this.status = HomeStatus.initial, this.message, this.data = const []});
  final HomeStatus status;
  final String? message;
  final List<Datum> data;

  @override
  List<Object?> get props => [status, message, data];

  HomeState copyWith(
      {HomeStatus? newStatus,
      String? updatemessage,
      List<Datum>? updatedData}) {
    return HomeState(
        status: newStatus ?? status,
        message: updatemessage ?? message,
        data: updatedData ?? data);
  }
}
