import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setec_app/providers/auth_state_notifier.dart';
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
          Divider(),
          ListTile(
            leading: Icon(Icons.person, color: Colors.deepPurple),
            title: Text(
              'Meu Perfil',
              style: GoogleFonts.lato(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          ),
          // isAdmin
          //     ?
          ListTile(
            leading: Icon(
              Icons.festival,
              color: Colors.deepPurple,
            ),
            title: Text(
              'Gerenciar Eventos',
              style: GoogleFonts.lato(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // : Container(),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.deepPurple,
            ),
            title: Text(
              'Configurações',
              style: GoogleFonts.lato(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
