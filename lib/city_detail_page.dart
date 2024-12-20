import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myapp/city.dart';
import 'package:myapp/annual_municipality_tax.dart';

import 'env.dart';

class CityDetailPage extends StatefulWidget {
  const CityDetailPage({super.key, required this.city});

  final City city;

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  late Future<String> _future;

  @override
  void initState() {
    super.initState();
    // APIからデータを取得する処理
    const host = 'opendata.resas-portal.go.jp';
    // 一人当たりの地方税を取得するエンドポイントを指定します
    const endopoint = 'api/v1/municipality/taxes/perYear';
    final headers = {'X-API-KEY': Env.resasApiKey};
    final param = {
      'prefCode': widget.city.prefCode.toString(),
      'cityCode': widget.city.cityCode,
    };
    _future = http
        .get(Uri.https(host, endopoint, param), headers: headers)
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city.cityName),
      ),
      body: FutureBuilder<String>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final result =
              jsonDecode(snapshot.data!)['result'] as Map<String, dynamic>;
          final data = result['data'] as List;
          final items = data.cast<Map<String, dynamic>>();
          final taxes = items.map(AnnualMunicipalityTax.fromJson).toList();
          return ListView.separated(
            itemCount: taxes.length,
            itemBuilder: (context, index) {
              final tax = taxes[index];
               return ListTile(
               title: Text('${tax.year}年'),
               trailing: Text(
                 _formatTaxLabel(tax.value),
                 style: Theme.of(context).textTheme.bodyLarge,
                  ),
              );
            },
            //各値ごとに下線をつけれるようにするseparatorBuilder
            //Dividorを使うと間に要素を入れれる。デフォは線
            //なみかっこ＋returnと=>は同義
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }

  // 税額をフォーマットして表示するメソッド
  String _formatTaxLabel(int value) {
    // NumberFormatを使用して3桁ごとにカンマを追加する
    final formatted = NumberFormat('#,###').format(value * 1000);
    // フォーマットされた数値に「円」を追加して返す
    return '$formatted円';
  }
}
