part of 'extension.dart';

///
/// Extension Method for the [Align] Widget
///
extension AlignX on Widget {
  Align alignAtBottomCenter({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: AlignmentDirectional.bottomCenter,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtCenter({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtCenterRight({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: AlignmentDirectional.centerEnd,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtTopLeft({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: AlignmentDirectional.topStart,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtBottomLeft({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: AlignmentDirectional.bottomStart,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtBottomRight({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: AlignmentDirectional.bottomEnd,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtCenterLeft({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: AlignmentDirectional.centerStart,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtTopCenter({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: AlignmentDirectional.topCenter,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignAtTopRight({
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: AlignmentDirectional.topEnd,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );

  Align alignXY(
    double x,
    double y, {
    Key? key,
    double? heightFactor,
    double? widthFactor,
  }) =>
      Align(
        key: key,
        alignment: AlignmentDirectional(x, y),
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        child: this,
      );
}
