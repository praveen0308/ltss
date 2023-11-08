enum Operations {
  add,
  update,
  delete,
  read,
  readAll;

  bool isAdd() => this == Operations.add;
  bool isUpdate() => this == Operations.update;
  bool isDelete() => this == Operations.delete;
  bool isRead() => this == Operations.read;
  bool isReadAll() => this == Operations.readAll;
}
