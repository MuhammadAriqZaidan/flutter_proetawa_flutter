import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/data/dataresource/auth_service.dart';
import 'package:flutter_skl_bp/presentation/pages/Dashboard.dart';
import 'package:flutter_skl_bp/presentation/pages/List-Distributor.dart';
import 'package:flutter_skl_bp/presentation/pages/List-Inventory.dart';
import 'package:flutter_skl_bp/presentation/pages/List-Reseller.dart';
import 'package:flutter_skl_bp/presentation/pages/auth/login_page.dart';
import 'presentation/auth/blocs/login/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(AuthRemoteDatasource()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) =>LoginPage(), // kalau pakai splash bisa ubah jadi SplashPage
          '/distributor': (context) =>DistributorListPage(),
          '/reseller': (context) =>ResellerListPage(),
          '/inventory': (context) =>BarangListPage(),
          '/dashboard': (context) => Dashboardpage(),
          '/login': (context) => LoginPage(), // ✅ tambahkan ini!
        },
      ),
    );
  }
}
