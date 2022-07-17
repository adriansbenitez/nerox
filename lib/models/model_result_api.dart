import 'package:listar_flutter_pro/models/model.dart';

class ResultApiModel {
  final bool success;
  final dynamic data;
  final dynamic attr;
  final dynamic payment;
  final PaginationModel? pagination;
  final UserModel? user;
  final String message;

  ResultApiModel({
    required this.success,
    required this.message,
    this.data,
    this.pagination,
    this.attr,
    this.payment,
    this.user,
  });

  factory ResultApiModel.fromJson(Map<String, dynamic> json) {
    UserModel? user;
    PaginationModel? pagination;
    String message = 'Unknown';
    bool isSuccess = true;

    if (json['message'] == null) {
      user = UserModel.fromJson(json);
      message = "save_data_success";
    } else {
      isSuccess = json['success']?? false;
    }

    if (json['pagination'] != null) {
      pagination = PaginationModel.fromJson(json['pagination']);
    }

    return ResultApiModel(
      success: isSuccess,
      data: json['data'],
      pagination: pagination,
      attr: json['attr'],
      payment: json['payment'],
      user: user,
      message: json['message'] ?? json['msg'] ?? message,
    );
  }
}
