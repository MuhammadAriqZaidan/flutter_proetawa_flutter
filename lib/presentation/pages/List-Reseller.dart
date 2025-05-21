import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/data/dataresource/api_service.dart';
import '../../data/models/reseller_model.dart';

class ResellerListPage extends StatefulWidget {
  const ResellerListPage({super.key});

  @override
  State<ResellerListPage> createState() => _ResellerListPageState();
}

class _ResellerListPageState extends State<ResellerListPage> {
  late Future<List<Reseller>> _resellerFuture;

  @override
  void initState() {
    super.initState();
_resellerFuture = ApiService().getResellers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Reseller')),
      body: FutureBuilder<List<Reseller>>(
        future: _resellerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada reseller.'));
          }

          final resellers = snapshot.data!;
          return ListView.builder(
            itemCount: resellers.length,
            itemBuilder: (context, index) {
              final reseller = resellers[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(reseller.nama[0].toUpperCase()),
                ),
                title: Text(reseller.nama),
                subtitle: Text(reseller.noTelp),
                trailing: Text(reseller.alamat),
              );
            },
          );
        },
      ),
    );
  }
}
