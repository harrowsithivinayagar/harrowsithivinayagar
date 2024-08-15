sealed class Result<S, E> {
  const Result();

  void when({
    required void Function(S value) success,
    required void Function(E value) failure,
  }) {
    if (this is Success<S, E>) {
      success((this as Success<S, E>).value);
    } else if (this is Failure<S, E>) {
      failure((this as Failure<S, E>).value);
    }
  }
}

final class Success<S, E> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E> extends Result<S, E> {
  const Failure(this.value);
  final E value;
}
