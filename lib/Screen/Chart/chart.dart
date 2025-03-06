// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
// class Chart extends StatefulWidget {
//   const Chart({super.key});
//
//   @override
//   State<Chart> createState() => _ChartState();
// }
//
// class _ChartState extends State<Chart> with TickerProviderStateMixin {
//   late AnimationController animationController;
//   @override
//   void initState() {
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//     animationController.forward();
//       super.initState();
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     List<PieModel> model = [
//       PieModel(count: 30000, color: Colors.red.withOpacity(1)),
//       PieModel(count: 5000, color: Colors.blue.withOpacity(1)),
//       PieModel(count: 3000, color: Colors.grey.withOpacity(1)),
//       PieModel(count: 10000, color: Colors.amber.withOpacity(1)),
//       PieModel(count: 2000, color: Colors.green.withOpacity(1)),
//       PieModel(count: 30000, color: Colors.cyan.withOpacity(1)),
//       PieModel(count: 20000, color: Colors.purple.withOpacity(1)),
//     ];
//     return Scaffold(
//       appBar: AppBar(title: Text("Animation Pie Chart")),
//       body: Column(
//         children: [
//           AnimatedBuilder(
//             animation: animationController,
//             builder: (context, child) {
//               if (animationController.value < 0.1) {
//                 return const SizedBox();
//               }
//               return CustomPaint(
//                 size: Size(MediaQuery.of(context).size.width,
//                     MediaQuery.of(context).size.width),
//                 painter: _PieChart(model, animationController.value),
//
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _PieChart extends CustomPainter {
//   final List<PieModel> data;
//   final double value;
//
//   _PieChart(this.data, this.value);
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint circlePaint = Paint()..color = Colors.white;
//     double radius = (size.width / 2) * 0.8;
//     double _startPoint = 0.0;
//     for (int i = 0; i < data.length; i++) {
//       double _count = data[i].count.toDouble();
//       _count = (_count * value + _count) - data[i].count;
//
//       double _startAngle = 2 * math.pi * (_count / 100);
//       double _nextAngle = 2 * math.pi * (_count / 100);
//       circlePaint.color = data[i].color;
//
//       canvas.drawArc(
//           Rect.fromCircle(
//               center: Offset(size.width / 2, size.width / 2), radius: radius),
//           -math.pi / 2 + _startPoint,
//           _nextAngle,
//           true,
//           circlePaint);
//       _startPoint = _startPoint + _startAngle;
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
//
// class PieModel {
//   final int count;
//   final Color color;
//
//   PieModel({
//     required this.count,
//     required this.color,
//   });
// }
