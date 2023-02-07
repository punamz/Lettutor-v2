import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lettutor/config/api.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/src/domain/model/auth.dart';
import 'package:lettutor/src/domain/service/authentication_service.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';

class AuthenticationRepository implements AuthenticationService {
  Dio dio = Dio(BaseOptions(
    baseUrl: ApiEndPoint.baseUrl,
    contentType: ContentType.json.value,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    responseType: ResponseType.plain,
    validateStatus: (status) => (status ?? 0) <= 500,
  ));

  @override
  Future<Either<String, Auth>> login(Map<String, dynamic> param) async {
    try {
      final response = await dio.post(ApiEndPoint.login, data: param);
      var data = jsonDecode(response.data);
      return response.statusCode == 200 ? Right(Auth.fromJson(data)) : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, String>> forgotPassword(Map<String, dynamic> param) async {
    try {
      final response = await dio.post(ApiEndPoint.forgotPassword, data: param);
      var data = jsonDecode(response.data);
      return response.statusCode == 200 ? Right(data['message']) : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, Auth>> register(Map<String, dynamic> param) async {
    try {
      final response = await dio.post(ApiEndPoint.register, data: param);
      Map<String, dynamic> data = jsonDecode(response.data);
      return response.statusCode == 201 ? Right(Auth.fromJson(data)) : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, bool>> updateProfile(Map<String, dynamic> param) async {
    try {
      final response = await dio.put(
        ApiEndPoint.updateProfile,
        options: Options(
            headers: {'Authorization': 'Bearer ${Storage.instance.readString(Constant.jwtToken)}'}),
        data: param,
      );
      var data = jsonDecode(response.data);
      return response.statusCode == 200 ? const Right(true) : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }
}
