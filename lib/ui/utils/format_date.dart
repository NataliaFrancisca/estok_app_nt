String tranformDate(DateTime date) {
  var month = date.month < 10 ? "0${date.month}" : date.month;
  var day = date.day < 10 ? "0${date.day}" : date.day;
  return "$day/$month/${date.year}";
}

DateTime tranformStringDate(String date){
  var arr = date.split('/').reversed.join('-');
  return DateTime.parse(arr).toLocal();
}

String removeTheUTC(String stringDate){
  return DateTime.parse(stringDate).toLocal().toString();
}
