import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';
import 'package:setec_app/ui/home/widgets/divider_widget.dart';
import 'package:setec_app/ui/home/widgets/list_tile_widget.dart';
import 'package:setec_app/ui/home/widgets/sign_out_text_button.dart';

class DrawerWidget extends ConsumerWidget {
  // final UserApp userApp;
  final BuildContext parentContext;
  const DrawerWidget({
    super.key,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Providers
    final authState = ref.watch(authProvider);

    //Screen sizes
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Drawer(
      backgroundColor: Colors.deepPurple.shade50,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
        children: <Widget>[
          SizedBox(
            height: height / 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: width / 6),
                CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  radius: 60,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: authState.isAuthenticated
                      ? SignOutTextButton()
                      : Container(),
                ),
              ],
            ),
          ),
          DividerWidget(),
          ListTileWidget(
            icon: Icons.person,
            title: 'Meu Perfil',
            onTap: () {
              context.pop();
              context.push('/userProfile');
            },
          ),
          authState.isAdmin
              ? Column(
                  children: <Widget>[
                    DividerWidget(),
                    ListTileWidget(
                      title: 'Alunos',
                      icon: Icons.person_pin,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTileWidget(
                      icon: Icons.speaker_group,
                      title: 'Palestrantes',
                      onTap: () {
                        context.pop();
                        parentContext.push('/speakers');
                      },
                    ),
                    ListTileWidget(
                      icon: Icons.calendar_month,
                      title: 'Palestras',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTileWidget(
                      icon: Icons.school_rounded,
                      title: 'Mini Cursos',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTileWidget(
                      icon: Icons.festival,
                      title: 'Setecs',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              : Container(),
          DividerWidget(),
          ListTileWidget(
            icon: Icons.settings,
            title: 'Configurações',
            onTap: () {},
          )
        ],
      ),
    );
  }
}