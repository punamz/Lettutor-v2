import 'package:dartz/dartz.dart';
import 'package:lettutor/config/enum_value.dart';
import 'package:lettutor/src/domain/model/booking.dart';
import 'package:lettutor/src/domain/model/course.dart';
import 'package:lettutor/src/domain/model/schedule.dart';
import 'package:lettutor/src/domain/model/tutor.dart';

abstract class HomeService {
  Future<Either<String, List<Booking>>> getBookedClass(
      {required bool isComing, int page = 1, int perPage = 20});
  Future<Either<String, List<Tutor>>> getAllTutor(
      {required bool isFavorite, int page = 1, int perPage = 20});
  Future<Either<String, List<Tutor>>> searchTutor(
      {required String name, required Specialty specialties, int page = 1, int perPage = 20});
  Future<Either<String, bool>> addTutorToFavoriteList(String tutorId);
  Future<Either<String, String>> bookAClass(
      {required String scheduleDetailId, required String note});
  Future<Either<String, bool>> cancelBookingClass(String scheduleDetailId);
  Future<Either<String, List<Course>>> getAllCourses({int page = 1, int perPage = 20});
  Future<Either<String, List<Schedule>>> getAllSchedule(String tutorId);
  Future<Either<String, String>> reportTutor(String tutorId, String content);
  Future<Either<String, String>> uploadAvatar(String filePath, [String? fileName]);
  Future<Either<String, String>> registerTutor(Map<String, dynamic> param, String videoPath,
      [String? videoName]);
}
