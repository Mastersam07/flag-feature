/// Status of each features available on the app.
class Features {
  /// Constructs an instance of [Features].
  Features({this.features = const []});

  /// Features and its availability statuses.
  List<Feature> features;

  /// Checks whether the feature is enabled or not.
  ///
  /// Pass the feature name string to [featureName]. Or pass the enum if the
  /// app uses enum to list the available feature.
  bool featureIsEnabled(featureName) {
    var selectedFeatureName =
        _isEnum(featureName) ? (featureName as Enum).name : featureName;

    final selectedFeatures =
        features.where((feature) => feature.name == selectedFeatureName);

    if (selectedFeatures.isEmpty) {
      return false;
    }

    return selectedFeatures.first.isEnabled;
  }

  bool _isEnum(dynamic data) {
    final split = data.toString().split('.');
    return split.length > 1 && split[0] == data.runtimeType.toString();
  }
}

/// Feature and its availability status
class Feature {
  String name;
  bool isEnabled;

  Feature({required this.name, required this.isEnabled});
}
