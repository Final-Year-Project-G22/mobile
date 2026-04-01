class OAuthPendingEmail {
  const OAuthPendingEmail({
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.provider,
    required this.state,
    required this.subject,
    this.pictureUrl,
  });

  final String firstName;
  final String lastName;
  final String name;
  final String provider;
  final String state;
  final String subject;
  final String? pictureUrl;
}
