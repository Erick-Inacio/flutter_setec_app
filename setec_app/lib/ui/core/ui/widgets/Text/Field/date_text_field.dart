import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateTextField extends StatefulWidget {
  final BuildContext context;
  final String fieldName;
  final TextEditingController controller;
  final Function(DateTime?) onDateTimeSelected;

  const DateTextField({
    super.key,
    required this.controller,
    required this.context,
    required this.fieldName,
    required this.onDateTimeSelected,
  });

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.fieldName,
        labelStyle: GoogleFonts.lato(color: Colors.deepPurple),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Obrigatório' : null,
      onTap: () async {
        await _selectDateAndTime();
      },
    );
  }

  Future<void> _selectDateAndTime() async {
    final initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: widget.context,
      firstDate: DateTime.now(),
      initialDate: initialDate,
      lastDate: DateTime(2026),
    );

    if (pickedDate != null && widget.context.mounted) {
      final pickedTime = await showTimePicker(
        context: widget.context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (pickedTime == null) return;

      final monthName = _getMonthName(pickedDate.month);
      final formattedTime = _formatTime(pickedTime.hour, pickedTime.minute);

      widget.controller.text =
          '${pickedDate.day}/$monthName - $formattedTime';

      DateTime? selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      widget.onDateTimeSelected(selectedDateTime);
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Fev';
      case 3:
        return 'Mar';
      case 4:
        return 'Abr';
      case 5:
        return 'Maio';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Ago';
      case 9:
        return 'Set';
      case 10:
        return 'Out';
      case 11:
        return 'Nov';
      case 12:
        return 'Dez';
      default:
        return '';
    }
  }

  String _formatTime(int hour, int minute) {
    final hourString = hour.toString().padLeft(2, '0');
    final minuteString = minute.toString().padLeft(2, '0');
    return '$hourString:$minuteString';
  }
}
