abstract class Repository<T> {

  Stream<List<T>> watchAllItems();
  Future<T> insertItem(T object);
  Future<void> updateItem(T object);
  Future<void> deleteItem(String id);
  Future<List<T>> findAllItems();
  Future<T?> findItemById(String id);
  Future init(String companyUUid);
  void close();

}