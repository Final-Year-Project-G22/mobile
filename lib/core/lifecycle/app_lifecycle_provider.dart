import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_lifecycle_provider.g.dart';

@Riverpod(keepAlive: true)
class IsAppInForeground extends _$IsAppInForeground {
  @override
  bool build() => true;

  void setForeground({required bool value}) {
    state = value;
  }
}
