abstract class IDaoBase<T> {
  Future<int> create(T entity);

  Future<T?> read(int id);

  Future<int> update(T entity);

  Future<int> delete(int id);
}