// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roof_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$RoofOrderService extends RoofOrderService {
  _$RoofOrderService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = RoofOrderService;

  @override
  Future<Response<dynamic>> createRoofOrder(
      {required RoofDataCreateModel newRoofOrder}) {
    final $url = '/create';
    final $body = newRoofOrder;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<RoofOrderFetchModel>> searchByCustomerInfo(
      {required Map<String, dynamic> customerInfo}) {
    final $url = '/orders/search/customer_info';
    final $params = customerInfo;
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<RoofOrderFetchModel, RoofOrderFetchModel>($request);
  }

  @override
  Future<Response<List<RoofOrderFetchModel>>> getAllRoofOrders() {
    final $url = '/orders/all';
    final $request = Request('GET', $url, client.baseUrl);
    return client
        .send<List<RoofOrderFetchModel>, RoofOrderFetchModel>($request);
  }
}
