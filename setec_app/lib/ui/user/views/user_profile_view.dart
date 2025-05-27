import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';
import 'package:setec_app/ui/core/views/profile_view.dart';
import 'package:setec_app/ui/user/viewModel/user_view_model.dart';

class UserProfileView extends ConsumerStatefulWidget {
  const UserProfileView({super.key});

  @override
  ConsumerState<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends ConsumerState<UserProfileView> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final userVM = ref.watch(userViewModel);
    final userMethods = ref.read(userViewModel.notifier);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
      ),
      body: userVM.when(
        data: (user) => ProfileView(
          user: user,
          width: size.width,
          editable: _isEditing,
          onCancel: () {
            setState(() {
              _isEditing = !_isEditing;
            });
          },
          onSave: (updatedUser) {
            userMethods.updateProfile(
              user: updatedUser,
              isSelfUser: true,
            );
            setState(() {
              _isEditing = !_isEditing;
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
