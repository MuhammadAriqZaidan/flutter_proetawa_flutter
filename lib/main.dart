// ignore_for_file: slash_for_doc_comments, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skl_bp/data/models/barang_model.dart';
import 'package:flutter_skl_bp/data/models/reseller_model.dart';
import 'package:flutter_skl_bp/presentation/auth/blocs/login_bloc.dart';
import 'package:flutter_skl_bp/presentation/inventory/blocs/add_inventory_bloc.dart';
import 'package:flutter_skl_bp/data/dataresource/inventory_service.dart';
import 'package:flutter_skl_bp/presentation/inventory/pages/Add-Inventory.dart';
import 'package:flutter_skl_bp/presentation/inventory/pages/Detail-Inventory.dart';
import 'package:flutter_skl_bp/presentation/inventory/pages/Edit-Inventory.dart';
import 'package:flutter_skl_bp/presentation/reseller/pages/Reseller-Detail.dart';
import 'package:flutter_skl_bp/presentation/reseller/pages/edit_reseller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_skl_bp/data/dataresource/auth_service.dart';
import 'package:flutter_skl_bp/presentation/Dashboard.dart';
import 'package:flutter_skl_bp/presentation/inventory/pages/List-Inventory.dart';
import 'package:flutter_skl_bp/presentation/reseller/pages/List-Reseller.dart';
import 'package:flutter_skl_bp/presentation/auth/pages/login_page.dart';
import 'package:flutter_skl_bp/presentation/reseller/blocs/add_reseller_bloc.dart';
import 'package:flutter_skl_bp/data/dataresource/reseller_service.dart';
import 'package:flutter_skl_bp/presentation/reseller/pages/Add-Reseller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('id', null); // ID = Bahasa Indonesia
    runApp(const MyApp());
}

/*************  ✨ Windsurf Command ⭐  *************/
/// The build method for the [MaterialApp].
///
/// This method provides the top-level [MaterialApp] for the app.
/// It includes the [LoginBloc] as a [BlocProvider] and a [MaterialApp]
/// with the routes for the app. The [MaterialApp] is configured
/// with a title and a theme, and the initial route is set to '/'.
///
/// The routes are as follows:
///
/// * '/' : The login page.
/// * '/reseller' : The reseller list page.
/// * '/inventory' : The inventory list page.
/// * '/dashboard' : The dashboard page.
/// * '/login' : The login page.
///
/*******  5a5946ba-0e4b-42ac-a8c1-be05b7ff47a1  *******/ 
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
          '/': (context) => LoginPage(),
          '/reseller': (context) => ResellerListPage(),
          '/inventory': (context) => BarangListPage(),
          '/dashboard': (context) => Dashboardpage(),
          '/login': (context) => LoginPage(),

          '/add-inventory': (context) => FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final token = snapshot.data!.getString('token') ?? '';
                  return BlocProvider(
                    create: (_) => AddInventoryBloc(
                      service: InventoryService(),
                      token: token,
                    ),
                    child: const AddInventoryPage(),
                  );
                },
              ),


          '/add-reseller': (context) => FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final token = snapshot.data!.getString('token') ?? '';
                  return BlocProvider(
                    create: (_) => AddResellerBloc(
                      service: ResellerService(),
                      token: token,
                    ),
                    child: const AddResellerPage(),
                  );
                },
              ),

          '/reseller-detail': (context) {
            final reseller =
                ModalRoute.of(context)!.settings.arguments as Reseller;
            return ResellerDetailPage(reseller: reseller);
          },
          '/edit-reseller': (context) {
            final reseller =
                ModalRoute.of(context)!.settings.arguments as Reseller;
            return FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                      );
                }
                final token = snapshot.data!.getString('token') ?? '';
                return BlocProvider(
                  create: (_) =>
                      AddResellerBloc(service: ResellerService(), token: token),
                  child: EditResellerPage(reseller: reseller),
                );
              },
            );
          },

          '/edit-inventory': (context) {
            final barang = ModalRoute.of(context)!.settings.arguments as BarangModel;
            return EditInventoryPage(barang: barang);
          },

    '/barang-detail': (context) {
      final barang = ModalRoute.of(context)!.settings.arguments as BarangModel;
      return BarangDetailPage(barang: barang);
    },

        },
      ),
    );
  }
}
