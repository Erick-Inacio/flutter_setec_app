import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';

@JsonEnum()
enum Roles {
  @JsonValue('admin')
  admin("Administrador"),

  @JsonValue('student')
  student("Estudante"),

  @JsonValue('commission')
  commission("Comissão"), 

  @JsonValue('speaker')
  speaker("Palestrante");

  final String displayName;
  const Roles(this.displayName);

  static Logger _logger = Logger();

  static List<String> rolesName = Roles.values.map((role) => role.displayName).toList();


  static Roles fromString(String role) {
    try {
      return Roles.values.firstWhere(
        (e) => e.name.toLowerCase() == role.toLowerCase(),
        orElse: () => Roles.student,
      );
    } catch (e) {
      _logger.e("Erro ao buscar Role: $e");
      return Roles.student;
    }
  }

  static Roles? fromNameEnum(String name) {
    try {
      return Roles.values.firstWhere(
        (e) => e.displayName.toLowerCase() == name.toLowerCase(),
        orElse: () => Roles.student,
      );
    } catch (e) {
      _logger.e("Erro ao buscar Role: $e");
      return null;
    }
  }
}
