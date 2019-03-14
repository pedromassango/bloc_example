import 'package:flutter_bloc_example/src/git_repository.dart';
import 'package:flutter_bloc_example/src/models.dart';
import 'package:rxdart/rxdart.dart';

class HomePageBloc {

  GitRepository _gitRepository = GitRepository();

  BehaviorSubject<List<JobPositionModel>> _behaviorSubject = BehaviorSubject();

  Observable<List<JobPositionModel>> get jobs => _behaviorSubject.stream;

  void searchJobs(String position, String location){
    _gitRepository.searchJob(position, location)
        .then((value){
          _behaviorSubject.sink.add(value);
    });
  }

  dispose(){
    _behaviorSubject.close();
  }
}