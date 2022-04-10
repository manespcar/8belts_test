import 'package:belts_test/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ScanWidget extends StatelessWidget {
  const ScanWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.black.withOpacity(0.5),
                strokeWidth: 3,
              ),
              const SizedBox(height: 20),
              Text(context.l10n.marsFloorPageScanningFloor),
            ],
          ),
        ),
      ),
    );
  }
}
