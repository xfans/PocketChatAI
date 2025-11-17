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

  // Helper constructor for creating user messages
  Message.user({
    required String content,
    required int sessionId,
    DateTime? timestamp,
  }) : this(
         role: MessageRoleEnum.user.name,
         sessionId: sessionId,
         aiProviderId: '',
         contentParts: content,
         generating: 'false',
         timestamp: timestamp,
       );

  // Helper constructor for creating AI messages
  Message.ai({
    required String content,
    required int sessionId,
    DateTime? timestamp,
  }) : this(
         role: MessageRoleEnum.assistant.name,
         sessionId: sessionId,
         aiProviderId: 'default',
         contentParts: content,
         generating: 'false',
         timestamp: timestamp,
       );

  // Helper constructor for creating system messages
  Message.system({
    required String content,
    required int sessionId,
    DateTime? timestamp,
  }) : this(
         role: MessageRoleEnum.system.name,
         sessionId: sessionId,
         aiProviderId: '',
         contentParts: content,
         generating: 'false',
         timestamp: timestamp,
       );
}
