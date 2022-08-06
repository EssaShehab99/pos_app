abstract class Repository<T> {

  Stream<List<T>> watchAllItems();
  Future<int> insertItem(T employee);
  Future<int> updateItem(T employee);
  Future<int> deleteItem(int id);
  Future<List<T>> findAllItems();

  Future init();
  void close();

}