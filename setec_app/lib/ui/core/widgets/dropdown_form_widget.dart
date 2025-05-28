import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownFormWidget<T extends Enum> extends ConsumerStatefulWidget {
  const DropdownFormWidget({
    super.key,
    required this.values,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.displayText,
  });

  final List<T> values;
  final T value;
  final void Function(T?)? onChanged;
  final String? label;
  final bool enabled;
  final String Function(T)? displayText;

  @override
  ConsumerState<DropdownFormWidget<T>> createState() => _DropdownFormWidget<T>();
}

class _DropdownFormWidget<T extends Enum> extends ConsumerState<DropdownFormWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: widget.value,
      style: GoogleFonts.lato(
        color: Colors.deepPurple,
        fontSize: 16,
      ),
      borderRadius: BorderRadius.circular(20.0),
      isExpanded: true,
      decoration: InputDecoration(
        labelText: widget.label,
        enabled: widget.enabled,
      ),
      items: widget.values.map((value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(widget.displayText?.call(value) ?? value.name),
        );
      }).toList(),
      onChanged: widget.enabled ? widget.onChanged : null,
    );
  }
}
