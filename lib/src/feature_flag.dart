import 'package:flutter/foundation.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'feature.dart';

/// App wide feature flag manager. Manages the availability status of each
/// features on the app.
class FeatureFlag {
  /// Constructs an instance of [FeatureFlag].
  ///
  /// Make sure you have set the required Firebase Remote Config setup on your
  /// app.
  ///
  /// Set the default values of feature flags to [features].
  ///
  /// Set the [fetchExpirationDuration] to specify the custom expiration
  /// duration time for any fetch from the Firebase Remote Config server.
  /// Server fetch will only be done when the previous fetch is already
  /// expired. Default expiration duration is 1 minute.
  ///
  /// Set the [fetchMaximumInterval] to specify the maximum age
  /// of a cached config before it is considered stale.
  /// Defaults to five hours.
  FeatureFlag({
    @required Features features,
    Duration fetchExpirationDuration,
    Duration fetchMaximumInterval,
  }) {
    _features = features;
    _fetchExpirationDuration =
        fetchExpirationDuration ?? const Duration(minutes: 1);
    _fetchMaximumInterval = fetchMaximumInterval ?? const Duration(hours: 5);
  }

  /// The status flag of available features.
  ///
  /// Consider that default values set to this variable will be used as feature
  /// flag default values.
  /// Default values will be used when the app launches for the first time so
  /// that there is no feature flag data yet on Firebase Remote Config's local
  /// cache.
  Features _features;

  RemoteConfig _remoteConfig;
  Duration _fetchExpirationDuration;
  Duration _fetchMaximumInterval;

  /// Initialize feature flag stream.
  ///
  /// The stream will be initialized with value from local stored feature
  /// status (or default feature status if there's no local cache yet).
  /// Then it will fetch the feature status configuration from Firebase
  /// Remote Config server and store the latest config to the local cache and
  /// to the stream.
  Stream<Features> featureFlagSubscription() async* {
    _remoteConfig = RemoteConfig.instance;

    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      minimumFetchInterval: _fetchMaximumInterval,
      fetchTimeout: _fetchExpirationDuration,
    ));

    ///Fetch latest feature flag data from Firebase Remote Config and apply
    ///them.
    yield await _featureFlagFromFirebaseRemoteConfigServer();
  }

  Features _featureFlagFromLocalStoredFirebaseRemoteConfig() {
    for (var feature in _features.features) {
      var featureFlagValue = _remoteConfig.getValue(feature.name);

      /// Check whether Firebase Remote Config has the feature flag data for the
      /// feature first before setting the value. Otherwise preserve the default
      /// value.
      if (featureFlagValue != null) {
        /// Will be set to false when the value is not equal to 'true'.
        /// Case insensitive. 'True' will be still considered as true.
        feature.isEnabled = featureFlagValue.asBool();
      }
    }

    return _features;
  }

  Future<Features> _featureFlagFromFirebaseRemoteConfigServer() async {
    ///1. Fetch the feature flag data from Firebase Remote Config server.
    await _remoteConfig.fetch();

    ///2. Store the fetched feature flag data to Firebase Remote Config local
    ///   cache.
    await _remoteConfig.fetchAndActivate();

    ///3. Get the feature flag from Firebase Remote Config's local cache.
    return _featureFlagFromLocalStoredFirebaseRemoteConfig();
  }
}
