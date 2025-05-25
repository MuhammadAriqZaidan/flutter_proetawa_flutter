import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/data/dataresource/reseller_service.dart';
import '../../../data/models/reseller_model.dart';

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
    _resellerFuture = ResellerService().getResellers();
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

          final resellers = snapshot.data!.reversed.toList();
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
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/reseller-detail',
                    arguments: reseller,
                  ).then((result) {
                    if (result != null) {
                      setState(() {
                        _resellerFuture = ResellerService().getResellers();
                      });
                    }
                  });
                  ;
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            '/add-reseller',
          );

          if (result == true) {
            setState(() {
              // Refresh data reseller
              _resellerFuture = ResellerService().getResellers();
            });
          }
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah Reseller',
      ),
    );
  }
}
