import 'dart:convert';

ResponseCustomer responseFromJson(String str) => ResponseCustomer.fromJson(json.decode(str));

String responseToJson(ResponseCustomer data) => json.encode(data.toJson());

class ResponseCustomer {
    ResponseCustomer({
        required this.message,
        required this.response,
    });

    String message;
    List<dynamic> response;

    factory ResponseCustomer.fromJson(Map<String, dynamic> json) => ResponseCustomer(
        message: json["message"],
        response: List<dynamic>.from(json["response"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "response": List<dynamic>.from(response.map((x) => x)),
    };
}