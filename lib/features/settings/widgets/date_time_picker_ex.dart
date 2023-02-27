import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DateTimePickerEx extends StatefulWidget {
  const DateTimePickerEx({
    super.key,
  });

  @override
  State<DateTimePickerEx> createState() => _DateTimePickerExState();
}

class _DateTimePickerExState extends State<DateTimePickerEx> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1980),
          lastDate: DateTime(2030),
        );
        if (kDebugMode) {
          print(date);
        }
        if (!mounted) return;
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (kDebugMode) {
          print(time);
        }
        if (!mounted) return;
        final booking = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1980),
          lastDate: DateTime(2030),
          builder: (context, child) {
            return Theme(
              data: ThemeData(
                appBarTheme: const AppBarTheme(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );
        if (kDebugMode) {
          print(booking);
        }
      },
      title: const Text("What is your birthday?"),
      subtitle: const Text('I need to know!'),
    );
  }
}
