import 'package:objectbox/objectbox.dart';


@Entity()
class Session {
  @Id(assignable: true)
  String id = '';

  String name;
  String? picUrl;

  String? model;
  double? temperature;
  int? maxTokens;

  Session({
    this.id = '',
    this.name = '',
    this.picUrl,
    this.model,
    this.temperature,
    this.maxTokens,
  });
}

