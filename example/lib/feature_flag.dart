import 'package:fire_flag/fire_flag.dart';

class SampleAppFeatureFlag {
  static SampleAppFeatureFlag _instance;
  static final features = Features(features: [
    /// On the Firebase Remote Config server, this 'counter' config is set to
    /// 'true' value. So if the counter feature is enabled when the app
    /// is launched, the fire flag plugin is working.
    Feature(
      name: 'counter',
      isEnabled: false,
    ),
  ]);

  SampleAppFeatureFlag._();

  final fireFlag = FireFlag(
    features: SampleAppFeatureFlag.features,
    fetchExpirationDuration: Duration(seconds: 0),
  );

  static SampleAppFeatureFlag get getInstance =>
      _instance = _instance ?? SampleAppFeatureFlag._();
}
