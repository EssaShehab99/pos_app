import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Repository<T> {

  Stream<List<T>> watchAllItems();
  Future<T> insertItem(T object);
  Future<void> updateItem(T object);
  Future<void> deleteItem(int id);
  Future<List<T>> findAllItems();

  Future init();
  void close();

}