import 'package:dio/dio.dart';
import 'package:neurocare_app/core/constants/api_constants.dart';
import 'package:neurocare_app/core/services/storage_service.dart';

/// API Client wrapper around Dio for HTTP requests
class ApiClient {
  final Dio _dio;
  final StorageService _storageService;

  ApiClient(this._storageService)
      : _dio = Dio(BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: ApiConstants.connectionTimeout,
          receiveTimeout: ApiConstants.receiveTimeout,
          sendTimeout: ApiConstants.sendTimeout,
          headers: {
            'Content-Type': ApiConstants.applicationJson,
            'Accept': ApiConstants.applicationJson,
          },
        )) {
    _setupInterceptors();
  }

  /// Setup Dio interceptors for authentication and error handling
  void _setupInterceptors() {
    _dio.interceptors.addAll([
      // Request interceptor for authentication
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add authentication token if available
          final token = _storageService.getAuthToken();
          if (token != null) {
            options.headers[ApiConstants.authorization] =
                '${ApiConstants.bearer} $token';
          }

          // Add language header if needed
          final language = _storageService.getLanguage() ?? 'en';
          options.headers['Accept-Language'] = language;

          return handler.next(options);
        },
        onError: (error, handler) async {
          // Handle token expiration
          if (error.response?.statusCode == 401) {
            // Clear stored token
            await _storageService.removeAuthToken();
            // TODO: Navigate to login screen or refresh token
          }

          return handler.next(error);
        },
      ),

      // Logging interceptor (only in debug mode)
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => print('[API] $object'),
      ),
    ]);
  }

  /// GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Upload file
  Future<Response> uploadFile(
    String path,
    String filePath, {
    String method = 'POST',
    Map<String, dynamic>? data,
    String fileField = 'file',
    String? filename,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    final formData = FormData.fromMap({
      fileField: await MultipartFile.fromFile(
        filePath,
        filename: filename,
      ),
      ...?data,
    });

    final options = Options(
      method: method,
      contentType: ApiConstants.multipartFormData,
    );

    return _dio.request(
      path,
      data: formData,
      options: options,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }

  /// Download file
  Future<Response> downloadFile(
    String url,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.download(
      url,
      savePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      queryParameters: queryParameters,
    );
  }

  /// Get Dio instance for advanced usage
  Dio get dio => _dio;

  /// Update base URL
  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  /// Add custom headers
  void addHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  /// Remove headers
  void removeHeaders(List<String> headerKeys) {
    for (final key in headerKeys) {
      _dio.options.headers.remove(key);
    }
  }

  /// Clear all headers
  void clearHeaders() {
    _dio.options.headers.clear();
  }
}
