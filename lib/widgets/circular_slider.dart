import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class CircularSlider extends StatelessWidget {
  final Function(double) onChanged;
  final double pointerValue;

  const CircularSlider({super.key, required this.onChanged, required this.pointerValue});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 36,
          startAngle: 270,
          endAngle: 270,
          pointers: <GaugePointer>[
            MarkerPointer(
              value: pointerValue,
              enableDragging: true,
              markerWidth: 30,
              markerHeight: 30,
              color: Theme.of(context).colorScheme.primary,
              markerType: MarkerType.circle,
              onValueChanged: onChanged,
            ),
          ],
          ranges: <GaugeRange>[
            GaugeRange(
              startValue:0,
              endValue: pointerValue)],
          showTicks: false,
          showLabels: false,
        ),
      ],
    );
  }
}
