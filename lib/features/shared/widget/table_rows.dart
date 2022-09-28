import 'package:erg/features/shared/widget/row_spacer.dart';
import 'package:erg/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../managers/customer_manager.dart';

List<TableRow> customerRows(BuildContext context) {
  return [
    const TableRow(children: [
      Text(
        'Customer',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
      SizedBox(
        width: 0,
      ),
    ]),
    rowSpacer,
    rowSpacer,
    TableRow(children: [
      const Text('name'),
      Text(Provider.of<CustomerManager>(context, listen: false).customerName!),
    ]),
    rowSpacer,
    TableRow(children: [
      const Text('phone'),
      Text(Provider.of<CustomerManager>(context, listen: false).customerPhone!),
    ]),
    rowSpacer,
    TableRow(children: [
      const Text('address'),
      Text(Provider.of<CustomerManager>(context, listen: false)
              .customerAddress ??
          ''),
    ]),
    rowSpacer,
    rowSpacer,
  ];
}

List<TableRow> basicInfoRows({
  required String length,
  required String thickness,
  required String totalSheets,
  required String stage,
  required DateTime pickupDateTime,
  required String notes,
}) {
  return [
    const TableRow(children: [
      Text(
        'အမှာစာ အသေးစိတ်',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
      SizedBox(
        width: 0,
      ),
    ]),
    rowSpacer,
    TableRow(
      children: [
        const Text(BasicMMText.sheetPerLength),
        Text(length),
      ],
    ),
    rowSpacer,
    TableRow(
      children: [
        const Text(BasicMMText.thickness),
        Text(thickness),
      ],
    ),
    rowSpacer,
    TableRow(
      children: [
        const Text(BasicMMText.productionStage),
        Text(stage),
      ],
    ),
    rowSpacer,
    TableRow(
      children: [
        const Text(BasicMMText.pickUpTime),
        Text(
          DateFormat.yMd().add_jm().format(pickupDateTime),
        ),
      ],
    ),
    rowSpacer,
    TableRow(
      children: [
        const Text(BasicMMText.totalSheets),
        Text(totalSheets),
      ],
    ),
    rowSpacer,
    TableRow(
      children: [
        const Text(BasicMMText.notes),
        Text(notes),
      ],
    ),
    rowSpacer,
  ];
}
