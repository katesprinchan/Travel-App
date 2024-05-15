import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';
import 'package:travel_application/core/presentation/app_bar.dart';
import 'package:travel_application/features/currency/models/currency_model.dart';
import 'package:travel_application/features/currency/service/currency_service.dart';
import 'package:travel_application/theme/colors_collection.dart';

class CurrencyWebView extends StatefulWidget {
  const CurrencyWebView({super.key});

  @override
  _CurrencyWebViewState createState() => _CurrencyWebViewState();
}

class _CurrencyWebViewState extends State<CurrencyWebView> {
  late Future<List<Currency>> _futureCurrencies;
  final CurrencyService _currencyService = CurrencyService();
  late String url;
  late String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    url =
        'https://www.agroprombank.com/xmlinformer.php?date=$formattedDate&type=official';
    _futureCurrencies = _currencyService.fetchCurrencies(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title:
            Text('${S.of(context).exchangeRates} ${formattedDate.toString()}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Currency>>(
              future: _futureCurrencies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final currencies = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: currencies.length,
                    itemBuilder: (context, index) {
                      final currency = currencies[index];
                      final currencyCode = currency.code;
                      return ListTile(
                        leading: Image.asset(
                            "assets/image/currency/$currencyCode.png"),
                        title: Text(
                          currency.code,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: ColorsCollection.onSurfaceVariant),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              '${currency.value} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: ColorsCollection.onSurface),
                            ),
                            Text(
                              'RUP',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: ColorsCollection.onSurfaceVariant),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).officialCurrency,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorsCollection.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
