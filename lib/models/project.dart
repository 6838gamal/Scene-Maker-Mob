class Project {
  final String id;
  final String name;
  final String? thumbnail;
  final String duration;
  final DateTime createdAt;
  final String platform;
  final int aiEdits;

  Project({
    required this.id,
    required this.name,
    this.thumbnail,
    required this.duration,
    required this.createdAt,
    required this.platform,
    required this.aiEdits,
  });

  Project copyWith({
    String? id,
    String? name,
    String? thumbnail,
    String? duration,
    DateTime? createdAt,
    String? platform,
    int? aiEdits,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      platform: platform ?? this.platform,
      aiEdits: aiEdits ?? this.aiEdits,
    );
  }
}
