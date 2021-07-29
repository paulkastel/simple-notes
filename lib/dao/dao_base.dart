abstract class IDaoBase<T> {
  Future<int> create(T entity);

  Future<T?> read(String id);

  Future<int> update(T entity);

  Future<int> delete(String id);
}