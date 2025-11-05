import 'package:objectbox/objectbox.dart';

@Entity()
class Message {
  @Id()
  int id = 0;

  String content;
  bool isUserMessage;
  @Property(type: PropertyType.date)
  DateTime timestamp;

  Message({
    this.id = 0,
    required this.content,
    required this.isUserMessage,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
