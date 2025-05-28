// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:setec_app/core/enums/roles.dart';
// import 'package:setec_app/model/models/speaker/speaker.dart';
// import 'package:setec_app/providers/auth_state_notifier.dart';
// import 'package:setec_app/ui/speaker/viewModel/speaker_view_model.dart';
// import 'package:setec_app/ui/utils/widgets/iconButton/save_button_widget.dart';
// import 'package:setec_app/ui/utils/widgets/switch/switch_field_widget.dart';
// import 'package:setec_app/ui/speaker/widgets/circle_avatar_widget.dart';
// import 'package:setec_app/ui/utils/widgets/Text/Field/text_field_widget.dart';

// class SpeakerProfileView extends ConsumerStatefulWidget {
//   const SpeakerProfileView({super.key, required this.user});

//   final dynamic user;

//   @override
//   ConsumerState<SpeakerProfileView> createState() => _SpeakerProfileView();
// }

// class _SpeakerProfileView extends ConsumerState<SpeakerProfileView> {
//   final nameControl = TextEditingController();
//   final emailControl = TextEditingController();
//   final roleControler = TextEditingController();
//   final relationshipControl = TextEditingController();
//   final raControl = TextEditingController();
//   final bioControl = TextEditingController();
//   final companyControl = TextEditingController();
//   final positionControl = TextEditingController();
//   late bool approvedState;

//   @override
//   void initState() {
//     nameControl.text = widget.user.user.name;
//     emailControl.text = widget.user.user.email;
//     roleControler.text = widget.user.user.role.displayName;
//     relationshipControl.text = widget.user.user.relationship.displayName;
//     raControl.text = widget.user.user.ra != null ? widget.user.user.ra! : '';
//     bioControl.text = widget.user.bio;
//     companyControl.text = widget.user.company;
//     positionControl.text = widget.user.position;

//     final isSpeaker = widget.user.user.role == Roles.speaker;

//     approvedState = isSpeaker ? widget.user.isApproved : false;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userApp = widget.user.user;
//     final width = MediaQuery.of(context).size.width;
//     final isStudent = userApp.ra != null;
//     final isSpeaker = userApp.role == Roles.speaker;
//     final isAdmin = ref.read(authProvider).isAdmin;
//     // String relationship = userApp.relationship.displayName;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Palestrante'),
//         centerTitle: true,
//         actions: <Widget>[
//           if (approvedState != widget.user.isApproved)
//             SaveButtonWidget(
//               parentContext: context,
//               onPressed: () async {
//                 ref.read(speakerViewModel.notifier).approveSpeaker(
//                     widget.user as Speaker, ref.read(authProvider).user.uid);
//               },
//             ),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//           child: Column(
//             children: <Widget>[
//               //? Avatar
//               CircleAvatarWidget(
//                 width: width,
//               ),
//               const SizedBox(height: 10),
//               // const SizedBox(height: 16),

//               //? Infos
//               Expanded(
//                 child: ListView(
//                   padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                   children: <Widget>[
//                     //? estado de aprovação
//                     isAdmin && isSpeaker
//                         ? Card(
//                             child: SizedBox(
//                               height: 88,
//                               child: SwitchFieldWidget(
//                                 width: 16,
//                                 text:
//                                     approvedState ? 'Aprovado' : 'Não aprovado',
//                                 value: approvedState,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     approvedState = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                           )
//                         : Container(),
//                     Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: <Widget>[
//                             TextFieldWidget(
//                               controller: nameControl,
//                               fieldName: 'Nome',
//                               enabled: false,
//                             ),
//                             TextFieldWidget(
//                               controller: emailControl,
//                               fieldName: 'Email',
//                               enabled: false,
//                             ),
//                             isStudent
//                                 ? TextFieldWidget(
//                                     fieldName: 'RA',
//                                     enabled: false,
//                                     controller: raControl,
//                                   )
//                                 : Container(),
//                             // DropdownFormWidget(
//                             //   label: 'Permissão',
//                             //   isRole: true,
//                             //   onChanged: (value) {
//                             //     setState(() {
//                             //       roleControler.text = value;
//                             //     });
//                             //   },
//                             // ),
//                             TextFieldWidget(
//                               fieldName: 'Permissão',
//                               enabled: false,
//                               controller: roleControler,
//                             ),
//                             // DropdownFormWidget(
//                             //   initialValue: relationship,
//                             //   label: 'Relação com a FATEC',
//                             //   onChanged: (value) {
//                             //     setState(() {
//                             //       relationship = value;
//                             //     });
//                             //   },
//                             // ),
//                             TextFieldWidget(
//                               fieldName: 'Relação com a FATEC',
//                               enabled: false,
//                               controller: relationshipControl,
//                             ),
//                             isSpeaker
//                                 ? Column(
//                                     children: <Widget>[
//                                       TextFieldWidget(
//                                         fieldName: 'Empresa',
//                                         enabled: false,
//                                         controller: companyControl,
//                                       ),
//                                       TextFieldWidget(
//                                         fieldName: 'Cargo',
//                                         enabled: false,
//                                         controller: positionControl,
//                                       ),
//                                       TextFieldWidget(
//                                         fieldName: 'Biografia',
//                                         enabled: false,
//                                         controller: bioControl,
//                                       ),
//                                     ],
//                                   )
//                                 : Container(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     nameControl.dispose();
//     emailControl.dispose();
//     raControl.dispose();
//     roleControler.dispose();
//     relationshipControl.dispose();
//     bioControl.dispose();
//     companyControl.dispose();
//     positionControl.dispose();
//     super.dispose();
//   }
// }
