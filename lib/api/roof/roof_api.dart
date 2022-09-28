import 'package:chopper/chopper.dart';
import 'package:erg/api/authenticator.dart';
import 'package:erg/api/converter.dart';
import 'package:erg/api/interceptor.dart';
import 'package:erg/features/shared/models/roof/roof_model.dart';
import 'package:erg/managers/listener_manager.dart';
import 'package:erg/utils/constants.dart';
part 'roof_api.chopper.dart';

@ChopperApi()
abstract class RoofOrderService extends ChopperService {
  @Post(path: '/create')
  Future<Response> createRoofOrder({
    @Body() required RoofDataCreateModel newRoofOrder,
  });

  @Get(path: '/orders/search/customer_info')
  Future<Response<RoofOrderFetchModel>> searchByCustomerInfo({
    @QueryMap() required Map<String, dynamic> customerInfo,
  });

  @Get(path: '/orders/all')
  Future<Response<List<RoofOrderFetchModel>>> getAllRoofOrders();

  static RoofOrderService create({
    ListenerManager? manager,
  }) {
    final client = ChopperClient(
      authenticator: ErgAuth(manager: manager),
      baseUrl: RouterPath.roofOrderBaseUrl,
      errorConverter: ApiErrorConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        JWTAttachInterceptor(
          tokenBearer: manager?.getAccessTokenBearer,
        )
      ],
      services: [
        _$RoofOrderService(),
      ],
      converter: ModelConverter<RoofOrderFetchModel>(
          typeOfContent: jsonHeaders,
          fromJson: (json) => RoofOrderFetchModel.fromJson(json)),
    );
    return _$RoofOrderService(client);
  }
}
