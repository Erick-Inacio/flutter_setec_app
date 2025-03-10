import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class IconTextButtom extends StatefulWidget {
  final IconData icon;
  final String text;
  final String route;

  const IconTextButtom({
    super.key,
    required this.route,
    required this.icon,
    required this.text,
  });

  @override
  State<IconTextButtom> createState() => _IconTextButtomState();
}

class _IconTextButtomState extends State<IconTextButtom> {
  @override
  Widget build(BuildContext context) {
    String currentRoute = GoRouterState.of(context).uri.toString();
    bool isSelected = currentRoute == widget.route;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => context.go(widget.route),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                widget.icon,
                color: isSelected
                    ? Colors.deepPurple
                    : Colors.grey.shade600,
                size: isSelected ? 26 : 23,
              ),
              Text(
                widget.text,
                style: GoogleFonts.lato(
                  color: isSelected
                      ? Colors.deepPurple
                      : Colors.grey.shade600,
                  fontSize: isSelected ? 14 : 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
