import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomePageEvent extends Equatable {}

class HomePageEventSearch extends HomePageEvent {
  final String jobPosition;

  HomePageEventSearch({this.jobPosition});

  @override
  String toString() => 'HomePageEventSearch';
}
