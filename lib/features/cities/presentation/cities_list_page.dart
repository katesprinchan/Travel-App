import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/core/presentation/asset/image_collection.dart';
import 'package:travel_application/core/presentation/drawer.dart';
import 'package:travel_application/features/cities/presentation/cities_list_vm.dart';
import 'package:travel_application/routing.dart';
import 'package:travel_application/theme/colors_collection.dart';

class CitiesListPage extends StatefulWidget {
  final CityListViewModel vm;
  const CitiesListPage({super.key, required this.vm});

  @override
  State<CitiesListPage> createState() => _CitiesListPageState();
}

class _CitiesListPageState extends State<CitiesListPage>
    with SingleTickerProviderStateMixin {
  CityListViewModel get vm => widget.vm;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  int activeIndex = 0;
  List<String> urlImages = [
    ImageCollection.history,
    ImageCollection.currency,
    ImageCollection.map,
  ];
  Widget _sliderBuilder(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final halfScreenHeight = screenHeight / 3;
    return Center(
      child: Column(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              height: halfScreenHeight + 100,
              enlargeCenterPage: true,
              viewportFraction: 0.7,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            ),
            itemCount: urlImages.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = urlImages[index];
              return buildImage(urlImage, index, screenHeight / 2.7);
            },
          ),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: JumpingDotEffect(
            activeDotColor: Theme.of(context).colorScheme.primary,
            dotHeight: 12,
            dotWidth: 12),
      );

  Widget buildImage(String urlImage, int index, double halfScreenHeight) =>
      GestureDetector(
        onTap: () => context.go(getPage(index)),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 280,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(urlImage, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  getTitle(index),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ],
          ),
        ),
      );

  String getTitle(int index) {
    switch (index) {
      case 0:
        return S.of(context).historyOfRegion;
      case 1:
        return S.of(context).exchangeRates;
      case 2:
        return S.of(context).map;
      default:
        return '';
    }
  }

  String getPage(int index) {
    switch (index) {
      case 0:
        return AppRouteList.currencyPage;
      case 1:
        return AppRouteList.currencyPage;
      case 2:
        return '/advListPage/advertisementFavoritePage';
      default:
        return '';
    }
  }

  Widget _buildCityWidget(
    BuildContext context,
    String imagePath,
    String cityName,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            child: Image.asset(
              imagePath,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorsCollection.gradient1,
                  ColorsCollection.gradient2,
                  ColorsCollection.gradient1
                ],
              ),
            ),
            width: 300,
            height: 40,
            alignment: Alignment.center,
            child: Text(
              cityName,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _citiesBuilder(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCityWidget(
            context,
            ImageCollection.tiraspol,
            S.of(context).tiraspol,
            () {
              context.go(AppRouteList.citiesDetailPage);
              CityName.cityName = 'Tiraspol';
              IdDocCity.id = 'qkMvcdmVbz8sWMKFudDw';
            },
          ),
          _buildCityWidget(
            context,
            ImageCollection.bendery,
            S.of(context).bender,
            () {
              context.go(AppRouteList.citiesDetailPage);
              CityName.cityName = 'Bendery';
              IdDocCity.id = 'M5WXOwR51Ow4UFDbuQJF';
            },
          ),
          _buildCityWidget(
            context,
            ImageCollection.rybnitsa,
            S.of(context).rybnitsa,
            () {
              context.go(AppRouteList.citiesDetailPage);
              CityName.cityName = 'Rybnitsa';
              IdDocCity.id = '7O7NBh5NffeotE1VV6Wt';
            },
          ),
          _buildCityWidget(
            context,
            ImageCollection.dubossary,
            S.of(context).dubossary,
            () {
              context.go(AppRouteList.citiesDetailPage);
              CityName.cityName = 'Dubossary';
              IdDocCity.id = 'NoP7q8zePqQWFDvWUeT2';
            },
          ),
          _buildCityWidget(
            context,
            ImageCollection.grigoriopol,
            S.of(context).grigoriopol,
            () {
              context.go(AppRouteList.citiesDetailPage);
              CityName.cityName = 'Grigoriopol';
              IdDocCity.id = 'db1AIV9AEY8QOy9lZCP9';
            },
          ),
          _buildCityWidget(
            context,
            ImageCollection.slobodzeya,
            S.of(context).slobodzeya,
            () {
              context.go(AppRouteList.citiesDetailPage);
              CityName.cityName = 'Slobodzeya';
              IdDocCity.id = 'fEZk9bwaDWbF8N4izQCW';
            },
          ),
          _buildCityWidget(
            context,
            ImageCollection.kamenka,
            S.of(context).kamenka,
            () {
              context.go(AppRouteList.citiesDetailPage);
              CityName.cityName = 'Kamenka';
              IdDocCity.id = '6TIfT9BI2UuUvhmSUFY9';
            },
          ),
          _buildCityWidget(
            context,
            ImageCollection.dnestrovsk,
            S.of(context).dnestrovsk,
            () {
              context.go(AppRouteList.citiesDetailPage);
              CityName.cityName = 'Dnestrovsk';
              IdDocCity.id = 'V5KpEpKSZEAhEtr7M1xg';
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
          S.of(context).relaxInPridnestrovie,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            _sliderBuilder(context),
            const SizedBox(height: 30),
            _citiesBuilder(context)
          ],
        ),
      ),
      drawer: MainDrawer(onSettingsTap: () {
        vm.onSettingsTap(context);
      }),
    );
  }
}

class CityName {
  static String cityName = '';
}

class IdDocCity {
  static String id = '';
}
