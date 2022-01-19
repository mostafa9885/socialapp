

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void toast ({
  required String message,
  required ToastState state,
  required context,
}) => showToast(
  message,
  context: context,
  animation: StyledToastAnimation.slideFromBottomFade,
  reverseAnimation: StyledToastAnimation.fade,
  position: StyledToastPosition.bottom,
  animDuration: const Duration(seconds: 3),
  duration: const Duration(seconds: 6),
  curve: Curves.easeOutCirc,
  reverseCurve: Curves.easeInOutQuart,
  backgroundColor: chooseToastColor(state),
  borderRadius: const BorderRadius.all(Radius.circular(25)),
);

enum ToastState {SUCCESS, ERROR, WARNING}

Color? chooseToastColor (ToastState state)
{

  Color? color;

  switch (state)
  {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.redAccent;
      break;
    case ToastState.WARNING:
      color = Colors.grey;
      break;

  }
  return color;
}