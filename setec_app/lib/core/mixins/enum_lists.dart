import 'package:flutter/material.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/enums/roles.dart';

mixin EnumLists {
  List<DropdownMenuItem> listRelationship() {
    final list = Relationship.rolesName;
    return list.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList();
  }

  List<DropdownMenuItem> listRoles() => Roles.rolesName
      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
      .toList();
}
