import 'package:artifitia_test_e_commerce/core/utils/app_color.dart';
import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:artifitia_test_e_commerce/core/utils/shared_pref_helper.dart';
import 'package:artifitia_test_e_commerce/features/auth/view/auth_view.dart';
import 'package:artifitia_test_e_commerce/features/home/view/widgets/nav_bar.dart';
import 'package:artifitia_test_e_commerce/features/onboarding/view_model/onboarding_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_view.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    _navigateToOnboarding();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

void _navigateToOnboarding() async {
  await Future.delayed(const Duration(milliseconds: 3000));

  final sharedPref = await SharedPreferences.getInstance();
  final userPrefs = await ref
      .read(onBoardingViewModelProvider.notifier)
      .getUserFromFirebase();

  // If username is not found in shared preferences, user is not logged in
  if (mounted && SharedPrefHelper(sharedPref).userEmail == null) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthView()),
    );
    return; // Important: Stop further execution
  }

  // User is logged in, check if new user flag is set
  if (mounted && userPrefs != null && userPrefs.isNewUser == true) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
    return;
  }

  if (mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  const BottomBavCt()),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final isLandscape = constraints.maxWidth > constraints.maxHeight;

          return Center(
            child: Padding(
              padding: ResponsiveHelper.getResponsivePadding(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: isLandscape ? 2 : 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: ResponsiveHelper.getResponsiveFontSize(
                                  context, 28),
                              fontWeight: FontWeight.w600,
                            ),
                            children: const [
                              TextSpan(
                                text: 's',
                                style: TextStyle(color: AppColors.black),
                              ),
                              TextSpan(
                                text: 'ho',
                                style: TextStyle(color: AppColors.primaryRed),
                              ),
                              TextSpan(
                                text: 'pywell',
                                style: TextStyle(color: AppColors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          width:
                              ResponsiveHelper.getResponsiveWidth(context, 50),
                          height: screenHeight * 0.005,
                          decoration: BoxDecoration(
                            color: AppColors.primaryRed,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: isLandscape ? 1 : 2,
                    child: SizedBox(height: screenHeight * 0.05),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width:
                              ResponsiveHelper.getResponsiveWidth(context, 200),
                          height: screenHeight * 0.005,
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AnimatedBuilder(
                              animation: _progressAnimation,
                              builder: (context, child) {
                                return Container(
                                  width: ResponsiveHelper.getResponsiveWidth(
                                          context, 200) *
                                      _progressAnimation.value,
                                  height: screenHeight * 0.005,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryRed,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
