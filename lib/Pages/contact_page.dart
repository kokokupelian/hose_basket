import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hose_basket/Data/data.dart';
import 'package:hose_basket/Data/staticLanguages.dart';
import 'package:hose_basket/Helpers/colors.dart';
import 'package:hose_basket/Models/languages.dart';
import 'package:hose_basket/Provider/main_page_provider.dart';
import 'package:hose_basket/Widgets/base_text_field.dart';
import 'package:hose_basket/Widgets/elevated_button_with_animation.dart';
import 'package:hose_basket/Widgets/social_media_tab.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController _name = TextEditingController(),
      _company = TextEditingController(),
      _phone = TextEditingController(),
      _email = TextEditingController(),
      _msg = TextEditingController();

  bool _isError = false;
  final ValueNotifier<ElevatedButtonAnimationState> _state =
      ValueNotifier(ElevatedButtonAnimationState.normal);

  late final MainPageProvider _mainPageProvider =
      Provider.of<MainPageProvider>(context, listen: true);

  _sendMessage() async {
    _state.value = ElevatedButtonAnimationState.loading;
    Map<String, dynamic> data = {
      "name": _name.text,
      "phone": _phone.text,
      "email": _email.text,
      "company": _company.text,
      "msg": _msg.text
    };

    if (await Data.SendMessage(data)) {
      _state.value = ElevatedButtonAnimationState.finished;
      Future.delayed(const Duration(seconds: 1))
          .then((value) => _state.value = ElevatedButtonAnimationState.normal);
    } else {
      _state.value = ElevatedButtonAnimationState.normal;
    }
    _name.clear();
    _email.clear();
    _company.clear();
    _msg.clear();
    _phone.clear();
  }

  @override
  void initState() {
    super.initState();
    _name.addListener(_clearError);
    _email.addListener(_clearError);
    _phone.addListener(_clearError);
  }

  void _clearError() {
    if (_isError) {
      setState(() {
        _isError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BackgroundColor(context),
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  StaticLanguages.Chat[_mainPageProvider.languages] ?? "",
                  style: TextStyle(
                    fontSize: 30,
                    color: AccentColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: AnimatedTextKit(
                  key: ValueKey<Languages>(_mainPageProvider.languages),
                  animatedTexts: [
                    TyperAnimatedText(
                      StaticLanguages
                              .ChatParagraph[_mainPageProvider.languages] ??
                          "",
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                  isRepeatingAnimation: false,
                  repeatForever: false,
                  totalRepeatCount: 1,
                ),
              ),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: BaseTextField(context,
                            controller: _name,
                            label: StaticLanguages
                                        .ChatField[_mainPageProvider.languages]
                                    ?[0] ??
                                "",
                            keyboardType: TextInputType.name,
                            textDirection:
                                _mainPageProvider.languages == Languages.Arabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            errorMessage: _isError ? "" : null),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: BaseTextField(context,
                            controller: _email,
                            label: StaticLanguages
                                        .ChatField[_mainPageProvider.languages]
                                    ?[1] ??
                                "",
                            keyboardType: TextInputType.emailAddress,
                            textDirection:
                                _mainPageProvider.languages == Languages.Arabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            errorMessage: _isError ? "" : null),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: BaseTextField(
                          context,
                          controller: _company,
                          textDirection:
                              _mainPageProvider.languages == Languages.Arabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                          label: StaticLanguages
                                  .ChatField[_mainPageProvider.languages]?[2] ??
                              "",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: BaseTextField(context,
                            controller: _phone,
                            label: StaticLanguages
                                        .ChatField[_mainPageProvider.languages]
                                    ?[3] ??
                                "",
                            keyboardType: TextInputType.phone,
                            textDirection:
                                _mainPageProvider.languages == Languages.Arabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            errorMessage: _isError ? "" : null),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: BaseTextField(
                          context,
                          maxlines: 3,
                          controller: _msg,
                          keyboardType: TextInputType.multiline,
                          textDirection:
                              _mainPageProvider.languages == Languages.Arabic
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                          label: StaticLanguages
                                  .ChatField[_mainPageProvider.languages]?[4] ??
                              "",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButtonWithAnimation(
                          onPressed: () {
                            if (_name.text.isEmpty ||
                                _email.text.isEmpty ||
                                _phone.text.isEmpty) {
                              setState(() {
                                _isError = true;
                              });
                            } else {
                              _sendMessage();
                            }
                          },
                          elevatedButtonAnimationState: _state,
                          text: StaticLanguages
                                  .ChatButton[_mainPageProvider.languages] ??
                              "",
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SocialMediaTab(),
            ],
          ),
        ),
      ),
    );
  }
}
