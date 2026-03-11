import '../base_state/base_state.dart';

sealed class BaseResponse<T> {}

class SuccessResponse<T> extends BaseResponse<T> {
  final T data;
  SuccessResponse({required this.data});
}

class ErrorResponse<T> extends BaseResponse<T> {
  final Exception error;
  ErrorResponse({required this.error});
}
extension BaseStateMapper<T> on BaseResponse<T> {
  BaseState<T> toBaseState() {
    switch (this) {
      case SuccessResponse<T>():
        return BaseState(data: (this as SuccessResponse<T>).data);

      case ErrorResponse<T>():
        return BaseState(error: (this as ErrorResponse<T>).error);
    }
  }
}