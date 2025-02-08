import 'package:flutter/material.dart';
import 'package:setec_app/models/user_app_model.dart';
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
                // onSave: () async {
                //   formKey.currentState!.save();

                //   try{}
                // },
              )
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
}
