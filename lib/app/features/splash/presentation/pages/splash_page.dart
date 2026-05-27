import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app/constants/app_colors.dart';
import '../../../../../app/constants/app_spacing.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoFade;
  late final Animation<double> _contentFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.6, curve: Curves.easeIn),
      ),
    );
    _contentFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1, curve: Curves.easeIn),
      ),
    );
    unawaited(_controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _logoFade,
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                width: 160,
              ),
            ),
            AppSpacing.gapVerticalLg,
            FadeTransition(
              opacity: _contentFade,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Adisu Serategna',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColors.slate800,
                    ),
                  ),
                  AppSpacing.gapVerticalXxl,
                  const AdisuProgressIndicator.large(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
