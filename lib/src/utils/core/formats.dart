
extension DateParsers on DateTime {
  String formatDateToServer() => '$year-$month-$day';
}

extension DoubleParsers on double{
  String formatImporte() {
    int intValue =  toInt();
    if( this - intValue == 0 ){
      return intValue.toString();
    }else{
      return toStringAsFixed(2);
    }
  }
}