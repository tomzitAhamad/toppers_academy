import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

abstract final class AppAnimations {
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration standard = Duration(milliseconds: 280);
  static const Duration reveal = Duration(milliseconds: 240);

  static const Curve enterCurve = Curves.easeOutCubic;
  static const Curve exitCurve = Curves.easeInCubic;
}

class AppReveal extends StatefulWidget {
  const AppReveal({
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 0.025),
    this.beginScale = 1,
    this.beginOpacity = 0.92,
    this.animateIfInitiallyVisible = true,
    this.duration,
    super.key,
  });

  final Widget child;
  final Duration delay;
  final Offset offset;
  final double beginScale;
  final double beginOpacity;
  final bool animateIfInitiallyVisible;
  final Duration? duration;

  @override
  State<AppReveal> createState() => _AppRevealState();
}

class _AppRevealState extends State<AppReveal>
    with SingleTickerProviderStateMixin {
  late final Key _visibilityKey;
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;
  bool _receivedFirstVisibilityUpdate = false;

  @override
  void initState() {
    super.initState();
    _visibilityKey = ValueKey('reveal-${identityHashCode(this)}');
    final baseDuration = widget.duration ?? AppAnimations.reveal;
    final totalDuration = baseDuration + widget.delay;
    final delayFraction = totalDuration.inMicroseconds > 0
        ? widget.delay.inMicroseconds / totalDuration.inMicroseconds
        : 0.0;
    _controller = AnimationController(vsync: this, duration: totalDuration);
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Interval(delayFraction, 1, curve: AppAnimations.enterCurve),
    );
    _opacity = Tween<double>(
      begin: widget.beginOpacity,
      end: 1,
    ).animate(curved);
    _scale = Tween<double>(begin: widget.beginScale, end: 1).animate(curved);
    _slide = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(curved);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return widget.child;
    }

    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        final isVisible = info.visibleFraction >= 0.12;

        if (!_receivedFirstVisibilityUpdate) {
          _receivedFirstVisibilityUpdate = true;
          if (isVisible && !widget.animateIfInitiallyVisible) {
            _controller.value = 1;
            return;
          }
        }

        if (isVisible && _controller.status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      },
      child: FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _slide,
          child: ScaleTransition(scale: _scale, child: widget.child),
        ),
      ),
    );
  }
}

class AppScrollReveal extends StatelessWidget {
  const AppScrollReveal({
    required this.child,
    this.delay = Duration.zero,
    super.key,
  });

  final Widget child;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return AppReveal(
      delay: delay,
      duration: const Duration(milliseconds: 520),
      offset: const Offset(0, 0.09),
      beginOpacity: 0.25,
      beginScale: 0.98,
      animateIfInitiallyVisible: false,
      child: child,
    );
  }
}

class AppAnimatedNumber extends StatelessWidget {
  const AppAnimatedNumber({
    required this.value,
    required this.style,
    this.decimalPlaces = 0,
    this.prefix = '',
    this.suffix = '',
    this.duration = const Duration(milliseconds: 850),
    this.curve = Curves.easeOutCubic,
    super.key,
  });

  final double value;
  final TextStyle style;
  final int decimalPlaces;
  final String prefix;
  final String suffix;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return Text(
        '$prefix${value.toStringAsFixed(decimalPlaces)}$suffix',
        style: style,
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: duration,
      curve: curve,
      builder: (context, animatedValue, child) {
        return Text(
          '$prefix${animatedValue.toStringAsFixed(decimalPlaces)}$suffix',
          style: style,
        );
      },
    );
  }
}

class AppAnimatedLinearProgress extends StatelessWidget {
  const AppAnimatedLinearProgress({
    required this.value,
    required this.color,
    required this.backgroundColor,
    this.height = 8,
    this.borderRadius = 20,
    this.duration = const Duration(milliseconds: 850),
    super.key,
  });

  final double value;
  final Color color;
  final Color backgroundColor;
  final double height;
  final double borderRadius;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final target = value.clamp(0.0, 1.0);
    final effectiveDuration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : duration;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: target),
      duration: effectiveDuration,
      curve: AppAnimations.enterCurve,
      builder: (context, animatedValue, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: LinearProgressIndicator(
            value: animatedValue,
            minHeight: height,
            backgroundColor: backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        );
      },
    );
  }
}

class AppAnimatedCircularProgress extends StatelessWidget {
  const AppAnimatedCircularProgress({
    required this.value,
    required this.color,
    required this.backgroundColor,
    this.strokeWidth = 10,
    this.duration = const Duration(milliseconds: 850),
    super.key,
  });

  final double value;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final target = value.clamp(0.0, 1.0);
    final effectiveDuration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : duration;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: target),
      duration: effectiveDuration,
      curve: AppAnimations.enterCurve,
      builder: (context, animatedValue, child) {
        return CircularProgressIndicator(
          value: animatedValue,
          strokeWidth: strokeWidth,
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        );
      },
    );
  }
}

class AppAnimatedText extends StatelessWidget {
  const AppAnimatedText({
    required this.value,
    required this.style,
    this.textAlign,
    this.duration = AppAnimations.standard,
    super.key,
  });

  final String value;
  final TextStyle style;
  final TextAlign? textAlign;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final effectiveDuration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : duration;

    return AnimatedSwitcher(
      duration: effectiveDuration,
      switchInCurve: AppAnimations.enterCurve,
      switchOutCurve: AppAnimations.exitCurve,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.35),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Text(
        value,
        key: ValueKey(value),
        textAlign: textAlign,
        style: style,
      ),
    );
  }
}

class AppPageTransitionsBuilder extends PageTransitionsBuilder {
  const AppPageTransitionsBuilder({
    this.transitionType = SharedAxisTransitionType.horizontal,
  });

  final SharedAxisTransitionType transitionType;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.isFirst || MediaQuery.disableAnimationsOf(context)) {
      return child;
    }

    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: transitionType,
      fillColor: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }
}

class AppFadeSlideTransition extends StatelessWidget {
  const AppFadeSlideTransition({
    required this.visible,
    required this.child,
    this.beginOffset = const Offset(0.025, 0),
    super.key,
  });

  final bool visible;
  final Widget child;
  final Offset beginOffset;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final duration = reduceMotion ? Duration.zero : AppAnimations.standard;

    return AnimatedSlide(
      offset: visible ? Offset.zero : beginOffset,
      duration: duration,
      curve: AppAnimations.enterCurve,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: duration,
        curve: AppAnimations.enterCurve,
        child: child,
      ),
    );
  }
}
