import 'package:hose_basket/Models/languages.dart';

class ChooseUs {
  final List<String> english;
  final List<String> arabic;
  final List<String> armenian;
  final List<String> russian;

  const ChooseUs({
    required this.english,
    required this.arabic,
    required this.armenian,
    required this.russian,
  });

  factory ChooseUs.fromMap(List<dynamic> data) {
    List<String> english = [], armenian = [], arabic = [], russian = [];

    for (Map<String, dynamic> element in data) {
      english.add(element['en'].toString());
      arabic.add(element['ar'].toString());
      armenian.add(element['arm'].toString());
      russian.add(element['ru'].toString());
    }

    return ChooseUs(
      english: english..sort((a, b) => _sort(a, b)),
      arabic: arabic..sort((a, b) => _sort(a, b)),
      armenian: armenian..sort((a, b) => _sort(a, b)),
      russian: russian..sort((a, b) => _sort(a, b)),
    );
  }

  List<String> adaptive(Languages languages) {
    switch (languages) {
      case Languages.English:
        return english;
      case Languages.Arabic:
        return arabic;
      case Languages.Armenian:
        return armenian;
      case Languages.Russian:
        return russian;
    }
  }

  static int _sort(String a, String b) {
    return a.length.compareTo(b.length);
  }
}
