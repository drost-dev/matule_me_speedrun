import 'package:equatable/equatable.dart';

class OnboardData extends Equatable {
  const OnboardData({this.title, this.desc});

  final String? title;
  final String? desc;

  @override
  List<Object?> get props => [title, desc];
}
