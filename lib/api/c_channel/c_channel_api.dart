import 'package:chopper/chopper.dart';
import 'package:http/http.dart' show MultipartFile;

import 'package:erg/api/authenticator.dart';
import 'package:erg/api/converter.dart';
import 'package:erg/api/interceptor.dart';
import 'package:erg/features/shared/models/c_channel/c_channel_model.dart';
import 'package:erg/managers/listener_manager.dart';

import '../../utils/constants.dart';

part 'c_channel_api.chopper.dart';

@ChopperApi()
abstract class CChannelOrderService extends ChopperService {
  @Get(path: '/orders/all')
  Future<Response<List<CChannelOrderFetchModel>>> getAllCChannelOrders();

  @Post(path: '/create', headers: {contentTypeKey: "multipart/form-data"})
  @Multipart()
  Future<Response> createOrder({
    @PartFile('file') MultipartFile? file,
    @Part('customer_id') required int customerId,
    @Part('channel_height') required double channelHeight,
    @Part('channel_width') required double channelWidth,
    @Part('zinc_grade') required int zincGrade,
    @Part('length_per_sheet') required double sheetLength,
    @Part('no_of_sheets') required int noOfSheet,
    @Part('thickness') required double thickness,
    @Part('pick_up_time') required DateTime pickUpTime,
    @Part('production_stage') required String stage,
    @Part('notes') String? notes,
  });

  static CChannelOrderService create({
    ListenerManager? manager,
  }) {
    final client = ChopperClient(
      authenticator: ErgAuth(
        manager: manager,
      ),
      baseUrl: RouterPath.cchannelOrderBaseUrl,
      errorConverter: ApiErrorConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        JWTAttachInterceptor(
          tokenBearer: manager?.getAccessTokenBearer,
        ),
      ],
      services: [
        _$CChannelOrderService(),
      ],
      converter: ModelConverter<CChannelOrderFetchModel>(
          typeOfContent: jsonHeaders,
          fromJson: ((json) => CChannelOrderFetchModel.fromJson(json))),
    );
    return _$CChannelOrderService(client);
  }
}
