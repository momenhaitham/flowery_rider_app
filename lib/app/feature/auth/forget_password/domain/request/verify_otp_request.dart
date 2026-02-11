class VerifyOtpRequest {
  final String resetCode;

  VerifyOtpRequest({required this.resetCode});

  Map<String, dynamic> toJson() => {
    "resetCode": resetCode,
  };
}
