import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_application/core/domain/container/app_container.dart';
import 'package:travel_application/features/aboutApp/presentation/about_application.dart';
import 'package:travel_application/features/auth/presentation/auth_page.dart';
import 'package:travel_application/features/auth/presentation/auth_vm.dart';
import 'package:travel_application/features/auth/presentation/email_address_verification.dart';
import 'package:travel_application/features/cities/presentation/add_comment_page.dart';
import 'package:travel_application/features/cities/presentation/add_comment_vm.dart';
import 'package:travel_application/features/cities/presentation/cities_detail_pade.dart';
import 'package:travel_application/features/cities/presentation/cities_list_page.dart';
import 'package:travel_application/features/cities/presentation/cities_list_vm.dart';
import 'package:travel_application/features/cities/presentation/detail_page.dart';
import 'package:travel_application/features/cities/presentation/list_page.dart';
import 'package:travel_application/features/cities/presentation/place_favorite_page.dart';
import 'package:travel_application/features/cities/presentation/place_favorite_vm.dart';
import 'package:travel_application/features/cities/provider/favorite_provider.dart';
import 'package:travel_application/features/currency/presentation/currency_page.dart';
import 'package:travel_application/features/home/presentation/home_page.dart';
import 'package:travel_application/features/init/presentation/init_page.dart';
import 'package:travel_application/features/init/presentation/init_vm.dart';
import 'package:travel_application/features/profile/presentation/page/editing_profile_page.dart';
import 'package:travel_application/features/profile/presentation/page/profile_page.dart';
import 'package:travel_application/features/profile/presentation/page/profile_vm.dart';
import 'package:travel_application/features/recovery/presentation/forgot_password.dart';
import 'package:travel_application/features/recovery/presentation/password_reset.dart';
import 'package:travel_application/features/recovery/presentation/recovery_vm.dart';
import 'package:travel_application/features/weather/presentation/weather_page.dart';

abstract class AppRouteList {
  static const init = '/init';

  static const auth = '/auth';

  static const _emailAddressVerificationPagePath =
      'emailAddressVerificationPage';
  static const emailAddressVerificationPage =
      '$auth/$_emailAddressVerificationPagePath';

  static const _forgotPasswordPath = 'forgotPassword';
  static const forgotPassword = '$auth/$_forgotPasswordPath';

  static const _passwordResetPagePath = 'passwordResetPage';
  static const passwordResetPage = '$auth/$_passwordResetPagePath';

  static const citiesListPage = '/citiesListPage';

  static const _currencyPagePath = 'currency';
  static const currencyPage = '$citiesListPage/$_currencyPagePath';

  static const _weatherPath = 'weather';
  static const weather = '$citiesDetailPage/$_weatherPath';

  static const _listPagePath = 'list';
  static const listPage = '$citiesDetailPage/$_listPagePath';

  static const _detailPagePath = 'detail';
  static const detailPage = '$citiesDetailPage/$_listPagePath/$_detailPagePath';
  static const _addCommentPagePath = 'addCommentPage';
  static const addCommentPage =
      '$citiesDetailPage/$_listPagePath/$_detailPagePath/$_addCommentPagePath';
  static const _addCommentPageFavoritePath = 'addCommentPage';
  static const addCommentFavoritePage =
      '$placeFavoritePage/$_detailPageFavoritePath/$_addCommentPageFavoritePath';
  static const _detailPageFavoritePath = 'detail';
  static const detailPageFavorite =
      '$placeFavoritePage/$_detailPageFavoritePath';

  static const _citiesDetailPagePath = 'detailPage';
  static const citiesDetailPage = '$citiesListPage/$_citiesDetailPagePath';

  static const _aboutApplicationPath = 'aboutApplication';
  static const aboutApplication = '$citiesListPage/$_aboutApplicationPath';

  static const placeFavoritePage = '/placeFavoritePage';

  static const profilePage = '/profilePage';

  static const _editingProfilePagePath = 'editingProfilePage';
  static const editingProfilePage = '$profilePage/$_editingProfilePagePath';
}

