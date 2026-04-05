import 'package:get/get.dart';

import 'package:mobile/routes/app_routes.dart';

import 'package:mobile/modules/auth/views/login_view.dart';
import 'package:mobile/modules/auth/views/register_view.dart';
import 'package:mobile/modules/auth/bindings/auth_binding.dart';

import 'package:mobile/modules/home/views/home_view.dart';
import 'package:mobile/modules/home/bindings/home_binding.dart';

import 'package:mobile/modules/submissions/views/submissions_view.dart';
import 'package:mobile/modules/submissions/bindings/submission_binding.dart';

import 'package:mobile/modules/profile/views/profile_view.dart';
import 'package:mobile/modules/profile/bindings/profile_binding.dart';

import 'package:mobile/modules/community/views/community_view.dart';
import 'package:mobile/modules/community/bindings/community_binding.dart';

import 'package:mobile/modules/cabinet/views/cabinet_view.dart';
import 'package:mobile/modules/cabinet/bindings/cabinet_binding.dart';

// Placeholders for remaining modules
import 'package:flutter/material.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.SUBMISSIONS,
      page: () => const SubmissionsView(),
      binding: SubmissionBinding(),
    ),
    GetPage(
      name: AppRoutes.DIAGNOSTICS,
      page: () => const Scaffold(body: Center(child: Text('Diagnostics View Placeholder'))),
    ),
    GetPage(
      name: AppRoutes.LAWS,
      page: () => const Scaffold(body: Center(child: Text('Laws View Placeholder'))),
    ),
    GetPage(
      name: AppRoutes.COMMUNITY,
      page: () => const CommunityView(),
      binding: CommunityBinding(),
    ),
    GetPage(
      name: AppRoutes.CABINET,
      page: () => const CabinetView(),
      binding: CabinetBinding(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
