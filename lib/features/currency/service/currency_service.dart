import 'package:http/http.dart' as http;
import 'package:travel_application/features/currency/models/currency_model.dart';
import 'package:xml/xml.dart' as xml;

class CurrencyService {
  Future<List<Currency>> fetchCurrencies(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      final currencyNodes = xmlDoc.findAllElements('currency');
      List<Currency> currencies = [];
      for (var currencyNode in currencyNodes) {
        currencies.add(Currency.fromXml(currencyNode));
      }
      return currencies;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
