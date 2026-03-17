abstract class ApiConsumer {
  Future get(String path, {dynamic data, Map<String, dynamic>? queryParams});

  Future put(String path, {dynamic data, Map<String, dynamic>? queryParams, bool isFormData = false});

  Future post(String path, {dynamic data, Map<String, dynamic>? queryParams, bool isFormData = false});

  Future patch(String path, {dynamic data, Map<String, dynamic>? queryParams, bool isFormData = false});

  Future delete(String path, {dynamic data, Map<String, dynamic>? queryParams, bool isFormData = false});
}
