class UserProfile {
  final String name;
  final String company;
  final String avatarUrl;

  const UserProfile({
    required this.name,
    required this.company,
    this.avatarUrl = '',
  });
}
