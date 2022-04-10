import 'package:belts_test/constants/constants.dart';
import 'package:belts_test/mars_floor/components/stone_widget.dart';
import 'package:belts_test/mars_floor/model/tile.dart';
import 'package:flutter/material.dart';

class FloorWidget extends StatelessWidget {
  const FloorWidget({Key? key, required this.tiles}) : super(key: key);

  final List<List<Tile>> tiles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxSizeFloor,
      height: maxSizeFloor,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 1,
          crossAxisCount: maxRows,
          mainAxisSpacing: 1,
          mainAxisExtent: 40,
        ),
        itemCount: maxRows * maxColumns,
        itemBuilder: (BuildContext ctx, index) {
          int x, y = 0;
          x = (index / maxRows).floor();
          y = index % maxColumns;
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: !tiles[x][y].isEmpty ? const StoneWidget() : Container(),
          );
        },
      ),
    );
  }
}
