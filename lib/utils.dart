String formatRuntime(int runtime) {
  final hours = (runtime / 60).floor();
  final minutes = (runtime % 60);
  String result;
  hours > 0 ? result = "${hours}h ${minutes}min" : result = "${minutes}min";
  return result;
}
