import 'package:flutter/material.dart';
import 'package:pedalix_app/core/utils/size_utils.dart';
import 'package:pedalix_app/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyMediumMontserrat =>
      theme.textTheme.bodyMedium!.montserrat.copyWith(
        fontSize: 14.fSize,
      );
}

extension on TextStyle {
  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}
