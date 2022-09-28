// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'c_channel_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$CChannelOrderService extends CChannelOrderService {
  _$CChannelOrderService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CChannelOrderService;

  @override
  Future<Response<List<CChannelOrderFetchModel>>> getAllCChannelOrders() {
    final $url = '/orders/all';
    final $request = Request('GET', $url, client.baseUrl);
    return client
        .send<List<CChannelOrderFetchModel>, CChannelOrderFetchModel>($request);
  }

  @override
  Future<Response<dynamic>> createOrder(
      {MultipartFile? file,
      required int customerId,
      required double channelHeight,
      required double channelWidth,
      required int zincGrade,
      required double sheetLength,
      required int noOfSheet,
      required double thickness,
      required DateTime pickUpTime,
      required String stage,
      String? notes}) {
    final $url = '/create';
    final $headers = {
      'content-type': 'multipart/form-data',
    };

    final $parts = <PartValue>[
      PartValue<int>('customer_id', customerId),
      PartValue<double>('channel_height', channelHeight),
      PartValue<double>('channel_width', channelWidth),
      PartValue<int>('zinc_grade', zincGrade),
      PartValue<double>('length_per_sheet', sheetLength),
      PartValue<int>('no_of_sheets', noOfSheet),
      PartValue<double>('thickness', thickness),
      PartValue<DateTime>('pick_up_time', pickUpTime),
      PartValue<String>('production_stage', stage),
      PartValue<String?>('notes', notes),
      PartValueFile<MultipartFile?>('file', file)
    ];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
