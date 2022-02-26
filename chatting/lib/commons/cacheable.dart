class Cacheable<T> {
  final T data;
  final bool isFromCache;

  const Cacheable({required this.data, required this.isFromCache});

  const Cacheable.cached(this.data): isFromCache = true;

  const Cacheable.remote(this.data): isFromCache = false;

  Cacheable<R> map<R>(R Function(T t) toElement) =>
      Cacheable(data: toElement(data), isFromCache: isFromCache);
}
