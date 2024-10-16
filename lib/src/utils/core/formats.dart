import 'package:intl/intl.dart';

extension DateParsers on DateTime {
  String formatDateToServer() => '$year-$month-$day';

  String formatStringByJson() =>'$year$month$day';

  String formatUI() => DateFormat('dd MMMM yyyy', 'es').format(this);

  String formatDate() =>DateFormat('dd/MM/yy').format(this);
  
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

extension StringParsers on String{
  DateTime convertToDatetime(){
    int year = int.tryParse(substring(0,4)) ?? 1990;
    int month = int.tryParse(substring(4,6)) ?? 1;
    int day = int.tryParse(substring(6,8)) ?? 1;
    return DateTime(year, month, day);
  } 
}