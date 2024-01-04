import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:kap/app/widgets/cap_country_flag.dart';

@RoutePage()
class CountryView extends StatelessWidget {
  const CountryView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final countries =
        CountryManager().countries.where((element) => element.phoneMaskMobileInternational.isNotEmpty).toList();
    countries.sort((a, b) => (a.countryName?.toLowerCase() ?? '').compareTo(b.countryName?.toLowerCase() ?? ''));
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      ...countries.map(
                        (e) => Column(
                          children: [
                            GestureDetector(
                              onTap: () => context.router.pop(e),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CapCountryFlag(countryCode: e.countryCode),
                                        Text('+${e.phoneCode}', style: Theme.of(context).textTheme.titleMedium),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20.0, height: 50.0),
                                  Flexible(
                                      flex: 5,
                                      fit: FlexFit.tight,
                                      child: Text(
                                        e.countryName ?? '',
                                        maxLines: 2,
                                        style: Theme.of(context).textTheme.titleMedium,
                                      )),
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
