import 'package:flowery_rider_app/app/feature/profile/api/profile_api_client.dart';
import 'package:injectable/injectable.dart';
import '../../../config/api_utils/api_utils.dart';
import '../../../config/base_response/base_response.dart';
import '../../apply_driver/data/model/driver_auth_response.dart';
import '../data/profile_data_source_contract.dart';

@Injectable(as: ProfileDataSourceContract)
class ProfileRemoteDataSourceImpl extends ProfileDataSourceContract {
  final ProfileApiClient _profileApiClient;

  ProfileRemoteDataSourceImpl(this._profileApiClient);

  @override
  Future<BaseResponse<DriverAuthResponse>> getProfile() =>
      executeApi(() => _profileApiClient.getProfile());


}
