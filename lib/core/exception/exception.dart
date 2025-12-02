import 'package:equatable/equatable.dart';

/// Base Failure class for handling different kinds of errors
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Represents an error coming from the server (e.g. status code != 200)
class ServerFailure extends Failure {
  final int statusCode;

  const ServerFailure({
    required String message,
    required this.statusCode,
  }) : super(message);

  @override
  List<Object?> get props => [message, statusCode];
}

/// Represents a network-related failure (e.g. no internet connection)
class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}
