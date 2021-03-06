import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:yaml/yaml.dart';

/// Provides the [AppConfigData] from the `app_config.yaml` located in the asset
/// folder.
class AppConfig {
  static final Logger _log = Logger('AppConfig');

  /// The [AppConfigData] representing the data in `app_config.yaml`.
  AppConfigData data;

  /// Parses the app configuration located at `assets/config/app_config.yaml`.
  ///
  /// If the app config was unable to be parsed or if the twitter
  /// configuration is invalid, [data] will be `null`.
  Future<void> parseAppConfig() async {
    _log.fine('parsing app config');

    try {
      final String appConfigString = await rootBundle.loadString(
        'assets/config/app_config.yaml',
        cache: false,
      );

      // parse app config
      final YamlMap yamlMap = loadYaml(appConfigString);

      final AppConfigData appConfigData = AppConfigData(
        twitterConsumerKey: yamlMap['twitter']['consumer_key'],
        twitterConsumerSecret: yamlMap['twitter']['consumer_secret'],
        sentryDsn: yamlMap['sentry'] != null ? yamlMap['sentry']['dns'] : null,
      );

      if (appConfigData.invalidTwitterConfig) {
        throw Exception('Twitter api key or secret is empty.');
      } else {
        data = appConfigData;
      }
    } catch (e, stacktrace) {
      _log.severe(
        'Error while loading app_config.yaml\n'
        'Make sure an `app_config.yaml` file exists in the `assets/config/` '
        'directory with the twitter api key and secret.\n'
        'example:\n'
        'assets/config/app_config.yaml:\n'
        'twitter:\n'
        '    consumer_key: <key>\n'
        '    consumer_secret: <secret>',
        e,
        stacktrace,
      );
    }
  }
}

/// Represents the app configuration located in the assets folder.
///
/// The config is parsed when the app is initialized.
@immutable
class AppConfigData {
  const AppConfigData({
    @required this.twitterConsumerKey,
    @required this.twitterConsumerSecret,
    @required this.sentryDsn,
  });

  final String twitterConsumerKey;
  final String twitterConsumerSecret;

  final String sentryDsn;

  bool get invalidTwitterConfig =>
      twitterConsumerKey?.isEmpty == true &&
      twitterConsumerSecret?.isEmpty == true;
}
