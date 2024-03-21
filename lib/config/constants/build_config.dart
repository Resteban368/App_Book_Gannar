import 'env_config.dart';
import 'environment.dart';

class BuildConfig {
  late Environment environment;
  late EnvConfig config;
  bool _lock = false;

  static final BuildConfig _instance = BuildConfig._internal();

  BuildConfig._internal();

  static BuildConfig get instance => _instance;

  factory BuildConfig.instantiate({
    required Environment envType,
    required EnvConfig envConfig,
  }) {
    if (_instance._lock) {
      // Si ya se ha bloqueado, devuelve la instancia existente
      return _instance;
    }

    _instance.environment = envType;
    _instance.config = envConfig;
    _instance._lock = true;

    return _instance;
  }
}
