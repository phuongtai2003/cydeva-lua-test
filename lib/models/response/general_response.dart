import 'package:json_annotation/json_annotation.dart';

part 'general_response.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class GeneralResponse<T> {
  @JsonKey(name: 'status_code')
  final int statusCode;
  final String message;
  final T data;

  GeneralResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GeneralResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$GeneralResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$GeneralResponseToJson(this, toJsonT);
}
