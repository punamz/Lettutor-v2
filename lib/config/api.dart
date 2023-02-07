class ApiEndPoint {
  static const String baseUrl = 'https://sandbox.api.lettutor.com/';

  ///
  /// Authentication
  ///
  static const String login = 'auth/login';
  static const String forgotPassword = 'user/forgotPassword';
  static const String register = 'auth/register';
  static const String updateProfile = 'user/info';

  /// User
  static const String uploadFile = 'user/uploadAvatar';

  ///
  /// tutor
  ///
  static const String getAllTutor = 'tutor/more';
  static const String searchTutor = 'tutor/search';
  static const String likeTutor = 'user/manageFavoriteTutor';
  static const String reportTutor = 'report';
  static const String registerTutor = 'tutor/register';

  ///
  /// schedule
  ///
  static const String booking = 'booking';
  static const String bookedClass = 'booking/list/student';
  static const String schedule = "schedule";

  ///
  /// course
  ///
  static const String course = "course";

  ///
  /// Jitsi
  ///
  static const String serverJitsiUrl = 'https://meet.lettutor.com';
}
