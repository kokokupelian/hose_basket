import 'package:hose_basket/Helpers/string_extension.dart';
import 'package:hose_basket/Models/languages.dart';

class About {
  final List<String> english, arabic, armenian, russian;

  const About({
    required this.english,
    required this.arabic,
    required this.armenian,
    required this.russian,
  });

  factory About.fromMap(Map<String, dynamic> data) {
    return About(
      english: data["en"].toString().deFormat(),
      arabic: data["ar"].toString().deFormat(),
      armenian: data["arm"].toString().deFormat(),
      russian: data["ru"].toString().deFormat(),
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

  @override
  String toString() {
    return english.join(" ");
  }
}
