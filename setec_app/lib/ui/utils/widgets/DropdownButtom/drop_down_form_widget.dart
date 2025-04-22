import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setec_app/core/mixins/enum_lists.dart';

class DropdownFormWidget extends ConsumerWidget with EnumLists {
  const DropdownFormWidget({
    super.key,
    this.onChanged,
    this.isRole = false,
    required this.label,
    this.initialValue,
  });
  final String? initialValue;
  final String label;
  final bool isRole;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return DropdownButtonFormField(
      value: initialValue,
      style: GoogleFonts.lato(
        fontWeight: FontWeight.normal,
        color: Colors.deepPurple,
        fontSize: 16,
      ),
      items: isRole ? listRoles() : listRelationship(),
      onChanged: (value) {
        onChanged!(value!);
      },
      decoration: InputDecoration(labelText: label),
      
    );
  }
}
