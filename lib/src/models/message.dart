import 'package:objectbox/objectbox.dart';

enum MessageRoleEnum { system, user, assistant }

@Entity()
class Message {
  @Id()
  int id = 0;

  String role;
  int sessionId;

  String aiProviderId;
  String contentParts;
  String generating;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  Message({
    required this.role,
    required this.sessionId,
    required this.aiProviderId,
    required this.contentParts,
    required this.generating,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
