import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/speaker_service.dart';
import 'package:setec_app/widgets/Text/FormField/speaker_form_field.dart';
import 'package:setec_app/widgets/iconButton/save.dart';

class InfoSpeaker extends StatefulWidget {
  final UserApp userApp;

  const InfoSpeaker({super.key, required this.userApp});

  @override
  State<InfoSpeaker> createState() => _InfoSpeakerState();
}

class _InfoSpeakerState extends State<InfoSpeaker> {
  final formKey = GlobalKey<FormState>();

  final companyController = TextEditingController();
  final positionController = TextEditingController();
  final bioController = TextEditingController();

  bool _isTextChanged = false;

  void _onFormChanged(bool isChanged) {
    setState(() {
      _isTextChanged = isChanged;
    });
  }

  @override
  void dispose() {
    companyController.dispose();
    positionController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Infos do Palestrante"), actions: <Widget>[
        _isTextChanged
            ? SaveButtom(
                parentContext: context,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await createSpeaker();
                      if (context.mounted) {
                        context.go('/home');
                      }
                    } on Exception catch (e) {
                      Logger().e('InfoSpeaker: $e');
                    }
                  }
                })
            : Container(),
      ]),
      body: Center(
        child: FormSpeakerField(
          onChanged: _onFormChanged,
          company: companyController,
          position: positionController,
          bio: bioController,
          formKey: formKey,
          userApp: widget.userApp,
        ),
      ),
    );
  }

  Future<void> createSpeaker() async {
    Speaker speaker = Speaker(
      user: widget.userApp,
      company: companyController.text,
      position: positionController.text,
      bio: bioController.text,
      socialMedia: {},
    );

    Logger().i('InfoSpeaker: $createSpeaker');

    await SpeakerService.createSpeaker(speaker);
  }
}
