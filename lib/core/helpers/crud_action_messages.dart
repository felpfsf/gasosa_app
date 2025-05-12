import 'package:gasosa_app/core/enums/crud_action.dart';

String crudActionSuccessVerb(CrudAction action) {
  return switch (action) {
    CrudAction.created => 'criado',
    CrudAction.updated => 'editado',
    CrudAction.deleted => 'excluído',
  };
}

String crudActionErrorVerb(CrudAction? action) {
  return switch (action) {
    CrudAction.created => 'criar',
    CrudAction.updated => 'editar',
    CrudAction.deleted => 'excluir',
    null => 'executar',
  };
}
