sealed class Either<E extends Exception, Object> {}

class Failure<E extends Exception, Object> extends Either<E, Object> {
  final E exception;
  Failure(this.exception);
}

class Success<E extends Exception, Object> extends Either<E, Object> {
  final Object value;
  Success(this.value);
}
