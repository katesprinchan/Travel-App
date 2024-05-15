import 'package:flutter/material.dart';
import 'package:travel_application/core/domain/intl/generated/l10n.dart';

class AboutApplicationPage extends StatelessWidget {
  const AboutApplicationPage({super.key});

  TextSpan _textSpanBold(context) => TextSpan(
        text: S.of(context).relaxInPridnestrovie,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).aboutApplication,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  children: <TextSpan>[
                    TextSpan(text: S.of(context).welcome),
                    _textSpanBold(context),
                    TextSpan(text: S.of(context).universalAssistant),
                    const TextSpan(
                        text:
                            '\n \nЗдесь вы найдете широкий выбор товаров и услуг, предлагаемых как частными лицами, так и компаниями. Будь то поиск квартиры, покупка машины или выбор исполнителя для домашних работ – все это доступно в несколько кликов.'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Особенности приложения:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  children: <TextSpan>[
                    const TextSpan(
                        text: '• Разнообразие Категорий: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text:
                            'От недвижимости и автомобилей до бытовой техники и одежды.\n'),
                    const TextSpan(
                        text: '• Поиск и Фильтры: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text:
                            'Настройте фильтры поиска, чтобы быстро найти то, что вам нужно.\n'),
                    const TextSpan(
                        text: '• Безопасность: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text:
                            'Мы прилагаем все усилия, чтобы сделать сделки безопасными и прозрачными.\n'),
                    const TextSpan(
                        text: '• Легкость Публикации Объявлений: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text:
                            'Продавайте ваши товары, публикуя объявления легко и быстро.\n'),
                    const TextSpan(
                        text: '• Личный Кабинет: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text:
                            'Управляйте своими объявлениями и настройками через персональный аккаунт.'),
                    const TextSpan(text: '\n \n В '),
                    _textSpanBold(context),
                    const TextSpan(
                        text:
                            ' мы стремимся предоставить вам лучший опыт покупок и продаж. Постоянные обновления и улучшения делают наше приложение еще удобнее и функциональнее.'),
                    const TextSpan(text: '\n \n Спасибо, что выбрали '),
                    _textSpanBold(context),
                    const TextSpan(
                        text: ' Мы рады помочь вам сделать удачные сделки.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
