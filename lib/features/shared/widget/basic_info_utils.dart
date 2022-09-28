import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants.dart';
import '../../../utils/theme.dart';
import '../models/base_model/base_validator.dart';
import 'custom_text_form_field.dart';

Future<DateTime?> customDatetimePicker({
  required BuildContext context,
  required DateTime currentTime,
}) {
  return DatePicker.showDateTimePicker(
    context,
    currentTime: currentTime,
    minTime: currentTime,
    maxTime: currentTime.add(allowablepickupDays),
    theme: MediaQuery.of(context).platformBrightness == Brightness.dark
        ? ErgTheme.darkDatePickerTheme
        : ErgTheme.lightDatePickerTheme,
  );
}

List<CustomTextFormField> basicInfoTextForm({
  required TextEditingController lengthController,
  required TextEditingController thicknessController,
  required TextEditingController totalSheetsController,
  required TextEditingController notesController,
}) {
  return [
    CustomTextFormField(
      validator: totalSheetsValidator,
      controller: totalSheetsController,
      labelText: BasicMMText.totalSheets,
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
    ),
    CustomTextFormField(
      validator: lengthValidator,
      controller: lengthController,
      labelText: BasicMMText.sheetPerLength,
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
    ),
    CustomTextFormField(
      validator: thicknessValidator,
      controller: thicknessController,
      labelText: BasicMMText.thickness,
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
    ),
    CustomTextFormField(
      validator: notesValidator,
      controller: notesController,
      labelText: BasicMMText.notes,
      inputType: TextInputType.text,
      inputAction: TextInputAction.done,
      callBack: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    ),
  ];
}

class ProductionStageRow extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String value;
  const ProductionStageRow({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            BasicMMText.productionStage,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
        ),
        DropdownButton<String>(
            value: value,
            items: ProudctStageValues.valueList
                .map(
                  (e) => DropdownMenuItem<String>(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: onChanged),
      ],
    );
  }
}

class PickUpDateTimeRow extends StatelessWidget {
  final DateTime pickupDateTime;
  final VoidCallback datetimePickerHandler;
  const PickUpDateTimeRow({
    Key? key,
    required this.pickupDateTime,
    required this.datetimePickerHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            BasicMMText.pickUpTime,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: datetimePickerHandler,
          child: Text(
            DateFormat.yMd().add_jm().format(pickupDateTime),
          ),
        ),
      ],
    );
    // return Row(
    //   children: [
    //     Expanded(
    //       flex: 4,
    //       child: Text(
    //         DateFormat.yMd().add_jm().format(pickupDateTime),
    //         style: const TextStyle(fontSize: 20),
    //       ),
    //     ),
    //     Expanded(
    //       child: IconButton(
    //         onPressed: datetimePickerHandler,
    //         icon: const Icon(
    //           Icons.calendar_today,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
