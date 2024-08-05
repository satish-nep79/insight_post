import 'package:flutter/material.dart';

@immutable
abstract class GenericState<T> {
  const GenericState();
}


class InitialState<T> extends GenericState<T> {
  const InitialState();
}
class LoadingState<T> extends GenericState<T> {
  const LoadingState();
}

class SuccessState<T> extends GenericState<T> {
  final T data;

  const SuccessState(this.data);
}

class ErrorState<T> extends GenericState<T> {
  final String message;

  const ErrorState(this.message);
}

extension GenericStateExtension<T> on GenericState<T> {
  R when<R>({
    required R Function() loading,
    required R Function(T data) success,
    required R Function() empty,
    required R Function(String message) error,
  }) {
    if (this is LoadingState<T>) {
      return loading();
    } else if (this is SuccessState<T>) {
      final data = (this as SuccessState<T>).data;
      if ((data is Iterable && data.isEmpty) || (data == null)) {
        return empty();
      }
      return success((this as SuccessState<T>).data);
    } else if (this is ErrorState<T>) {
      return error((this as ErrorState<T>).message);
    }
    throw Exception('Invalid state');
  }
}
