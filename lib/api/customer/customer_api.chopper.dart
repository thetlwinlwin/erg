// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ErgCustomerService extends ErgCustomerService {
  _$ErgCustomerService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ErgCustomerService;

  @override
  Future<Response<CustomerOut>> createCustomer(
      {required CustomerCreate newCustomer}) {
    final $url = '/create';
    final $body = newCustomer;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<CustomerOut, CustomerOut>($request);
  }

  @override
  Future<Response<List<CustomerOut>>> searchCustomer(
      {String? name, String? phone, String? gender}) {
    final $url = '/search';
    final $params = <String, dynamic>{
      'name': name,
      'phone': phone,
      'gender': gender
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<CustomerOut>, CustomerOut>($request);
  }
}
