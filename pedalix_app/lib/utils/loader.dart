import 'package:flutter/material.dart';

class OverlayLoaderWithAppIcon extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String appIconPath;
  final double appIconSize;
  final double borderRadius;
  final double overlayOpacity;
  final Color? circularProgressColor;
  final Color? overlayBackgroundColor;

  OverlayLoaderWithAppIcon({
    required this.isLoading,
    required this.child,
    required this.appIconPath,
    this.appIconSize = 50,
    this.borderRadius = 15,
    this.overlayOpacity = 1,
    this.circularProgressColor,
    this.overlayBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        isLoading
            ? Opacity(
                opacity: overlayOpacity,
                child: Container(
                  decoration: BoxDecoration(
                    color: overlayBackgroundColor ?? Colors.black54,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: appIconSize,
                          height: appIconSize,
                          child: Image.asset('assets/Mask_group.png'),
                        ),
                        SizedBox(height: 20),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              circularProgressColor ?? Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
