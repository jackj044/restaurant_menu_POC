import 'dart:async';

class UIState<T> {
  UIState({this.isLoading = false, this.success, this.request, this.isLoadMore = false});

  bool isLoading;
  T? success;
  StreamController<T> controller = StreamController<T>.broadcast();
  dynamic request;
  bool isLoadMore;
}