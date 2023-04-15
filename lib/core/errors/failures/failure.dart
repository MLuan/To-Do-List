import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? errorMessage;

  const Failure({
    this.errorMessage,
  });
}

class GenericFailure extends Failure {
  @override
  List<Object?> get props => [];
}
