import 'package:erg/features/shared/widget/row_spacer.dart';
import 'package:flutter/material.dart';

List<TableRow> cchannelRows({
  required String channelHeight,
  required String channelWidth,
  required String grade,
  required bool holeDescription,
}) {
  return [
    TableRow(
      children: [
        const Text('Zinc'),
        Text(grade),
      ],
    ),
    rowSpacer,
    TableRow(
      children: [
        const Text('Height (inches)'),
        Text(channelHeight),
      ],
    ),
    rowSpacer,
    TableRow(
      children: [
        const Text('Width (inches)'),
        Text(channelWidth),
      ],
    ),
    rowSpacer,
    TableRow(
      children: [
        const Text('Holes'),
        Text(holeDescription ? 'As in Photo' : 'Normal'),
      ],
    ),
  ];
}
