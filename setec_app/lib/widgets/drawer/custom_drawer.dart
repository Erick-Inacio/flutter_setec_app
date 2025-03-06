import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setec_app/models/user_app_model.dart';

class CustomDrawer extends StatelessWidget {
  final UserApp userApp;
  final BuildContext parentContext;
  const CustomDrawer({
    super.key,
    required this.userApp,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    bool isSpeaker = userApp.role.displayName == 'Palestrante' ? true : false;
    bool isAdmin = !isSpeaker
        ? userApp.role.displayName == 'Administrador'
            ? true
            : false
        : false;

    double height = MediaQuery.sizeOf(context).height;
    return Drawer(
      backgroundColor: Colors.deepPurple.shade50,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
        children: <Widget>[
          SizedBox(
            height: height / 6,
            child: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              radius: 60,
              child: Icon(Icons.person, size: 80, color: Colors.white),
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
          isAdmin
              ? ListTile(
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
                    parentContext.push('/manageEvents');
                  },
                )
              : Container(),
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
