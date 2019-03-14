
import 'package:flutter_bloc_example/src/github_service.dart';
import 'package:flutter_bloc_example/src/models.dart';

class GitRepository{
  final githubService = GithubService();

  Future<List<JobPositionModel>> searchJob(String position, String location) async{
    return githubService.searchJob(position, location);
  }
}