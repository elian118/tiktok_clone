import 'package:flutter/material.dart';

class DateTimePickerEx extends StatelessWidget {
  const DateTimePickerEx({
    super.key,
  });

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
        print(date);
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        print(time);
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
        print(booking);
      },
      title: const Text("What is your birthday?"),
      subtitle: const Text('I need to know!'),
    );
  }
}
