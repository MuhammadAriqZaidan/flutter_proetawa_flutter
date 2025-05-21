import 'package:flutter/material.dart';
import 'package:flutter_skl_bp/data/dataresource/api_service.dart';
import '../../data/models/distributor_model.dart';

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
_distributorFuture = ApiService().getDistributors();
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

          final distributors = snapshot.data!;
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
    );
  }
}
