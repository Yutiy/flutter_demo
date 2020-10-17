class DateUtils {
  static final double millisLimit = 1000.0;

  static final double secondsLimit = 60 * millisLimit;

  static final double minutesLimit = 60 * secondsLimit;

  static final double hoursLimit = 24 * minutesLimit;

  static final double daysLimit = 30 * hoursLimit;

  static double staticBarHeight = 0.0;

  static String getDateStr(DateTime date) {
    if (date == null || date.toString() == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }

  /// 日期格式转换
  static String getNewsTimeStr(DateTime date) {
    int subTime = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;

    if (subTime < millisLimit) {
      return "刚刚";
    } else if (subTime < secondsLimit) {
      return (subTime / millisLimit).round().toString() + " 秒前";
    } else if (subTime < minutesLimit) {
      return (subTime / secondsLimit).round().toString() + " 分钟前";
    } else if (subTime < hoursLimit) {
      return (subTime / minutesLimit).round().toString() + " 小时前";
    } else if (subTime < daysLimit) {
      return (subTime / hoursLimit).round().toString() + " 天前";
    } else {
      return getDateStr(date);
    }
  }
}