import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helpers/helpers.dart';

class NoGlowScrollBehavior extends MaterialScrollBehavior {
  const NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class SimpleSliverPersistentHeader extends SliverPersistentHeaderDelegate {
  const SimpleSliverPersistentHeader({
    required this.child,
    required double maxExtent,
    double minExtent = 0,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent;

  final Widget child;

  final double _maxExtent;
  final double _minExtent;

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      child;
}

// class SliverTable<T> extends StatefulWidget {
//   const SliverTable({
//     Key? key,
//     required this.itemBuilder,
//     this.scrollViewWrapper,
//     this.tableWrapper,
//     this.cellPadding,
//     this.columnBackground,
//     this.columnCellPadding,
//     this.columnHeight = 48,
//     this.columnWidths,
//     required this.columns,
//     this.contentPadding,
//     required this.defaultColumnWidth,
//     this.footer,
//     this.footerOffsetToHide,
//     this.header,
//     this.headerOffsetToHide,
//     this.horizontalController,
//     this.itemCount,
//     this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
//     this.paddingTopOnHeaderHide,
//     this.physics,
//     this.rowHeight = 48,
//     this.rowsListenable,
//     this.strokeColor,
//     this.strokeWidth,
//     this.tableIsEmpty,
//     this.tablePadding,
//     this.tableVisibility,
//     this.initialMinScale = 1 / 2,
//     this.verticalController,
//   }) : super(key: key);

//   final List<Widget> Function(int index) itemBuilder;
//   final Widget Function(Widget child)? scrollViewWrapper;
//   final Widget Function(Widget child)? tableWrapper;
//   final EdgeInsets? cellPadding;
//   final Widget? columnBackground;
//   final EdgeInsets? columnCellPadding;
//   final double columnHeight;
//   final Map<int, double>? columnWidths;
//   final List<Widget> columns;
//   final EdgeInsets? contentPadding;
//   final double defaultColumnWidth;
//   final Widget? footer;
//   final double? footerOffsetToHide;
//   final Widget? header;
//   final double? headerOffsetToHide;
//   final ScrollController? horizontalController;
//   final int? itemCount;
//   final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
//   final double? paddingTopOnHeaderHide;
//   final ScrollPhysics? physics;
//   final double rowHeight;
//   final ValueListenable<List<T>>? rowsListenable;
//   final Color? strokeColor;
//   final double? strokeWidth;
//   final Widget? tableIsEmpty;
//   final EdgeInsets? tablePadding;
//   final ValueListenable<bool>? tableVisibility;
//   final ScrollController? verticalController;
//   final double initialMinScale;

//   @override
//   State<SliverTable<T>> createState() => _SliverTableState<T>();
// }

// class _SliverTableState<T> extends State<SliverTable<T>> {
//   double _globalWidth = 0.0;
//   final ValueNotifier<double> _headerHeight = ValueNotifier(0.0);
//   final ValueNotifier<double> _headerPosition = ValueNotifier(0.0);
//   late ScrollController _horizontalController;
//   Drag? _horizontalDrag;
//   ScrollHoldController? _horizontalHold;
//   double _initialScale = 1.0;
//   final double _maxScale = 1.0;
//   double _minScale = 0.2;
//   int _pointers = 0;
//   final Map<Type, GestureRecognizer> _recognizers = <Type, GestureRecognizer>{};
//   final ValueNotifier<double> _scale = ValueNotifier<double>(1.0);
//   double _tableWidth = 0.0;
//   late ScrollController _verticalController;
//   Drag? _verticalDrag;
//   ScrollHoldController? _verticalHold;
//   double _width = 0;

//   @override
//   void dispose() {
//     _horizontalController.removeListener(_handleHorizontalListener);
//     if (widget.horizontalController == null) _horizontalController.dispose();
//     if (widget.verticalController == null) _verticalController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     _horizontalController = widget.horizontalController ?? ScrollController();
//     _verticalController = widget.verticalController ?? ScrollController();
//     _horizontalController.addListener(_handleHorizontalListener);
//     Misc.onLayoutRendered(() {
//       _recognizers[PanGestureRecognizer] = PanGestureRecognizer()
//         ..onDown = _handleDragDown
//         ..onStart = _handleDragStart
//         ..onUpdate = _handleDragUpdate
//         ..onEnd = _handleDragEnd
//         ..onCancel = _handleDragCancel
//         ..minFlingDistance = widget.physics?.minFlingDistance
//         ..minFlingVelocity = widget.physics?.minFlingVelocity
//         ..maxFlingVelocity = widget.physics?.maxFlingVelocity
//         ..velocityTrackerBuilder =
//             ScrollConfiguration.of(context).velocityTrackerBuilder(context)
//         ..dragStartBehavior = DragStartBehavior.start;
//       _recognizers[ScaleGestureRecognizer] = ScaleGestureRecognizer()
//         ..onStart = _handleScaleStart
//         ..onUpdate = _handleScaleUpdate
//         ..dragStartBehavior = DragStartBehavior.start;
//       _calculateSizes();
//       setState(() {});
//     });
//     super.initState();
//   }

//   bool get hasBorder =>
//       widget.strokeWidth != null && widget.strokeColor != null;

//   void _handleHorizontalListener() {
//     final double offset = _horizontalController.offset;
//     if (offset + _globalWidth > _tableWidth) {
//       _horizontalController.jumpTo(offset.clamp(0, _tableWidth - _globalWidth));
//     }
//   }

//   void _calculateRelativeTableWidth() {
//     _tableWidth = _width * _scale.value + (widget.tablePadding?.right ?? 0);
//   }

//   void _calculateSizes() {
//     _globalWidth = context.media.width;
//     _width = widget.tablePadding?.horizontal ?? 0;
//     final int columnsCount = widget.columns.length;
//     for (var i = 0; i < columnsCount; i++) {
//       _width += widget.columnWidths?[i] ?? widget.defaultColumnWidth;
//       if (hasBorder && i < columnsCount) _width += widget.strokeWidth!;
//     }
//     _minScale =
//         _globalWidth / (_width + (widget.tablePadding?.horizontal ?? 0));
//     _scale.value = ((_globalWidth * 2) / _width).clamp(
//       _minScale >= widget.initialMinScale ? _minScale : widget.initialMinScale,
//       _maxScale,
//     );
//     _calculateRelativeTableWidth();
//   }

//   void _handleScaleStart(ScaleStartDetails details) {
//     _initialScale = _scale.value;
//   }

//   void _handleScaleUpdate(ScaleUpdateDetails details) {
//     final double newScale = _initialScale * details.scale;
//     _scale.value = newScale.clamp(_minScale, _maxScale);
//     _calculateRelativeTableWidth();
//     _handleHorizontalListener();
//   }

//   void _handleDragDown(DragDownDetails details) {
//     _horizontalHold =
//         _horizontalController.position.hold(() => _horizontalHold = null);
//     _verticalHold =
//         _verticalController.position.hold(() => _verticalHold = null);
//   }

//   void _handleDragStart(DragStartDetails details) {
//     _horizontalDrag = _horizontalController.position
//         .drag(details, () => _horizontalDrag = null);
//     _verticalDrag =
//         _verticalController.position.drag(details, () => _verticalDrag = null);
//   }

//   void _handleDragUpdate(DragUpdateDetails details) {
//     final Offset delta = details.delta;
//     final Duration? sourceTimeStamp = details.sourceTimeStamp;
//     _horizontalDrag?.update(DragUpdateDetails(
//       sourceTimeStamp: sourceTimeStamp,
//       delta: Offset(delta.dx, 0),
//       primaryDelta: delta.dx,
//       globalPosition: details.globalPosition,
//     ));
//     _verticalDrag?.update(DragUpdateDetails(
//       sourceTimeStamp: sourceTimeStamp,
//       delta: Offset(0, delta.dy),
//       primaryDelta: delta.dy,
//       globalPosition: details.globalPosition,
//     ));
//   }

//   void _handleDragEnd(DragEndDetails details) {
//     final Velocity velocity = details.velocity;
//     final Offset pixelsPerSecond = velocity.pixelsPerSecond;
//     _horizontalDrag?.end(DragEndDetails(
//       velocity: velocity,
//       primaryVelocity: pixelsPerSecond.dx,
//     ));
//     _verticalDrag?.end(DragEndDetails(
//       velocity: velocity,
//       primaryVelocity: pixelsPerSecond.dy,
//     ));
//   }

//   void _handleDragCancel() {
//     _horizontalHold?.cancel();
//     _horizontalDrag?.cancel();
//     _verticalHold?.cancel();
//     _verticalDrag?.cancel();
//   }

//   List<Widget> _castTableRow(List<Widget> children, {bool isColumn = false}) {
//     final int length = children.length;
//     final int last = length - 1;
//     final List<Widget> values = [];
//     final Widget? stroke = hasBorder
//         ? Container(width: widget.strokeWidth, color: widget.strokeColor)
//         : null;
//     for (var i = 0; i < length; i++) {
//       final Widget e = children[i];
//       final double width = widget.columnWidths?[i] ?? widget.defaultColumnWidth;
//       Widget child = Padding(
//         padding: (isColumn ? widget.columnCellPadding : widget.cellPadding) ??
//             Margin.zero,
//         child: e,
//       );
//       if (isColumn) {
//         if (i == 0) {
//           child = CenterLeftAlign(child: child);
//         } else if (i == last) {
//           child = CenterRightAlign(child: child);
//         } else {
//           child = Center(child: child);
//         }
//       }
//       values.addAll([
//         SizedBox(width: width, child: child),
//         if (stroke != null && i != last) stroke,
//       ]);
//     }
//     return values;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final BuildMedia media = context.media;
//     final double height = media.height;
//     final double width = media.width;

//     Widget _sliverRows({required int? itemCount}) {
//       final Decoration decoration = BoxDecoration(
//         border: hasBorder
//             ? Border(
//                 bottom: BorderSide(
//                   color: widget.strokeColor!,
//                   width: widget.strokeWidth!,
//                 ),
//               )
//             : null,
//       );

//       return SliverPadding(
//         padding: widget.contentPadding ?? Margin.zero,
//         sliver: widget.tableIsEmpty != null && (itemCount ?? 0) < 1
//             ? SliverFillViewport(
//                 viewportFraction: height / (height * _scale.value),
//                 delegate: SliverChildListDelegate.fixed([widget.tableIsEmpty!]),
//               )
//             : SliverFixedExtentList(
//                 itemExtent: widget.rowHeight,
//                 delegate: SliverChildBuilderDelegate(
//                   (_, index) {
//                     final items = _castTableRow(widget.itemBuilder(index),
//                         isColumn: true);
//                     return SizedBox(
//                       height: widget.rowHeight,
//                       width: context.media.width,
//                       child: DecoratedBox(
//                         decoration: decoration,
//                         child: ListView.builder(
//                           // controller: ScrollController(
//                           //   initialScrollOffset: _horizontalController.offset,
//                           // ),
//                           physics: const NeverScrollableScrollPhysics(),
//                           scrollDirection: Axis.horizontal,
//                           itemCount: items.length,
//                           itemBuilder: (_, index) {
//                             return items[index];
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                   childCount: itemCount,
//                 ),
//               ),
//       );
//     }

//     final Widget rows = widget.rowsListenable != null
//         ? ValueListenableBuilder<List<T>>(
//             valueListenable: widget.rowsListenable!,
//             builder: (_, value, ___) => _sliverRows(
//               itemCount: value.length,
//             ),
//           )
//         : _sliverRows(itemCount: widget.itemCount);

//     final Widget table = Listener(
//       onPointerUp: (e) => _pointers -= 1,
//       onPointerDown: (e) {
//         _pointers += 1;
//         if (_pointers == 1) {
//           _recognizers[PanGestureRecognizer]?.addPointer(e);
//         }
//         _recognizers[ScaleGestureRecognizer]?.addPointer(e);
//       },
//       behavior: HitTestBehavior.translucent,
//       child: Padding(
//         padding: widget.tablePadding ?? Margin.zero,
//         child: ValueListenableBuilder<double>(
//           valueListenable: _scale,
//           builder: (_, scale, child) {
//             return Transform.scale(
//               scale: scale,
//               alignment: Alignment.topLeft,
//               child: FractionallySizedBox(
//                 heightFactor: height / (height * scale),
//                 widthFactor: width / (width * scale),
//                 alignment: Alignment.topLeft,
//                 child: widget.scrollViewWrapper != null
//                     ? widget.scrollViewWrapper!(child!)
//                     : child,
//               ),
//             );
//           },
//           child: CustomScrollView(
//             controller: _verticalController,
//             physics: NeverScrollableScrollPhysics(
//               parent: widget.physics,
//             ),
//             keyboardDismissBehavior: widget.keyboardDismissBehavior,
//             slivers: [
//               SliverAppBar(
//                 pinned: true,
//                 primary: false,
//                 automaticallyImplyLeading: false,
//                 backgroundColor: context.color.scaffold,
//                 shadowColor: Colors.transparent,
//                 titleSpacing: 0.0,
//                 toolbarHeight: widget.columnHeight,
//                 title: Builder(builder: (context) {
//                   final items = _castTableRow(widget.columns, isColumn: true);
//                   return Stack(children: [
//                     Positioned.fill(
//                       child: widget.columnBackground ?? const SizedBox.shrink(),
//                     ),
//                     SizedBox(
//                       height: widget.columnHeight,
//                       child: ListView.builder(
//                         controller: _horizontalController,
//                         physics: const NeverScrollableScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         itemCount: items.length,
//                         itemBuilder: (_, index) {
//                           return items[index];
//                         },
//                       ),
//                     ),
//                   ]);
//                 }),
//               ),
//               if (widget.tableVisibility != null)
//                 ValueListenableBuilder<bool>(
//                   valueListenable: widget.tableVisibility!,
//                   builder: (_, visible, child) => SliverVisibility(
//                     visible: visible,
//                     sliver: child!,
//                   ),
//                   child: rows,
//                 )
//               else
//                 rows
//             ],
//           ),
//         ),
//       ),
//     );

//     return Stack(children: [
//       if (widget.header != null) ...[
//         Column(children: [
//           AnimatedBuilder(
//             animation: Listenable.merge([_headerHeight, _headerPosition]),
//             builder: (_, __) {
//               final double height = _headerHeight.value;
//               final double lerp =
//                   height > 0 ? (_headerPosition.value / height) : 1;
//               final padding = Misc.lerpDouble(0, height, lerp)
//                   .clamp(widget.paddingTopOnHeaderHide ?? 0.0, double.infinity);
//               return SizedBox(height: padding);
//             },
//           ),
//           Expanded(
//             child: widget.tableWrapper != null
//                 ? widget.tableWrapper!(table)
//                 : table,
//           ),
//         ]),
//         OnScrollHideContent(
//           controller: _verticalController,
//           offsetToHideButton: widget.headerOffsetToHide ?? _headerHeight.value,
//           onSizeChanged: (height) {
//             _headerPosition.value = height;
//             _headerHeight.value = height;
//           },
//           onChanged: (lerp) => _headerPosition.value = lerp,
//           child: widget.header!,
//         ),
//       ] else
//         table,
//       if (widget.footer != null)
//         BottomCenterAlign(
//           child: OnScrollHideContent(
//             onTop: false,
//             controller: _verticalController,
//             offsetToHideButton:
//                 widget.footerOffsetToHide ?? _headerHeight.value,
//             child: widget.footer!,
//           ),
//         ),
//     ]);
//   }
// }

class SliverTable<T> extends StatefulWidget {
  const SliverTable({
    Key? key,
    required this.itemBuilder,
    this.scrollViewWrapper,
    this.tableWrapper,
    this.cellPadding,
    this.columnBackground,
    this.columnCellPadding,
    this.columnHeight = 48,
    this.columnWidths,
    required this.columns,
    this.contentPadding,
    required this.defaultColumnWidth,
    this.footer,
    this.footerOffsetToHide,
    this.header,
    this.headerOffsetToHide,
    this.horizontalController,
    this.itemCount,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.paddingTopOnHeaderHide,
    this.physics,
    this.rowHeight = 48,
    this.rowsListenable,
    this.strokeColor,
    this.strokeWidth,
    this.tableIsEmpty,
    this.tablePadding,
    this.tableVisibility,
    this.initialMinScale = 1 / 2,
    this.verticalController,
  }) : super(key: key);

  final List<Widget> Function(int index) itemBuilder;
  final Widget Function(Widget child)? scrollViewWrapper;
  final Widget Function(Widget child)? tableWrapper;
  final EdgeInsets? cellPadding;
  final Widget? columnBackground;
  final EdgeInsets? columnCellPadding;
  final double columnHeight;
  final Map<int, double>? columnWidths;
  final List<Widget> columns;
  final EdgeInsets? contentPadding;
  final double defaultColumnWidth;
  final Widget? footer;
  final double? footerOffsetToHide;
  final Widget? header;
  final double? headerOffsetToHide;
  final ScrollController? horizontalController;
  final int? itemCount;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final double? paddingTopOnHeaderHide;
  final ScrollPhysics? physics;
  final double rowHeight;
  final ValueListenable<List<T>>? rowsListenable;
  final Color? strokeColor;
  final double? strokeWidth;
  final Widget? tableIsEmpty;
  final EdgeInsets? tablePadding;
  final ValueListenable<bool>? tableVisibility;
  final ScrollController? verticalController;
  final double initialMinScale;

  @override
  State<SliverTable<T>> createState() => _SliverTableState<T>();
}

class _SliverTableState<T> extends State<SliverTable<T>> {
  double _globalWidth = 0.0;
  final ValueNotifier<double> _headerHeight = ValueNotifier(0.0);
  final ValueNotifier<double> _headerPosition = ValueNotifier(0.0);
  late ScrollController _horizontalController;
  Drag? _horizontalDrag;
  ScrollHoldController? _horizontalHold;
  double _initialScale = 1.0;
  final double _maxScale = 1.0;
  double _minScale = 0.2;
  int _pointers = 0;
  final Map<Type, GestureRecognizer> _recognizers = <Type, GestureRecognizer>{};
  final ValueNotifier<double> _scale = ValueNotifier<double>(1.0);
  double _tableWidth = 0.0;
  late ScrollController _verticalController;
  Drag? _verticalDrag;
  ScrollHoldController? _verticalHold;
  double _width = 0;

  @override
  void dispose() {
    _horizontalController.removeListener(_handleHorizontalListener);
    if (widget.horizontalController == null) _horizontalController.dispose();
    if (widget.verticalController == null) _verticalController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _horizontalController = widget.horizontalController ?? ScrollController();
    _verticalController = widget.verticalController ?? ScrollController();
    _horizontalController.addListener(_handleHorizontalListener);
    Misc.onLayoutRendered(() {
      _recognizers[PanGestureRecognizer] = PanGestureRecognizer()
        ..onDown = _handleDragDown
        ..onStart = _handleDragStart
        ..onUpdate = _handleDragUpdate
        ..onEnd = _handleDragEnd
        ..onCancel = _handleDragCancel
        ..minFlingDistance = widget.physics?.minFlingDistance
        ..minFlingVelocity = widget.physics?.minFlingVelocity
        ..maxFlingVelocity = widget.physics?.maxFlingVelocity
        ..velocityTrackerBuilder =
            ScrollConfiguration.of(context).velocityTrackerBuilder(context)
        ..dragStartBehavior = DragStartBehavior.start;
      _recognizers[ScaleGestureRecognizer] = ScaleGestureRecognizer()
        ..onStart = _handleScaleStart
        ..onUpdate = _handleScaleUpdate
        ..dragStartBehavior = DragStartBehavior.start;
      _calculateSizes();
      setState(() {});
    });
    super.initState();
  }

  bool get hasBorder =>
      widget.strokeWidth != null && widget.strokeColor != null;

  void _handleHorizontalListener() {
    final double offset = _horizontalController.offset;
    if (offset + _globalWidth > _tableWidth) {
      _horizontalController.jumpTo(offset.clamp(0, _tableWidth - _globalWidth));
    }
  }

  void _calculateRelativeTableWidth() {
    _tableWidth = _width * _scale.value + (widget.tablePadding?.right ?? 0);
  }

  void _calculateSizes() {
    _globalWidth = context.media.width;
    _width = widget.tablePadding?.horizontal ?? 0;
    final int columnsCount = widget.columns.length;
    for (var i = 0; i < columnsCount; i++) {
      _width += widget.columnWidths?[i] ?? widget.defaultColumnWidth;
      if (hasBorder && i < columnsCount) _width += widget.strokeWidth!;
    }
    _minScale =
        _globalWidth / (_width + (widget.tablePadding?.horizontal ?? 0));
    _scale.value = ((_globalWidth * 2) / _width).clamp(
      _minScale >= widget.initialMinScale ? _minScale : widget.initialMinScale,
      _maxScale,
    );
    _calculateRelativeTableWidth();
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _initialScale = _scale.value;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    final double newScale = _initialScale * details.scale;
    _scale.value = newScale.clamp(_minScale, _maxScale);
    _calculateRelativeTableWidth();
    _handleHorizontalListener();
  }

  void _handleDragDown(DragDownDetails details) {
    _horizontalHold =
        _horizontalController.position.hold(() => _horizontalHold = null);
    _verticalHold =
        _verticalController.position.hold(() => _verticalHold = null);
  }

  void _handleDragStart(DragStartDetails details) {
    _horizontalDrag = _horizontalController.position
        .drag(details, () => _horizontalDrag = null);
    _verticalDrag =
        _verticalController.position.drag(details, () => _verticalDrag = null);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final Offset delta = details.delta;
    final Duration? sourceTimeStamp = details.sourceTimeStamp;
    _horizontalDrag?.update(DragUpdateDetails(
      sourceTimeStamp: sourceTimeStamp,
      delta: Offset(delta.dx, 0),
      primaryDelta: delta.dx,
      globalPosition: details.globalPosition,
    ));
    _verticalDrag?.update(DragUpdateDetails(
      sourceTimeStamp: sourceTimeStamp,
      delta: Offset(0, delta.dy),
      primaryDelta: delta.dy,
      globalPosition: details.globalPosition,
    ));
  }

  void _handleDragEnd(DragEndDetails details) {
    final Velocity velocity = details.velocity;
    final Offset pixelsPerSecond = velocity.pixelsPerSecond;
    _horizontalDrag?.end(DragEndDetails(
      velocity: velocity,
      primaryVelocity: pixelsPerSecond.dx,
    ));
    _verticalDrag?.end(DragEndDetails(
      velocity: velocity,
      primaryVelocity: pixelsPerSecond.dy,
    ));
  }

  void _handleDragCancel() {
    _horizontalHold?.cancel();
    _horizontalDrag?.cancel();
    _verticalHold?.cancel();
    _verticalDrag?.cancel();
  }

  List<Widget> _castTableRow(List<Widget> children, {bool isColumn = false}) {
    final int length = children.length;
    final int last = length - 1;
    final List<Widget> values = [];
    final Widget? stroke = hasBorder
        ? Container(width: widget.strokeWidth, color: widget.strokeColor)
        : null;
    for (var i = 0; i < length; i++) {
      final Widget e = children[i];
      final double width = widget.columnWidths?[i] ?? widget.defaultColumnWidth;
      Widget child = Padding(
        padding: (isColumn ? widget.columnCellPadding : widget.cellPadding) ??
            Margin.zero,
        child: e,
      );
      if (isColumn) {
        if (i == 0) {
          child = CenterLeftAlign(child: child);
        } else if (i == last) {
          child = CenterRightAlign(child: child);
        } else {
          child = Center(child: child);
        }
      }
      values.addAll([
        SizedBox(width: width, child: child),
        if (stroke != null && i != last) stroke,
      ]);
    }
    return values;
  }

  @override
  Widget build(BuildContext context) {
    final BuildMedia media = context.media;
    final double height = media.height;

    Widget _sliverRows({required int? itemCount}) {
      final Decoration decoration = BoxDecoration(
        border: hasBorder
            ? Border(
                bottom: BorderSide(
                  color: widget.strokeColor!,
                  width: widget.strokeWidth!,
                ),
              )
            : null,
      );

      return SliverPadding(
        padding: widget.contentPadding ?? Margin.zero,
        sliver: widget.tableIsEmpty != null && (itemCount ?? 0) < 1
            ? SliverFillViewport(
                viewportFraction: height / (height * _scale.value),
                delegate: SliverChildListDelegate.fixed([widget.tableIsEmpty!]),
              )
            : SliverFixedExtentList(
                itemExtent: widget.rowHeight,
                delegate: SliverChildBuilderDelegate(
                  (_, index) => DecoratedBox(
                    decoration: decoration,
                    child:
                        Row(children: _castTableRow(widget.itemBuilder(index))),
                  ),
                  childCount: itemCount,
                ),
              ),
      );
    }

    final Widget rows = widget.rowsListenable != null
        ? ValueListenableBuilder<List<T>>(
            valueListenable: widget.rowsListenable!,
            builder: (_, value, ___) => _sliverRows(
              itemCount: value.length,
            ),
          )
        : _sliverRows(itemCount: widget.itemCount);

    final Widget table = Listener(
      onPointerUp: (e) => _pointers -= 1,
      onPointerDown: (e) {
        _pointers += 1;
        if (_pointers == 1) {
          _recognizers[PanGestureRecognizer]?.addPointer(e);
        }
        _recognizers[ScaleGestureRecognizer]?.addPointer(e);
      },
      behavior: HitTestBehavior.translucent,
      child: CustomScrollView(
        controller: _horizontalController,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        cacheExtent: _width,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              width: _width,
              child: Padding(
                padding: widget.tablePadding ?? Margin.zero,
                child: ValueListenableBuilder<double>(
                  valueListenable: _scale,
                  builder: (_, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      alignment: Alignment.topLeft,
                      child: FractionallySizedBox(
                        heightFactor: height / (height * scale),
                        alignment: Alignment.topLeft,
                        child: widget.scrollViewWrapper != null
                            ? widget.scrollViewWrapper!(child!)
                            : child,
                      ),
                    );
                  },
                  child: CustomScrollView(
                    controller: _verticalController,
                    physics: NeverScrollableScrollPhysics(
                      parent: widget.physics,
                    ),
                    keyboardDismissBehavior: widget.keyboardDismissBehavior,
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        primary: false,
                        automaticallyImplyLeading: false,
                        backgroundColor: context.color.scaffold,
                        shadowColor: Colors.transparent,
                        titleSpacing: 0.0,
                        toolbarHeight: widget.columnHeight,
                        title: Stack(children: [
                          Positioned.fill(
                            child: widget.columnBackground ??
                                const SizedBox.shrink(),
                          ),
                          Row(
                            children: _castTableRow(
                              widget.columns,
                              isColumn: true,
                            ),
                          ),
                        ]),
                      ),
                      if (widget.tableVisibility != null)
                        ValueListenableBuilder<bool>(
                          valueListenable: widget.tableVisibility!,
                          builder: (_, visible, child) => SliverVisibility(
                            visible: visible,
                            sliver: child!,
                          ),
                          child: rows,
                        )
                      else
                        rows
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Stack(children: [
      if (widget.header != null) ...[
        Column(children: [
          AnimatedBuilder(
            animation: Listenable.merge([_headerHeight, _headerPosition]),
            builder: (_, __) {
              final double height = _headerHeight.value;
              final double lerp =
                  height > 0 ? (_headerPosition.value / height) : 1;
              final padding = Misc.lerpDouble(0, height, lerp)
                  .clamp(widget.paddingTopOnHeaderHide ?? 0.0, double.infinity);
              return SizedBox(height: padding);
            },
          ),
          Expanded(
            child: widget.tableWrapper != null
                ? widget.tableWrapper!(table)
                : table,
          ),
        ]),
        OnScrollHideContent(
          controller: _verticalController,
          offsetToHideButton: widget.headerOffsetToHide ?? _headerHeight.value,
          onSizeChanged: (height) {
            _headerPosition.value = height;
            _headerHeight.value = height;
          },
          onChanged: (lerp) => _headerPosition.value = lerp,
          child: widget.header!,
        ),
      ] else
        table,
      if (widget.footer != null)
        BottomCenterAlign(
          child: OnScrollHideContent(
            onTop: false,
            controller: _verticalController,
            offsetToHideButton:
                widget.footerOffsetToHide ?? _headerHeight.value,
            child: widget.footer!,
          ),
        ),
    ]);
  }
}
