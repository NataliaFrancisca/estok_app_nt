String tranformDate(DateTime date) {
  var month = date.month < 10 ? "0${date.month}" : date.month;
  return "${date.day}/$month/${date.year}";
}