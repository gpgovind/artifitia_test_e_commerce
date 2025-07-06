import 'dart:developer';

import 'package:artifitia_test_e_commerce/core/utils/app_color.dart';
import 'package:artifitia_test_e_commerce/core/utils/responsive_helper.dart';
import 'package:artifitia_test_e_commerce/domain/entities/onboarding.dart';
import 'package:artifitia_test_e_commerce/features/home/view/widgets/nav_bar.dart';
import 'package:artifitia_test_e_commerce/features/onboarding/view_model/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final isLandscape = constraints.maxWidth > constraints.maxHeight;
          final currentPage = ref.watch(onBoardCurrentPageProvider);
          return SafeArea(
            child: Column(
              children: [
                Container(
                  padding: ResponsiveHelper.getResponsivePadding(context).add(
                    EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${currentPage + 1}/3",
                        style: GoogleFonts.montserrat(
                          fontSize: ResponsiveHelper.getResponsiveFontSize(
                              context, 14),
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _navigateToHome(),
                        child: Text(
                          "Skip",
                          style: GoogleFonts.montserrat(
                            fontSize: ResponsiveHelper.getResponsiveFontSize(
                                context, 14),
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      ref
                          .read(onBoardCurrentPageProvider.notifier)
                          .assign(index);
                    },
                    itemCount: ref.watch(onboardingDataProvider).length,
                    itemBuilder: (context, index) {
                      return OnboardingPage(
                        images: ref.watch(onboardingImageProvider)[index],
                        data: ref.watch(onboardingDataProvider)[index],
                        isLandscape: isLandscape,
                      );
                    },
                  ),
                ),
                Container(
                  padding: ResponsiveHelper.getResponsivePadding(context).add(
                    EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  ),
                  child: isLandscape
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildNavigationButtons(),
                          ],
                        )
                      : _buildNavigationButtons(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final currentPage = ref.watch(onBoardCurrentPageProvider);
    final onboardingData = ref.watch(onboardingDataProvider);
    log(onboardingData.length.toString());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentPage > 0
            ? TextButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Text(
                  "Prev",
                  style: GoogleFonts.montserrat(
                    fontSize:
                        ResponsiveHelper.getResponsiveFontSize(context, 14),
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                ),
              )
            : SizedBox(width: ResponsiveHelper.getResponsiveWidth(context, 40)),
        Row(
          children: List.generate(
            onboardingData.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.getResponsiveWidth(context, 3),
              ),
              width: ResponsiveHelper.getResponsiveWidth(context, 6),
              height: ResponsiveHelper.getResponsiveWidth(context, 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index ? AppColors.black : AppColors.grey,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (currentPage < onboardingData.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            } else {
              _navigateToHome();
            }
          },
          child: Text(
            currentPage < onboardingData.length - 1 ? "Next" : "Get Started",
            style: GoogleFonts.montserrat(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
              fontWeight: FontWeight.w600,
              color: AppColors.primaryRed,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToHome() async {
    final user = await ref
        .read(onBoardingViewModelProvider.notifier)
        .getUserFromFirebase();
    if (user != null) {
      ref.read(onBoardingViewModelProvider.notifier).isOnBoardingDone(user);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  const BottomBavCt()),
        (Route<dynamic> route) => false,
      );
    }
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final bool isLandscape;
  final Image images;

  const OnboardingPage(
      {super.key,
      required this.data,
      required this.isLandscape,
      required this.images});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final maxWidth = screenWidth > 600 ? 600.0 : screenWidth;

        return Center(
          child: Container(
            width: maxWidth,
            padding: ResponsiveHelper.getResponsivePadding(context),
            child: isLandscape
                ? Row(
                    children: [
                      Expanded(flex: 1, child: images),
                      SizedBox(width: screenWidth * 0.05),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitle(context),
                            SizedBox(height: screenHeight * 0.03),
                            _buildDescription(context),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      images,
                      SizedBox(height: screenHeight * 0.05),
                      _buildTitle(context),
                      SizedBox(height: screenHeight * 0.02),
                      _buildDescription(context),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      data.title,
      style: GoogleFonts.montserrat(
        fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      textAlign: isLandscape ? TextAlign.left : TextAlign.center,
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      data.description,
      style: GoogleFonts.montserrat(
        fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
        height: 1.5,
      ),
      textAlign: isLandscape ? TextAlign.left : TextAlign.center,
      maxLines: isLandscape ? 4 : 3,
    );
  }
}
