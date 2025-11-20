import 'package:objectbox/objectbox.dart';


@Entity()
class Session {
  @Id(assignable: true)
  int id;

  String name;
  String? picUrl;

  String? model;
  double? temperature;
  int? maxTokens;
  @Property(type: PropertyType.date)
  DateTime timestamp;

  Session({
    this.id = 0,
    this.name = '',
    this.picUrl,
    this.model,
    this.temperature,
    this.maxTokens,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

