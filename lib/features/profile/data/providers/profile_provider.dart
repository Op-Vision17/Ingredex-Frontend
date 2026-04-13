import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_client.dart';
import '../models/profile_models.dart';

part 'profile_provider.g.dart';

@riverpod
Future<HealthProfile> userProfile(UserProfileRef ref) async {
  final dio = ref.watch(dioClientProvider);
  final res = await dio.get('/profile');
  return HealthProfile.fromJson(res.data);
}

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> updateProfile(HealthProfile profile) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final dio = ref.read(dioClientProvider);
      await dio.put('/profile', data: profile.toJson());
      ref.invalidate(userProfileProvider);
    });
  }
}
