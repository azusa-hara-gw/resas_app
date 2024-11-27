// Suggested code may be subject to a license. Learn more: ~LicenseLog:269161092.
import 'package:flutter/material.dart';
import 'city_detail_page.dart';

class CityListPage extends StatelessWidget {
  const CityListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const cities = [
      '札幌市',
      '仙台市',
      'さいたま市',
      '千葉市',
      '横浜市',
      '川崎市',
      '相模原市',
      '名古屋市',
      '京都市',
      '大阪市',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: ListView(
        children: [
          for(final city in cities)
            ListTile(
              title: Text(city),
              subtitle: const Text('政令指定都市'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).push<void>(
                MaterialPageRoute(
                builder: (context) => const CityDetailPage(),
                ),
                );
             },
            ),
        ],
      ),
    );
  }
}