enum HttpRequest {
  get("get"),
  post("post"),
  delete("delete"),
  put("put");

  const HttpRequest(this.key);
  final String key;
}
