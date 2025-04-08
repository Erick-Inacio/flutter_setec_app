import 'package:flutter/material.dart';
import 'package:setec_app/ui/core/ui/widgets/iconButton/icon_text_buttom.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 70,
        maxHeight: 120,
      ),
      child: BottomAppBar(
        elevation: 0,
        notchMargin: 6,
        color: Colors.deepPurple.shade50,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconTextButtom(
              icon: Icons.calendar_month,
              text: 'Palestras',
              route: '/lectures',
            ),
            IconTextButtom(
              icon: Icons.school_rounded,
              text: 'Mini Cursos',
              route: '/miniCourses',
            ),
            IconTextButtom(
              icon: Icons.festival,
              text: 'Setecs',
              route: '/events',
            ),
            // if (!CheckingUserStatus().isStudent())
              SizedBox(width: width * 0.02),
          ],
        ),
      ),
    );
  }
}
