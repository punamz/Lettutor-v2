import 'package:dartz/dartz.dart';
import 'package:lettutor/src/domain/model/auth.dart';

abstract class AuthenticationService {
  Future<Either<String, Auth>> login(Map<String, dynamic> param);
  Future<Either<String, String>> forgotPassword(Map<String, dynamic> param);
  Future<Either<String, Auth>> register(Map<String, dynamic> param);
  Future<Either<String, bool>> updateProfile(Map<String, dynamic> param);
}
