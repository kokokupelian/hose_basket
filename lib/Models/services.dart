import 'package:hose_basket/Helpers/string_extension.dart';
import 'package:hose_basket/Models/languages.dart';

class Services {
  final List<String> english, arabic, armenian, russian;

  const Services({
    required this.english,
    required this.arabic,
    required this.armenian,
    required this.russian,
  });

  factory Services.fromMap(Map<String, dynamic> data) {
    return Services(
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
}
