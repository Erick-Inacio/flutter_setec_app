import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';

@JsonEnum()
enum Relationship {
  @JsonValue('EXALUNO')
  exaluno('Ex-aluno'),

  @JsonValue('ALUNO')
  aluno('Aluno'),

  @JsonValue('PROFESSOR')
  professor('Professor'),

  @JsonValue('COORDENADOR')
  coordenador('Coordenador'),

  @JsonValue('SEMRELACAO')
  semrelacao('Sem relação');

  final String displayName;
  const Relationship(this.displayName);

  static final Logger _logger = Logger();

  static List<String> rolesName = Relationship.values.map((role) => role.displayName).toList();

  static Relationship fromString(String role) {
    try {
      return Relationship.values.firstWhere(
        (e) => e.name.toLowerCase() == role.toLowerCase(),
        orElse: () => Relationship.aluno,
      );
    } catch (e) {
      _logger.e("Erro ao buscar Role: $e");
      return Relationship.aluno;
    }
  }

  static Relationship? fromNameEnum(String name) {
    try {
      return Relationship.values.firstWhere(
        (e) => e.displayName.toLowerCase() == name.toLowerCase(),
        orElse: () => Relationship.aluno,
      );
    } catch (e) {
      _logger.e("Erro ao buscar Role: $e");
      return null;
    }
  }
}
