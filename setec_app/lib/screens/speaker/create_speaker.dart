// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:logger/logger.dart';
// import 'package:provider/provider.dart';
// import 'package:setec_app/models/auth_provider_model.dart';
// import 'package:setec_app/models/speaker_model.dart';
// import 'package:setec_app/services/backend/speaker_service.dart';
// import 'package:setec_app/services/backend/speaker_services.dart';
// import 'package:setec_app/widgets/Text/FormField/speaker_form_field.dart';
// import 'package:setec_app/widgets/iconButton/save.dart';

// class InfoSpeaker extends StatefulWidget {
//   final BuildContext parentContext;

//   const InfoSpeaker({super.key, required this.parentContext});

//   @override
//   State<InfoSpeaker> createState() => _InfoSpeakerState();
// }

// class _InfoSpeakerState extends State<InfoSpeaker> {
//   late MainProvider mainProvider;
//   final formKey = GlobalKey<FormState>();


//   final companyController = TextEditingController();
//   final positionController = TextEditingController();
//   final bioController = TextEditingController();

//   bool _isTextChanged = false;

//   void _onFormChanged(bool isChanged) {
//     setState(() {
//       _isTextChanged = isChanged;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     mainProvider = widget.parentContext.watch<MainProvider>();
//   }

//   @override
//   void dispose() {
//     companyController.dispose();
//     positionController.dispose();
//     bioController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:
//           AppBar(title: const Text("Infos do Palestrante"), actions: <Widget>[
//         _isTextChanged
//             ? SaveButtom(
//                 parentContext: context,
//                 onPressed: () async {
//                   if (formKey.currentState!.validate()) {
//                     try {
//                       await createSpeaker();
//                       if (context.mounted) {
//                         context.go('/lectures');
//                       }
//                     } on Exception catch (e) {
//                       Logger().e('InfoSpeaker: $e');
//                     }
//                   }
//                 })
//             : Container(),
//       ]),
//       body: Form(
//         key: formKey,
//         child: Center(
//           child: FormSpeakerField(
//             onChanged: _onFormChanged,
//             company: companyController,
//             position: positionController,
//             bio: bioController,
//             parentContext: context,
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> createSpeaker() async {
//     Speaker speaker = Speaker(
//       user: mainProvider.actualUser!.user,
//       company: companyController.text,
//       position: positionController.text,
//       bio: bioController.text,
//       socialMedia: {},
//     );

//     Logger().i('InfoSpeaker: $createSpeaker');

//     await SpeakerServices.createSpeaker(speaker);
//   }
// }
