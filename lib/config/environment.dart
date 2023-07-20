enum Environment {
  dev(name: 'develop', serverUrl: ''),
  prod(name: 'production', serverUrl: '');

  final String name;
  final String serverUrl;

  const Environment({
    required this.name,
    required this.serverUrl,
  });
}
