import 'package:flutter/material.dart';
import 'package:myapp/env.dart';
import 'package:http/http.dart' as http;

class CityDetailPage extends StatefulWidget {
  const CityDetailPage({super.key, required this.city});

  final String city;

  @override
  State<CityDetailPage> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  late Future<String> _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = '/api/v1/municipality/taxes/perYear';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };
    final param = {'prefCode': '13', 'cityCode': '13101'};
    _future = http
        .get(Uri.https(host, endpoint, param), headers: headers)
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city),
      ),
      body: FutureBuilder<Object>(
        future: _future,
        builder: (context, snapshot) {
          return Center(
            child: Text('${widget.city}の詳細画面です'),
          );
        }
      ),
    );
  }
}
