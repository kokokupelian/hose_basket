import 'package:hose_basket/Models/languages.dart';

class StaticLanguages {
  static Map<Languages, String> About = {
    Languages.English: "About HoseBasket",
    Languages.Arabic: "HoseBasket حول",
    Languages.Armenian: "HoseBasket-ի մասին",
    Languages.Russian: "О HoseBasket"
  };

  static Map<Languages, String> ChooseUs = {
    Languages.English: "Why Choose Us",
    Languages.Arabic: "لماذا عليك اختيارنا",
    Languages.Armenian: "Ինչու՞ ընտրել մեզ",
    Languages.Russian: "почему выбрали нас"
  };

  static Map<Languages, String> Services = {
    Languages.English: "Our Services",
    Languages.Arabic: "خدماتنا",
    Languages.Armenian: "Մեր ծառայությունները",
    Languages.Russian: "Наши услуги"
  };

  static Map<Languages, String> Mission = {
    Languages.English: "Our Mission And Vision",
    Languages.Arabic: "مهمتنا ورؤيتنا",
    Languages.Armenian: "Մեր առաքելությունն ու տեսլականը",
    Languages.Russian: "Наша миссия и видение"
  };

  static Map<Languages, String> Product = {
    Languages.English: "Our Product",
    Languages.Arabic: "منتجاتنا",
    Languages.Armenian: "Մեր արտադրանքը",
    Languages.Russian: "Наши продукты"
  };
  static Map<Languages, String> Chat = {
    Languages.English: "Lets Chat",
    Languages.Arabic: "دعنا نتحدث",
    Languages.Armenian: "Արի զրուցենք",
    Languages.Russian: "Давай общаться"
  };

  static Map<Languages, String> ChatParagraph = {
    Languages.English:
        "Whether you have a question, want to start a project or simply want to connect.\n\nFeel free to send me a message in the contact form",
    Languages.Arabic:
        "سواء كان لديك سؤال أو تريد بدء مشروع أو ببساطة تواصل معنا.\n\nلا تتردد في إرسال رسالة من خلال النموذج التالي",
    Languages.Armenian:
        "Անկախ նրանից, թե դուք ունեք հարց, ցանկանում եք սկսել նախագիծ, թե պարզապես ցանկանում եք միանալ:\n\nԱզատորեն ինձ հաղորդագրություն ուղարկեք կոնտակտային ձևով",
    Languages.Russian:
        "Если у вас есть вопрос, вы хотите начать проект или просто хотите подключиться.\n\nНе стесняйтесь отправить мне сообщение в контактной форме"
  };

  static Map<Languages, String> ChatButton = {
    Languages.English: "Submit",
    Languages.Arabic: "إرسال",
    Languages.Armenian: "Ներկայացնել",
    Languages.Russian: "представлять на рассмотрение"
  };

  static Map<Languages, List<String>> ChatField = {
    Languages.English: ["Name", "Email", "Company", "Phone", "Message"],
    Languages.Arabic: [
      "الاسم",
      "البريد الالكتروني",
      "الشركة",
      "الهاتف",
      "الرسالة"
    ],
    Languages.Armenian: [
      "Անուն",
      "Փոստ",
      "Ընկերություն",
      "Հեռախոս",
      "Հաղորդագրություն"
    ],
    Languages.Russian: [
      "Имя",
      "Электронная почта",
      "Компания",
      "Телефон",
      "Сообщение"
    ],
  };

  static Map<Languages, String> AllProducts = {
    Languages.English: "All Products",
    Languages.Arabic: "جميع المنتجات",
    Languages.Armenian: "Բոլոր ապրանքները",
    Languages.Russian: "Все продукты",
  };
}
