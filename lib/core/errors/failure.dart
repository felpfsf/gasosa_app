sealed class Failure {
  final String message;

  Failure(this.message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}
