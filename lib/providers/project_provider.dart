import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectProvider extends ChangeNotifier {
  final List<Project> _projects = [
    Project(
      id: '1',
      name: 'Beach Sunset Reel',
      thumbnail: null,
      duration: '0:32',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      platform: 'Instagram Reels',
      aiEdits: 3,
    ),
    Project(
      id: '2',
      name: 'Product Showcase',
      thumbnail: null,
      duration: '0:58',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      platform: 'TikTok',
      aiEdits: 5,
    ),
    Project(
      id: '3',
      name: 'City Timelapse',
      thumbnail: null,
      duration: '1:15',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      platform: 'YouTube Shorts',
      aiEdits: 2,
    ),
  ];

  List<Project> get projects => List.unmodifiable(_projects);

  void addProject(Project project) {
    _projects.insert(0, project);
    notifyListeners();
  }

  void removeProject(String id) {
    _projects.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void updateProject(Project project) {
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index != -1) {
      _projects[index] = project;
      notifyListeners();
    }
  }
}
