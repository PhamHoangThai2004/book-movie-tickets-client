enum StatusEnum { initial, processing, success, failure }

extension StatusEnumX on StatusEnum {
  bool get isInitial => this == StatusEnum.initial;

  bool get isProcessing => this == StatusEnum.processing;

  bool get isSuccess => this == StatusEnum.success;

  bool get isFailure => this == StatusEnum.failure;
}
