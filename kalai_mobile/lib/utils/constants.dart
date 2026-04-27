class KalaiAppConfig {
	static const String appName = 'KALAI';
	static const String apiBaseUrl = String.fromEnvironment('KALAI_API_URL', defaultValue: '');
}
