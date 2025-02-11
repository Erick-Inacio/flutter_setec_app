import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:setec_app/models/speaker_model.dart';
import 'package:setec_app/models/user_app_model.dart';
import 'package:setec_app/services/backend/speaker_service.dart';
import 'package:setec_app/widgets/Text/FormField/speaker_form_field.dart';
import 'package:setec_app/widgets/iconButton/save.dart';

class CreateSpeaker extends StatefulWidget {
  final UserApp userApp;

  const CreateSpeaker({super.key, required this.userApp});

  @override
  State<CreateSpeaker> createState() => _CreateSpeakerState();
}

class _CreateSpeakerState extends State<CreateSpeaker> {
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
                      await createSpeaker(true);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    } on Exception catch (e) {
                      Logger().e('CreateSpeaker: $e');
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

  Future<void> createSpeaker(createSpeaker) async {
    Speaker speaker = Speaker(
      userApp: widget.userApp.id as int,
      company: companyController.text,
      position: positionController.text,
      bio: bioController.text,
      socialMedia: {},
    );

    await SpeakerService.createSpeaker(speaker);
  }
}
