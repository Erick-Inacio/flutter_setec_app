import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/enums/roles.dart';
import 'package:setec_app/core/interface/user_wrapper_interface.dart';
import 'package:setec_app/model/models/speaker/speaker.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';
import 'package:setec_app/ui/core/widgets/dropdown_form_widget.dart';
import 'package:setec_app/ui/utils/widgets/switch/switch_field_widget.dart';
import 'package:setec_app/ui/speaker/widgets/circle_avatar_widget.dart';
import 'package:setec_app/ui/utils/widgets/Text/Field/text_field_widget.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({
    super.key,
    required this.user,
    this.onSave,
    required this.width,
    this.editable = false,
    this.onCancel,
  });

  final UserWrapper user;
  final void Function(UserWrapper)? onSave;
  final double width;
  final bool editable;
  final VoidCallback? onCancel;

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final _formKey = GlobalKey<FormState>();

  final nameControl = TextEditingController();
  final emailControl = TextEditingController();
  final roleControler = TextEditingController();
  final relationshipControl = TextEditingController();
  final raControl = TextEditingController();
  final bioControl = TextEditingController();
  final companyControl = TextEditingController();
  final positionControl = TextEditingController();

  late bool approvedState;
  late bool isAdmin;
  late bool isSpeaker;

  late UserWrapper editedUser;

  @override
  void initState() {
    super.initState();
    isAdmin = ref.read(authProvider).isAdmin;
    editedUser = widget.user;
    isSpeaker = widget.user is Speaker;
    _initializeForm();
  }

  void _initializeForm() {
    final userApp = widget.user.user;

    nameControl.text = userApp.name;
    emailControl.text = userApp.email;
    roleControler.text = userApp.role.displayName;
    relationshipControl.text = userApp.relationship.displayName;
    raControl.text = userApp.ra ?? '';

    if (widget.user is Speaker) {
      final speaker = widget.user as Speaker;
      bioControl.text = speaker.bio;
      companyControl.text = speaker.company ?? '';
      positionControl.text = speaker.position;
      approvedState = speaker.isApproved ?? false;
    } else {
      approvedState = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userApp = widget.user.user;
    final isStudent = userApp.ra != null;
    final isSpeaker = widget.user is Speaker;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          setState(() {
            if (!widget.editable) {
              widget.onCancel?.call();
            } else if (_formKey.currentState!.validate()) {
              widget.editable ? _confirmAlertDialog() : null;
            }
          });
        },
        child: Icon(
          widget.editable ? Icons.save : Icons.edit,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CircleAvatarWidget(width: widget.width),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      if (isAdmin && isSpeaker)
                        _buildApprovalSwitch(),
                      _buildUserInfoCard(isStudent),
                      if (isSpeaker) _buildSpeakerInfoCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApprovalSwitch() {
    return Card(
      child: SizedBox(
        height: 88,
        child: SwitchFieldWidget(
          isEditable: widget.editable,
          width: 16,
          text: approvedState ? 'Aprovado' : 'Não aprovado',
          value: approvedState,
          onChanged: (value) {
            if (editedUser case Speaker speaker) {
              editedUser = speaker.copyWith(isApproved: value);
            }
            setState(() {
              approvedState = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(bool isStudent) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFieldWidget(
              controller: nameControl,
              fieldName: 'Nome',
              enabled: (isAdmin && widget.editable),
            ),
            TextFieldWidget(
              controller: emailControl,
              fieldName: 'Email',
              enabled: (isAdmin && widget.editable),
            ),
            if (isStudent)
              TextFieldWidget(
                controller: raControl,
                fieldName: 'RA',
                enabled: (isAdmin && widget.editable),
              ),
            DropdownFormWidget(
              values: Roles.values,
              enabled: isAdmin && widget.editable,
              label: 'Permissão',
              value: editedUser.user.role,
              displayText: (value) => value.displayName,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  editedUser = UserAppWrapper(
                    editedUser.user.copyWith(role: value),
                  );
                });
              },
            ),
            SizedBox(height: 10),
            DropdownFormWidget(
              values: Relationship.values,
              value: editedUser.user.relationship,
              enabled: isAdmin && widget.editable,
              displayText: (value) => value.displayName,
              label: 'Relacionamento',
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  editedUser = UserAppWrapper(
                    editedUser.user.copyWith(relationship: value),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeakerInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFieldWidget(
                controller: companyControl,
                fieldName: 'Empresa',
                enabled: widget.editable),
            TextFieldWidget(
                controller: positionControl,
                fieldName: 'Cargo',
                enabled: widget.editable),
            TextFieldWidget(
              controller: bioControl,
              fieldName: 'Biografia',
              enabled: widget.editable,
            ),
          ],
        ),
      ),
    );
  }

  UserWrapper _buildUpdatedUserFromForm() {
    final user = editedUser.user.copyWith(
      name: nameControl.text,
      email: emailControl.text,
      ra: raControl.text,
      role: editedUser.user.role, // já está atualizado
      relationship: editedUser.user.relationship,
    );

    if (editedUser is Speaker) {
      final speaker = editedUser as Speaker;
      return speaker.copyWith(
        user: user,
        company: companyControl.text,
        position: positionControl.text,
        bio: bioControl.text,
        isApproved: approvedState,
      ) as UserWrapper;
    }

    return UserAppWrapper(user);
  }

  @override
  void dispose() {
    nameControl.dispose();
    emailControl.dispose();
    raControl.dispose();
    roleControler.dispose();
    relationshipControl.dispose();
    bioControl.dispose();
    companyControl.dispose();
    positionControl.dispose();
    super.dispose();
  }

  _confirmAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Atualizar Perfil'),
        content: const Text('Tem certeza que deseja alterar o perfil?'),
        actions: [
          TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                context.pop();
                widget.onCancel?.call();
                setState(() {
                  _initializeForm();
                });
              }),
          TextButton(
            onPressed: () {
              context.pop();
              final updated = _buildUpdatedUserFromForm();
              widget.onSave?.call(updated);
            },
            child: const Text('Alterar'),
          ),
        ],
      ),
    );
  }
}
