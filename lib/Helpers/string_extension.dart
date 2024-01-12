extension DeFormat on String {
  List<String> deFormat() {
    String seperator = "•";
    String slashes = "\\r\\n";

    var text = replaceAll(slashes, "").trim();
    return text.split(seperator).sublist(1);
  }
}
