import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

Widget buildGaugeCard({
  required String title,
  required double value,
  required double min,
  required double max,
  required String unit,
  required double initialValue,
  required double finalValue,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: AnimatedRadialGauge(
            value: value,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
            axis: GaugeAxis(
              min: min,
              max: max,
              segments: [
                GaugeSegment(from: min, to: max, color: Colors.grey.shade300),
              ],
              style: const GaugeAxisStyle(
                thickness: 10,
                segmentSpacing: 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "${value.toStringAsFixed(2)} $unit",
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 5),
        Text(
          "From $initialValue to $finalValue",
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    ),
  );
}
