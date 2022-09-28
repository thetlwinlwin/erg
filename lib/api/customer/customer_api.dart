import 'package:chopper/chopper.dart';
import 'package:erg/features/shared/models/customers/customer_model.dart';

import '../../managers/listener_manager.dart';
import '../../utils/constants.dart';
import '../authenticator.dart';
import '../converter.dart';
import '../interceptor.dart';
part 'customer_api.chopper.dart';

@ChopperApi()
abstract class ErgCustomerService extends ChopperService {
  @Post(path: '/create')
  Future<Response<CustomerOut>> createCustomer({
    @Body() required CustomerCreate newCustomer,
  });

  @Get(path: '/search')
  Future<Response<List<CustomerOut>>> searchCustomer({
    @Query() String? name,
    @Query() String? phone,
    @Query() String? gender,
  });

  static ErgCustomerService create(
    ListenerManager? manager,
  ) {
    final client = ChopperClient(
      authenticator: ErgAuth(
        manager: manager,
      ),
      baseUrl: RouterPath.customerBaseUrl,
      errorConverter: ApiErrorConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        JWTAttachInterceptor(
          tokenBearer: manager?.getAccessTokenBearer,
        ),
      ],
      services: [
        _$ErgCustomerService(),
      ],
      converter: ModelConverter<CustomerOut>(
        typeOfContent: jsonHeaders,
        fromJson: ((json) => CustomerOut.fromJson(json)),
      ),
    );
    return _$ErgCustomerService(client);
  }
}
