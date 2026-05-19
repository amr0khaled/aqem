import 'dart:math';
import 'package:aqem/core/utils/direction_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/qibla_provider.dart';
import '../widgets/compass_view.dart';

class QiblaScreen extends ConsumerStatefulWidget {
  const QiblaScreen({super.key});

  @override
  ConsumerState<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends ConsumerState<QiblaScreen> {
  bool _wasAligned = false;
  bool _isHighlighted = false;
  bool _highlightLocked = false;

  @override
  Widget build(BuildContext context) {
    final qiblaState = ref.watch(qiblaProvider);

    if (qiblaState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (qiblaState.error != null) {
      return Scaffold(body: Center(child: Text(qiblaState.error!)));
    }

    final qiblah = qiblaState.qiblahDirection!;
    final deviceHeading = qiblaState.compassAngle;

    final compassRad = -deviceHeading * pi / 180;

    double angle = qiblah - deviceHeading;
    if (angle > 180) angle -= 360;
    if (angle < -180) angle += 360;

    final arrowRad = angle * pi / 180;
    final isAligned = angle.abs() < 2;

    _handleAlignment(isAligned);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(qiblaState),
              const SizedBox(height: 20),
              CompassView(compassAngle: compassRad, arrowAngle: arrowRad),
              const SizedBox(height: 25),
              _angleCard(qiblah, deviceHeading, qiblaState),
              const SizedBox(height: 12),
              _successCard(isAligned: isAligned, isHighlighted: _isHighlighted),
              const SizedBox(height: 12),
              _tipCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAlignment(bool isAligned) {
    if (isAligned && !_wasAligned && !_highlightLocked) {
      _highlightLocked = true;

      HapticFeedback.vibrate();

      setState(() => _isHighlighted = true);

      Future.delayed(const Duration(milliseconds: 400), () {
        if (!mounted) return;

        setState(() => _isHighlighted = false);

        _highlightLocked = false;
      });
    }

    if (!isAligned) {
      _wasAligned = false;
      _highlightLocked = false;
      _isHighlighted = false;
    }

    _wasAligned = isAligned;
  }

  Widget _header(QiblaState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D7E5E), Color(0xFF0D7E5E), Color(0xFF0A6349)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "اتجاه القبلة",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.arrow_forward, size: 18, color: Colors.white),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            state.city,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _angleCard(
    double qiblaBearing,
    double deviceHeading,
    QiblaState state,
  ) {
    final double displayBearing = (qiblaBearing - deviceHeading + 360) % 360;

    final direction = DirectionUtils.getDirection(displayBearing);

    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${displayBearing.toStringAsFixed(0)}°",
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0D7E5E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                direction,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "المسافة إلى مكة",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${state.distanceKm.toStringAsFixed(0)} كم",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 86, 84, 84),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xFF0D7E5E),
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.near_me_outlined, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _successCard({required bool isAligned, required bool isHighlighted}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlighted
              ? const Color(0xFF0D7E5E)
              : const Color(0x330D7E5E),
          width: isHighlighted ? 2 : 1,
        ),
        gradient: LinearGradient(
          colors: isHighlighted
              ? [const Color(0x400D7E5E), const Color(0xBBE8F5F1)]
              : [const Color(0x1A0D7E5E), const Color(0x80E8F5F1)],
        ),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: isAligned ? const Color(0xFF0D7E5E) : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                isAligned
                    ? "✓ تم تحديد اتجاه القبلة بنجاح"
                    : "قم بمحاذاة الهاتف",
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tipCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0x4DF4E5C2), Color(0x00000000)],
        ),
      ),
      child: const Text(
        "💡 اجعل هاتفك مستوياً للحصول على أفضل دقة",
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
