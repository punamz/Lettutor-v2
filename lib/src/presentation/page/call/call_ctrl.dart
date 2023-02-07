import 'package:get/get.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:lettutor/config/api.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/src/domain/model/booking.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';

class CallController extends GetxController {
  final Booking booking = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    _initJitsi();
  }

  Future _initJitsi() async {
    String room = '${Storage.instance.readString(Constant.userId)}-${booking.tutorId}';

    JitsiMeetingOptions options = JitsiMeetingOptions(
        roomNameOrUrl: room,
        serverUrl: ApiEndPoint.serverJitsiUrl,
        token: booking.studentMeetingLink?.split('?token=').last);
    JitsiMeetingResponse a = await JitsiMeetWrapper.joinMeeting(options: options);

    if (a.isSuccess) {
      Get.back();
    }
  }
}
