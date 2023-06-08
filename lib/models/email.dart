import 'dart:convert';

class Email {
  Email({
    required this.to,
    required this.cc,
    required this.subject,
    required this.body,
    required this.attachment,
  });

  String to;
  String cc;
  String subject;
  String body;
  List<String> attachment;

  factory Email.fromJson(String str) => Email.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Email.fromMap(Map<String, dynamic> json) => Email(
        to: json["to"],
        cc: json["cc"],
        subject: json["subject"],
        body: json["body"],
        attachment: List<String>.from(json["attachment"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "to": to,
        "cc": cc,
        "subject": subject,
        "body": body,
        "attachment": List<dynamic>.from(attachment.map((x) => x)),
      };
}
