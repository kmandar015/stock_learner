import 'dart:developer';

import 'package:sentry_flutter/sentry_flutter.dart';

class SentryHelper {
  final dynamic exception;
  final dynamic stackTrace;

  SentryHelper({this.exception, this.stackTrace});

  Future<void> report() async {
    // Print the exception and stack trace to the console
    log(exception);
    log(stackTrace);

    // Capture the exception using Sentry's Flutter SDK
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }
}
