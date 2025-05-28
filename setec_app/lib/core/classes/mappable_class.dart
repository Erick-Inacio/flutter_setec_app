abstract class Mappable<DTO> {
  DTO toDTO();
}

abstract class DTOConvertible<D> {
  D toDomain();
}
