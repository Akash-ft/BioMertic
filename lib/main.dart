import 'package:biometrics/dt_biometric_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'Provider.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bio Metrics',
      home: BioMetricsAuth(),
    );
  }
}

class BioMetricsAuth extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = ref.watch(biometricAuthenticationStateProvider);
    final a = ref.watch(availableBioMetricStateProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text("User Authentication"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("- User Status-", style: TextStyle(fontSize: 40)),
              b.when(
                  data: (data) => Text(data.name, style: TextStyle(fontSize: 20),),
                  error: (e, r) => Text(e.toString()),
                  loading: () => Text("Loading")),
              a.when(
                  data: (data) => Text(data.name, style: TextStyle(fontSize: 20)),
                  error: (e, r) => Text(e.toString()),
                  loading: () => Text("Loading")),
            ],
          ),
        ));
  }
}
