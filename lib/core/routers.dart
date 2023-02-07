import 'package:get/get.dart';
import 'package:lettutor/src/presentation/page/advance_setting/advance_setting_ctrl.dart';
import 'package:lettutor/src/presentation/page/advance_setting/advance_setting_view.dart';
import 'package:lettutor/src/presentation/page/booking_history/booking_history_ctrl.dart';
import 'package:lettutor/src/presentation/page/booking_history/booking_history_view.dart';
import 'package:lettutor/src/presentation/page/call/call_ctrl.dart';
import 'package:lettutor/src/presentation/page/call/call_view.dart';
import 'package:lettutor/src/presentation/page/course/course_ctrl.dart';
import 'package:lettutor/src/presentation/page/course/course_view.dart';
import 'package:lettutor/src/presentation/page/course_detail/course_detail_ctrl.dart';
import 'package:lettutor/src/presentation/page/course_detail/course_detail_view.dart';
import 'package:lettutor/src/presentation/page/feedback/feedback_ctrl.dart';
import 'package:lettutor/src/presentation/page/feedback/feedback_view.dart';
import 'package:lettutor/src/presentation/page/forgot_password/forgot_password_ctrl.dart';
import 'package:lettutor/src/presentation/page/forgot_password/forgot_password_view.dart';
import 'package:lettutor/src/presentation/page/home/home_ctrl.dart';
import 'package:lettutor/src/presentation/page/home/home_view.dart';
import 'package:lettutor/src/presentation/page/landing/landing_ctrl.dart';
import 'package:lettutor/src/presentation/page/landing/landing_view.dart';
import 'package:lettutor/src/presentation/page/login/login_ctrl.dart';
import 'package:lettutor/src/presentation/page/login/login_view.dart';
import 'package:lettutor/src/presentation/page/profile/profile_ctrl.dart';
import 'package:lettutor/src/presentation/page/profile/profile_view.dart';
import 'package:lettutor/src/presentation/page/register_tutor/register_tutor_ctrl.dart';
import 'package:lettutor/src/presentation/page/register_tutor/register_tutor_view.dart';
import 'package:lettutor/src/presentation/page/session_history/session_history_ctrl.dart';
import 'package:lettutor/src/presentation/page/session_history/session_history_view.dart';
import 'package:lettutor/src/presentation/page/setting/setting_ctrl.dart';
import 'package:lettutor/src/presentation/page/setting/setting_view.dart';
import 'package:lettutor/src/presentation/page/sign_up/sign_up_ctrl.dart';
import 'package:lettutor/src/presentation/page/sign_up/sign_up_view.dart';
import 'package:lettutor/src/presentation/page/topic/topic_ctrl.dart';
import 'package:lettutor/src/presentation/page/topic/topic_view.dart';
import 'package:lettutor/src/presentation/page/tutor/tutor_ctrl.dart';
import 'package:lettutor/src/presentation/page/tutor/tutor_view.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/tutor_detail_ctrl.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/tutor_detail_view.dart';
import 'package:lettutor/src/presentation/page/upcoming/upcoming_ctrl.dart';
import 'package:lettutor/src/presentation/page/upcoming/upcoming_view.dart';

List<GetPage> routers = [
  GetPage(
    name: LoginView.routeName,
    page: () => const LoginView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<LoginController>(() => LoginController());
    }),
  ),
  GetPage(
    name: SignUpView.routeName,
    page: () => const SignUpView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<SignUpController>(() => SignUpController());
    }),
  ),
  GetPage(
    name: ForgotPasswordView.routeName,
    page: () => const ForgotPasswordView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
    }),
  ),
  GetPage(
    name: LandingView.routeName,
    page: () => const LandingView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<LandingController>(() => LandingController());
      Get.lazyPut<HomeController>(() => HomeController());
      Get.lazyPut<UpcomingController>(() => UpcomingController());
      Get.lazyPut<TutorController>(() => TutorController());
      Get.lazyPut<SettingController>(() => SettingController());
      Get.lazyPut<CourseController>(() => CourseController());
    }),
  ),
  GetPage(
    name: HomeView.routeName,
    page: () => const HomeView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<HomeController>(() => HomeController());
    }),
  ),
  GetPage(
    name: UpcomingView.routeName,
    page: () => const UpcomingView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<UpcomingController>(() => UpcomingController());
    }),
  ),
  GetPage(
    name: TutorView.routeName,
    page: () => const TutorView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<TutorController>(() => TutorController());
    }),
  ),
  GetPage(
    name: SettingView.routeName,
    page: () => const SettingView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<SettingController>(() => SettingController());
    }),
  ),
  GetPage(
    name: CourseView.routeName,
    page: () => const CourseView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<CourseController>(() => CourseController());
    }),
  ),
  GetPage(
    name: TutorDetailView.routeName,
    page: () => const TutorDetailView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<TutorDetailController>(() => TutorDetailController());
    }),
  ),
  GetPage(
    name: CourseDetailView.routeName,
    page: () => const CourseDetailView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<CourseDetailController>(() => CourseDetailController());
    }),
  ),
  GetPage(
    name: CallView.routeName,
    page: () => const CallView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<CallController>(() => CallController());
    }),
  ),
  GetPage(
    name: TopicView.routeName,
    page: () => const TopicView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<TopicController>(() => TopicController());
    }),
  ),
  GetPage(
    name: ProfileView.routeName,
    page: () => const ProfileView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<ProfileController>(() => ProfileController());
    }),
  ),
  GetPage(
    name: FeedbackView.routeName,
    page: () => const FeedbackView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<FeedbackController>(() => FeedbackController());
    }),
  ),
  GetPage(
    name: BookingHistoryView.routeName,
    page: () => const BookingHistoryView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<BookingHistoryController>(() => BookingHistoryController());
    }),
  ),
  GetPage(
    name: SessionHistoryView.routeName,
    page: () => const SessionHistoryView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<SessionHistoryController>(() => SessionHistoryController());
    }),
  ),
  GetPage(
    name: AdvanceSettingView.routeName,
    page: () => const AdvanceSettingView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<AdvanceSettingController>(() => AdvanceSettingController());
    }),
  ),
  GetPage(
    name: RegisterTutorView.routeName,
    page: () => const RegisterTutorView(),
    binding: BindingsBuilder(() {
      Get.lazyPut<RegisterTutorController>(() => RegisterTutorController());
    }),
  ),
];
