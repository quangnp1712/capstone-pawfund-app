class DebugLogger {
  static void printLog(String message) {
    print('\x1B[32m$message\x1B[0m'); // Màu xanh lá
  }
}
