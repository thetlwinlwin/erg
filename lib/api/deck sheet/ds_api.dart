import 'package:chopper/chopper.dart';
import 'package:erg/api/authenticator.dart';
import 'package:erg/utils/constants.dart';

import '../../features/shared/models/ds/ds_model.dart';
import '../../managers/listener_manager.dart';
import '../converter.dart';
import '../interceptor.dart';

part 'ds_api.chopper.dart';

@ChopperApi()
abstract class DsOrderService extends ChopperService {
  @Post(path: '/create')
  Future<Response> createDsOrder({
    @Body() required DSDataCreateModel newDsOrder,
  });

  @Get(path: '/orders/search/customer_info')
  Future<Response<DSOrderFetchModel>> searchByCustomerInfo({
    @QueryMap() required Map<String, dynamic> customerInfo,
  });

  @Get(path: '/orders/all')
  Future<Response<List<DSOrderFetchModel>>> getAllDsOrders();

  static DsOrderService create({
    ListenerManager? manager,
  }) {
    final client = ChopperClient(
      authenticator: ErgAuth(
        manager: manager,
      ),
      baseUrl: RouterPath.dsOrderBaseUrl,
      errorConverter: ApiErrorConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        JWTAttachInterceptor(
          tokenBearer: manager?.getAccessTokenBearer,
        ),
      ],
      services: [
        _$DsOrderService(),
      ],
      converter: ModelConverter<DSOrderFetchModel>(
        typeOfContent: jsonHeaders,
        fromJson: ((json) => DSOrderFetchModel.fromJson(json)),
      ),
    );
    return _$DsOrderService(client);
  }
}
