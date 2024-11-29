// Suggested code may be subject to a license. Learn more: ~LicenseLog:269161092.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/env.dart';

import 'city_detail_page.dart';
import 'package:http/http.dart' as http;

class CityListPage extends StatefulWidget {
  const CityListPage({
    super.key,
  });

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  //lateは初期値を与えないときに使う
  late Future<String> _future;

  //画面を開いた時の処理
  //3秒まってその間にresasapiから
  @override
  void initState() {
    super.initState();
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = '/api/v1/cities';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };
    _future = http
        .get(Uri.https(host, endpoint), headers: headers)
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: FutureBuilder<String>(
          future: _future,
          //３秒間の中の処理、builder
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            //jsondecodeはnullを許容しないのでdata!で！をつける
            final json = jsonDecode(snapshot.data!)['result'] as List;
            //resasのresultの配列がString＋何がしというセットなので以下の構文を追加
            final items = json.cast<Map<String, dynamic>>();
            //ListViewbuilderでパフォーマンス向上する
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index){
                final city = items[index];
                return ListTile(
                    title: Text(city['cityName']),
                    subtitle: const Text('政令指定都市'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute(
                          builder: (context) => CityDetailPage(city: city['cityName']),
                        ),
                      );
                    },
                  );
              },
            );
          }),
    );
  }
}
