import 'package:chopper/chopper.dart';
import 'package:erg/features/shared/models/auth/auth_model.dart';
import 'package:erg/features/shared/models/customers/customer_model.dart';

import '../../utils/constants.dart';
import '../converter.dart';
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

  static ErgCustomerService create({required AccessTokenBearer tokenPayload}) {
    final client = ChopperClient(
      baseUrl: RouterPath.customerBaseUrl,
      errorConverter: ApiErrorConverter(),
      interceptors: [
        HeadersInterceptor(
          {
            'Authorization':
                '${tokenPayload.tokenType} ${tokenPayload.accessTokenString}'
          },
        )
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
