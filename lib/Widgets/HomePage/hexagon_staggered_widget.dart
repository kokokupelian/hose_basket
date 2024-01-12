import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hose_basket/Widgets/HomePage/animated_hexagon.dart';

class HexagonStaggeredWidget extends StatefulWidget {
  final double scrollOffset;
  final List<String> data;
  const HexagonStaggeredWidget(
      {super.key, required this.scrollOffset, required this.data});

  @override
  State<HexagonStaggeredWidget> createState() => _HexagonStaggeredWidgetState();
}

class _HexagonStaggeredWidgetState extends State<HexagonStaggeredWidget> {
  Widget _text(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AutoSizeText(
        text,
        minFontSize: 10,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 10),
        wrapWords: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 11,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 3,
          mainAxisCellCount: 4,
          child: FittedBox(
            child: AnimatedHexagon(
                size: const Size(100, 100),
                scrollOffset: widget.scrollOffset,
                child: _text(widget.data[0])),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 5,
          child: FittedBox(
            alignment: Alignment.bottomRight,
            child: AnimatedHexagon(
              size: const Size(100, 100),
              scrollOffset: widget.scrollOffset,
              child: _text(widget.data[2]),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 4,
          child: FittedBox(
            alignment: Alignment.topCenter,
            child: AnimatedHexagon(
              size: const Size(100, 100),
              scrollOffset: widget.scrollOffset,
              child: _text(widget.data[3]),
            ),
          ),
        ),
        const StaggeredGridTile.count(
            crossAxisCellCount: 3, mainAxisCellCount: 1, child: SizedBox()),
        const StaggeredGridTile.count(
            crossAxisCellCount: 4, mainAxisCellCount: 1, child: SizedBox()),
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 5,
          child: FittedBox(
            alignment: Alignment.topLeft,
            child: AnimatedHexagon(
              size: const Size(100, 100),
              scrollOffset: widget.scrollOffset,
              child: _text(widget.data[4]),
            ),
          ),
        ),
        const StaggeredGridTile.count(
            crossAxisCellCount: 4, mainAxisCellCount: 1, child: SizedBox()),
        StaggeredGridTile.count(
          crossAxisCellCount: 3,
          mainAxisCellCount: 4,
          child: FittedBox(
            alignment: Alignment.topLeft,
            child: AnimatedHexagon(
              size: const Size(100, 100),
              scrollOffset: widget.scrollOffset,
              child: _text(widget.data[1]),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 4,
          child: FittedBox(
            alignment: Alignment.bottomRight,
            child: AnimatedHexagon(
              size: const Size(100, 100),
              scrollOffset: widget.scrollOffset,
              child: _text(widget.data[5]),
            ),
          ),
        ),
        const StaggeredGridTile.count(
            crossAxisCellCount: 3, mainAxisCellCount: 1, child: SizedBox()),
      ],
    );
  }
}
