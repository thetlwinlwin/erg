import 'package:chopper/chopper.dart';
import 'package:erg/api/converter.dart';
import '../../utils/constants.dart';
import 'package:erg/features/shared/models/auth/auth_model.dart';
part 'auth_api.chopper.dart';

@ChopperApi()
abstract class ErgAuthService extends ChopperService {
  @Post(path: '/login')
  @Multipart()
  Future<Response<AccessTokenBearer>> managerLoggingIn(
    @Part() String username,
    @Part() String password,
  );

  static ErgAuthService create() {
    final client = ChopperClient(
      baseUrl: RouterPath.authApiUrl,
      // converter: AccessTokenBearerConverter(),
      converter: ModelConverter<AccessTokenBearer>(
        typeOfContent: formEncodedHeaders,
        fromJson: (json) => AccessTokenBearer.fromJson(json),
      ),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
      errorConverter: ApiErrorConverter(),
      services: [
        _$ErgAuthService(),
      ],
    );
    return _$ErgAuthService(client);
  }
}
