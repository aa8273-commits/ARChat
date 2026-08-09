class PrivacyState {
  final String lastSeen;
  final String profilePhoto;
  final String addGroups;

  const PrivacyState({
    this.lastSeen = "Everyone",
    this.profilePhoto = "Everyone",
    this.addGroups = "Everyone",
  });

  PrivacyState copyWith({
    String? lastSeen,
    String? profilePhoto,
    String? addGroups,
  }) {
    return PrivacyState(
      lastSeen: lastSeen ?? this.lastSeen,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      addGroups: addGroups ?? this.addGroups,
    );
  }
}
