import 'package:casino_test/core/test/test_util.dart';
import 'package:flutter/material.dart';

///[SafeProgressIndicationFactory]  is used to create a safe progress indication
///widget that works for golden test
class SafeProgressIndicatorFactory {
  static const _testValue = 3 / 8;

  const SafeProgressIndicatorFactory._();

  static CircularProgressIndicator adaptive() {
    return TestUtil.isTest
        ? const CircularProgressIndicator.adaptive(
            value: _testValue,
          )
        : const CircularProgressIndicator();
  }
}
