import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';
import 'package:setec_app/core/interface/user_wrapper_interface.dart';
import 'package:setec_app/model/models/speaker/speaker.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';
import 'package:setec_app/ui/core/views/profile_view.dart';
import 'package:setec_app/ui/speaker/viewModel/speaker_view_model.dart';

class SpeakerProfileView extends ConsumerStatefulWidget {
  const SpeakerProfileView({super.key, required this.speaker});

  final Speaker speaker;

  @override
  ConsumerState<SpeakerProfileView> createState() => _SpeakerProfileViewState();
}

class _SpeakerProfileViewState extends ConsumerState<SpeakerProfileView> {
  bool _isEditing = false;
  late UserWrapper _localSpeaker;

  @override
  void initState() {
    super.initState();
    _localSpeaker = widget.speaker;
  }

  @override
  Widget build(BuildContext context) {
    final userVM = ref.watch(speakerViewModel);
    final speakerMethods = ref.read(speakerViewModel.notifier);
    final size = MediaQuery.of(context).size;
    final authState = ref.read(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Palestrante'),
        centerTitle: true,
      ),
      body: userVM.when(
        data: (user) => ProfileView(
          user: _localSpeaker,
          width: size.width,
          editable: _isEditing,
          onCancel: () {
            setState(() {
              _isEditing = !_isEditing;
            });
          },
          onSave: (updatedSpeaker) async {
            if (updatedSpeaker is Speaker && _localSpeaker is Speaker) {
              final localSpeaker = _localSpeaker as Speaker;

              final statusChanged =
                  updatedSpeaker.isApproved != localSpeaker.isApproved;
              final isAdmin = authState.isAdmin;

              if (statusChanged && isAdmin) {
                final adminUid = authState.user!.user.uid;
                updatedSpeaker =
                    updatedSpeaker.copyWith(adminUid: adminUid);
              }
            }

            await speakerMethods.updateProfile(user: updatedSpeaker);

            setState(() {
              _isEditing = !_isEditing;
              _localSpeaker = updatedSpeaker;
            });
          },
        ),
        error: (error, stackTrace) {
          Logger().e(error.toString());
          return Center(
            child: Text(error.toString()),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
