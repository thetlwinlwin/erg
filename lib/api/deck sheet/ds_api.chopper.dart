// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ds_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$DsOrderService extends DsOrderService {
  _$DsOrderService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DsOrderService;

  @override
  Future<Response<dynamic>> createDsOrder(
      {required DSDataCreateModel newDsOrder}) {
    final $url = '/create';
    final $body = newDsOrder;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<DSOrderFetchModel>> searchByCustomerInfo(
      {required Map<String, dynamic> customerInfo}) {
    final $url = '/orders/search/customer_info';
    final $params = customerInfo;
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<DSOrderFetchModel, DSOrderFetchModel>($request);
  }

  @override
  Future<Response<List<DSOrderFetchModel>>> getAllDsOrders() {
    final $url = '/orders/all';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<DSOrderFetchModel>, DSOrderFetchModel>($request);
  }
}
