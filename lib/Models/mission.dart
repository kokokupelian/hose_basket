import 'package:hose_basket/Models/languages.dart';

class Mission {
  final String english, arabic, armenian, russian;

  const Mission({
    required this.english,
    required this.arabic,
    required this.armenian,
    required this.russian,
  });

  factory Mission.fromMap(Map<String, dynamic> data) {
    return Mission(
      english: data["en"].toString(),
      arabic: data["ar"].toString(),
      armenian: data["arm"].toString(),
      russian: data["ru"].toString(),
    );
  }

  String adaptive(Languages languages) {
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
