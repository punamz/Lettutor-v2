import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lettutor/config/api.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/config/enum_value.dart';
import 'package:lettutor/src/domain/model/booking.dart';
import 'package:lettutor/src/domain/model/course.dart';
import 'package:lettutor/src/domain/model/schedule.dart';
import 'package:lettutor/src/domain/model/tutor.dart';
import 'package:lettutor/src/domain/service/home_service.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';

class HomeRepository extends HomeService {
  Dio dio = Dio(BaseOptions(
    baseUrl: ApiEndPoint.baseUrl,
    contentType: ContentType.json.value,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    responseType: ResponseType.plain,
    validateStatus: (status) => (status ?? 0) < 500,
  ));

  Map<String, String> get header =>
      {'Authorization': 'Bearer ${Storage.instance.readString(Constant.jwtToken)}'};

  @override
  Future<Either<String, List<Booking>>> getBookedClass(
      {required bool isComing, int page = 1, int perPage = 20}) async {
    try {
      Map<String, dynamic> queryParameters = {
        'page': page,
        'perPage': perPage,
        'orderBy': 'meeting',
        'dateTimeGte': isComing ? DateTime.now().millisecondsSinceEpoch : null,
        'dateTimeLte': isComing ? null : DateTime.now().millisecondsSinceEpoch,
        'sortBy': isComing ? 'asc' : 'desc'
      };
      final response = await dio.get(
        ApiEndPoint.bookedClass,
        options: Options(headers: header),
        queryParameters: queryParameters,
      );
      var data = jsonDecode(response.data);
      return response.statusCode == 200
          ? Right(List<Booking>.from(data['data']['rows'].map((x) => Booking.fromJson(x))))
          : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, List<Tutor>>> getAllTutor(
      {required bool isFavorite, int page = 1, int perPage = 20}) async {
    try {
      Map<String, dynamic> queryParameters = {'page': page, 'perPage': perPage};
      final response = await dio.get(
        ApiEndPoint.getAllTutor,
        options: Options(headers: header),
        queryParameters: isFavorite ? {'perPage': 10000} : queryParameters,
      );
      var data = jsonDecode(response.data);
      if (response.statusCode == 200) {
        List<Tutor> tutorList =
            List<Tutor>.from(data['tutors']['rows'].map((x) => Tutor.fromJson(x)));
        List<String> favoriteTutor =
            List<String>.from(data['favoriteTutor'].map((x) => x['secondId']));
        tutorList.map((e) => e.isLike = favoriteTutor.contains(e.userId)).toList();
        return Right(
            isFavorite ? tutorList.where((element) => element.isLike == true).toList() : tutorList);
      } else {
        return Left(data['message']);
      }
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, List<Tutor>>> searchTutor(
      {required String name,
      required Specialty specialties,
      int page = 1,
      int perPage = 20}) async {
    try {
      Map<String, dynamic> param = {
        'page': page,
        'perPage': perPage,
        'search': name,
        "filters": {
          "specialties": [specialties.value]
        }
      };
      final response = await dio.post(
        ApiEndPoint.searchTutor,
        options: Options(headers: header),
        data: param,
      );
      var data = jsonDecode(response.data);
      return response.statusCode == 200
          ? Right(List<Tutor>.from(data['rows'].map((x) => Tutor.fromJson(x))))
          : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, bool>> addTutorToFavoriteList(String tutorId) async {
    try {
      final Map<String, dynamic> param = {"tutorId": tutorId};
      final response = await dio.post(
        ApiEndPoint.likeTutor,
        options: Options(headers: header),
        data: param,
      );
      var data = jsonDecode(response.data);
      return response.statusCode == 200 ? const Right(true) : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  //
  // void a(){
  //   Map<String, dynamic> params = {"avatar", ""}
  //   dio.post('',data: params)
  // }

  @override
  Future<Either<String, String>> bookAClass(
      {required String scheduleDetailId, required String note}) async {
    try {
      final Map<String, dynamic> param = {
        'scheduleDetailIds': [scheduleDetailId],
        'note': note,
      };
      final response = await dio.post(
        ApiEndPoint.booking,
        options: Options(headers: header),
        data: param,
      );
      var data = jsonDecode(response.data);
      return response.statusCode == 200 ? Right(data['message']) : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, bool>> cancelBookingClass(String scheduleDetailId) async {
    try {
      final Map<String, dynamic> param = {
        'scheduleDetailIds': [scheduleDetailId]
      };
      final response = await dio.delete(
        ApiEndPoint.booking,
        options: Options(headers: header),
        data: param,
      );
      var data = jsonDecode(response.data);
      return response.statusCode == 200 ? const Right(true) : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, List<Course>>> getAllCourses({int page = 1, int perPage = 20}) async {
    try {
      Map<String, dynamic> queryParameters = {'page': page, 'perPage': perPage};
      final response = await dio.get(
        ApiEndPoint.course,
        options: Options(headers: header),
        queryParameters: queryParameters,
      );
      var data = jsonDecode(response.data);
      return response.statusCode == 200
          ? Right(List<Course>.from(data['data']['rows'].map((x) => Course.fromJson(x))))
          : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, List<Schedule>>> getAllSchedule(String tutorId) async {
    try {
      DateTime now = DateTime.now();
      Map<String, dynamic> queryParameters = {
        'tutorId': tutorId,
        'startTimestamp': now.millisecondsSinceEpoch,
        'endTimestamp': now.add(const Duration(days: 7)).millisecondsSinceEpoch
      };
      final response = await dio.get(
        ApiEndPoint.schedule,
        options: Options(headers: header),
        queryParameters: queryParameters,
      );
      var data = jsonDecode(response.data);
      return response.statusCode == 200
          ? Right(List<Schedule>.from(data['scheduleOfTutor'].map((x) => Schedule.fromJson(x))))
          : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, String>> reportTutor(String tutorId, String content) async {
    try {
      final Map<String, dynamic> param = {'tutorId': tutorId, 'content': content};
      final response = await dio.post(
        ApiEndPoint.booking,
        options: Options(headers: header),
        data: param,
      );
      var data = jsonDecode(response.data);
      return response.statusCode == 200 ? Right(data['message']) : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, String>> uploadAvatar(String filePath, [String? fileName]) async {
    try {
      FormData formData =
          FormData.fromMap({'avatar': await MultipartFile.fromFile(filePath, filename: fileName)});
      final response = await dio.post(
        ApiEndPoint.uploadFile,
        options: Options(headers: header),
        data: formData,
      );

      var data = jsonDecode(response.data);
      return response.statusCode == 200 ? Right(data['avatar']) : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }

  @override
  Future<Either<String, String>> registerTutor(Map<String, dynamic> param, String videoPath,
      [String? videoName]) async {
    try {
      var formData = FormData()
        ..files.add(MapEntry('video', await MultipartFile.fromFile(videoPath, filename: videoName)))
        ..fields.addAll(param.entries.map((e) => MapEntry(e.key, e.value.toString())));
      final response = await dio.post(
        ApiEndPoint.registerTutor,
        options: Options(headers: header),
        data: formData,
      );

      var data = jsonDecode(response.data);
      return response.statusCode == 200 ? Right(data['avatar']) : Left(data['message']);
    } catch (e) {
      return const Left('It seems that the server is not reachable at the moment, try again later');
    }
  }
}
