import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_menu_poc/ui/routing/navigation_stack_item.dart';
import 'package:restaurant_menu_poc/ui/routing/stack.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/device_configuration.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_image_asset.dart';

class SplashWeb extends ConsumerStatefulWidget {
  const SplashWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashWeb> createState() => _SplashWebState();
}

class _SplashWebState extends ConsumerState<SplashWeb> {
  ///Init
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 3000), () {
        if (mounted) {
          setNavigationRedirection();
        }
      });
    });
  }

  ///Dispose
  @override
  void dispose() {
    super.dispose();
  }

  ///Build
  @override
  Widget build(BuildContext context) {
    webDeviceConfiguration(context);
    return Scaffold(
      body: Center(
        child: CommonImageAsset(
          strIcon: AppAssets.icSplash,
          height: 145.h,
          width: 135.w,
        ),
      ),
    );
  }

  /// Set Navigation Redirection
  setNavigationRedirection() {
    /// Redirect to Home Screen
    ref.read(navigationStackController).pushAndRemoveAll(
          const NavigationStackItem.home(),
        );
  }
}
