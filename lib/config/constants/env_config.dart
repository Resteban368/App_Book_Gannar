
class EnvConfig {
  final String appName;
  final String baseUrl;
  final String unencoded;
  final bool shouldCollectCrashLog;
  final String versionNumber;


  EnvConfig({
    required this.appName,
    required this.baseUrl,
    required this.unencoded,
    required this.versionNumber,
    required this.shouldCollectCrashLog,
  }) {
  
  }
}
