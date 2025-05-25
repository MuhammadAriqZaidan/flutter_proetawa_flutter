import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/data/dataresource/distributor_service.dart';
import '../../../data/models/distributor_model.dart';

class DistributorListPage extends StatefulWidget {
  const DistributorListPage({super.key});

  @override
  State<DistributorListPage> createState() => _DistributorListPageState();
}

class _DistributorListPageState extends State<DistributorListPage> {
  late Future<List<Distributor>> _distributorFuture;

  @override
  void initState() {
    super.initState();
    _distributorFuture = DistributorService().getDistributors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Distributor')),
      body: FutureBuilder<List<Distributor>>(
        future: _distributorFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada distributor.'));
          }

          final distributors = snapshot.data!.reversed.toList();
          return ListView.builder(
            itemCount: distributors.length,
            itemBuilder: (context, index) {
              final distributor = distributors[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(distributor.nama[0].toUpperCase()),
                ),
                title: Text(distributor.nama),
                subtitle: Text(distributor.noTelp),
                trailing: Text(distributor.alamat),
              );
            },
          );
        },
      ),
floatingActionButton: FloatingActionButton(
  onPressed: () async {
    final result = await Navigator.pushNamed(
      context,
      '/add-distributor',
    );

    if (result == true) {
      setState(() {
        // Refresh ulang future atau data distributor
        _distributorFuture = DistributorService().getDistributors();
      });
    }
  },
  child: const Icon(Icons.add),
  tooltip: 'Tambah Distributor',
),

    );
  }
}
