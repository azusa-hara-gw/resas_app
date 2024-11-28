import 'package:flutter/material.dart';

import 'city_detail_page.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({
    super.key,
  });

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<void> _future;

  // 画面を開いたときの処理
  @override
  void initState() {
    super.initState();
    _future = Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    const cities = [
      '札幌市',
      '横浜市',
      '川崎市',
      '相模原市',
      '仙台市',
      'さいたま市',
      '千葉市',
      '静岡市',
      '浜松市',
      '北九州市',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: FutureBuilder<void>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: [
                for (final city in cities)
                  ListTile(
                    title: Text(city),
                    subtitle: const Text(
                        '政令指定都市'), // This is fine as it's a constant string
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CityDetailPage(
                            city: city,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          }),
    );
  }
}