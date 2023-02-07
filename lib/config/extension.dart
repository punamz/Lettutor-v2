import 'package:intl/intl.dart';

extension FormatString on String {
  String parseVietnamese() {
    String str = this;
    str = str.replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a');
    str = str.replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e');
    str = str.replaceAll(RegExp(r'[ìíịỉĩ]'), 'i');
    str = str.replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o');
    str = str.replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u');
    str = str.replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y');
    str = str.replaceAll(RegExp(r'đ'), 'd');
    return str;
  }
}

extension FormatDateTime on DateTime? {
  String format(String newPattern) {
    return this == null ? '' : DateFormat(newPattern).format(this!);
  }

  String formatDateAndTimeToString() {
    return this == null ? '' : DateFormat('HH:mm dd/MM/yyyy').format(this!);
  }

  String formatDateToString() {
    return this == null ? '' : DateFormat('dd/MM/yyyy').format(this!);
  }

  String formatWeekDay() {
    if (this == null) return '';
    int weekDay = this!.weekday;
    String weekDateConverted = weekDay < 7 ? 'T.${weekDay + 1}' : 'CN';
    return '$weekDateConverted, ${this!.day.toString().padLeft(2, '0')} Th ${this!.month.toString().padLeft(2, '0')}, ${this!.year}';
  }

  bool isSameDate(DateTime another) {
    if (this == null) return false;
    return this?.year == another.year && this?.month == another.month && this?.day == another.day;
  }
}

extension CheckData<T> on T {
  bool isNullOrEmpty() {
    return this == null || this == '' || this == 'null' || this == {} || this == ' ' ? true : false;
  }

  bool isNotNullEmpty() {
    return this == null || this == '' || this == 'null' || this == {} || this == ' ' ? false : true;
  }

  bool isListNotNullOrEmpty() {
    if (this != null && this is List && (this as List).isNotEmpty) return true;
    return false;
  }
}