abstract class AppRouterConfig {
  String name = '';
  static final instance = GoRouter(
    initialLocation: AppRouteList.init,
    routes: [
      GoRoute(
        path: AppRouteList.init,
        builder: (context, state) => const InitPage(
          vm: InitViewModel(),
        ),
      ),
      GoRoute(
        path: AppRouteList.auth,
        builder: (context, state) {
          return AuthPage(
            vm: AuthViewModel(
              settingService: AppContainer().serviceScope.settingsService,
            ),
          );
        },
        routes: [
          GoRoute(
            path: AppRouteList._emailAddressVerificationPagePath,
            builder: (context, state) => EmailAddressVerificationPage(
              vm: AuthViewModel(
                settingService: AppContainer().serviceScope.settingsService,
              ),
            ),
          ),
          GoRoute(
            path: AppRouteList._forgotPasswordPath,
            builder: (context, state) {
              return ForgotPasswordPage(
                vm: RecoveryViewModel(
                  authRepository: AppContainer().repositoryScope.authRepository,
                  settingService: AppContainer().serviceScope.settingsService,
                ),
              );
            },
          ),
          GoRoute(
            path: AppRouteList._passwordResetPagePath,
            builder: (context, state) {
              return PasswordResetPage(
                vm: RecoveryViewModel(
                  authRepository: AppContainer().repositoryScope.authRepository,
                  settingService: AppContainer().serviceScope.settingsService,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomePage(
            child: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            initialLocation: AppRouteList.citiesListPage,
            routes: [
              GoRoute(
                path: AppRouteList.citiesListPage,
                builder: (context, state) => CitiesListPage(
                  vm: CityListViewModel(
                    settingService: AppContainer().serviceScope.settingsService,
                  ),
                ),
                routes: [
                  GoRoute(
                    path: AppRouteList._aboutApplicationPath,
                    builder: (context, state) => const AboutApplicationPage(),
                  ),
                  GoRoute(
                    path: AppRouteList._currencyPagePath,
                    builder: (context, state) => const CurrencyWebView(),
                  ),
                  GoRoute(
                      path: AppRouteList._citiesDetailPagePath,
                      builder: (context, state) => CitiesDetailPage(
                            settingsService:
                                AppContainer().serviceScope.settingsService,
                          ),
                      routes: [
                        GoRoute(
                          path: AppRouteList._weatherPath,
                          builder: (context, state) => const WeatherPage(),
                        ),
                        GoRoute(
                            path: AppRouteList._listPagePath,
                            builder: (context, state) => ChangeNotifierProvider(
                                  create: (context) => FavoriteProvider(),
                                  child: ListPage(
                                      settingsService: AppContainer()
                                          .serviceScope
                                          .settingsService),
                                ),
                            routes: [
                              GoRoute(
                                  path: AppRouteList._detailPagePath,
                                  builder: (context, state) => DetailPage(
                                      settingsService: AppContainer()
                                          .serviceScope
                                          .settingsService),
                                  routes: [
                                    GoRoute(
                                      path: AppRouteList._addCommentPagePath,
                                      builder: (context, state) =>
                                          AddCommentPage(
                                        vm: AddCommentViewModel(
                                          settingService: AppContainer()
                                              .serviceScope
                                              .settingsService,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ]),
                      ]),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: AppRouteList.placeFavoritePage,
            routes: [
              GoRoute(
                  path: AppRouteList.placeFavoritePage,
                  builder: (context, state) => ChangeNotifierProvider(
                        create: (context) => FavoriteProvider(),
                        child: PlaceFavoritePage(
                          key: UniqueKey(),
                          settingsService:
                              AppContainer().serviceScope.settingsService,
                          vm: FavoriteViewModel(
                            settingService:
                                AppContainer().serviceScope.settingsService,
                          ),
                        ),
                      ),
                  routes: [
                    GoRoute(
                        path: AppRouteList._detailPageFavoritePath,
                        builder: (context, state) => DetailPage(
                            settingsService:
                                AppContainer().serviceScope.settingsService),
                        routes: [
                          GoRoute(
                            path: AppRouteList._addCommentPageFavoritePath,
                            builder: (context, state) => AddCommentPage(
                              vm: AddCommentViewModel(
                                settingService:
                                    AppContainer().serviceScope.settingsService,
                              ),
                            ),
                          ),
                        ]),
                  ]),
            ],
          ),
          StatefulShellBranch(
            initialLocation: AppRouteList.profilePage,
            routes: [
              GoRoute(
                path: AppRouteList.profilePage,
                builder: (context, state) => ProfilePage(
                  vm: ProfileViewModel(
                    settingService: AppContainer().serviceScope.settingsService,
                  ),
                ),
                routes: [
                  GoRoute(
                    path: AppRouteList._editingProfilePagePath,
                    builder: (context, state) => EditProfilePage(
                      vm: ProfileViewModel(
                        settingService:
                            AppContainer().serviceScope.settingsService,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
