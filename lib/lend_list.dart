import 'package:flutter/material.dart';
import 'package:librarymgmt/model/lend_model.dart';
import 'package:librarymgmt/service/library_service.dart';

class LendList extends StatefulWidget {
  const LendList({Key? key}) : super(key: key);

  @override
  State<LendList> createState() => _LendListState();
}

class _LendListState extends State<LendList> {
  final LibraryService service = LibraryService();
  late Future<List<Lend>> lends;

  loadBooks() {
    lends = service.getLendList();
  }

  @override
  void initState() {
    loadBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrowed Books'),
      ),
      body: FutureBuilder<List<Lend>>(
        future: lends,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(
              child: Text(
                "Error: $error",
              ),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No data'));
            }
          }
          List<Lend> lend = snapshot.data!;
          return DataTable(
            columnSpacing: 16.0,
            dataRowHeight: 50,
            columns: const [
              DataColumn(
                label: Text("ISBN"),
              ),
              DataColumn(
                label: Text("TITLE"),
              ),
              DataColumn(
                label: Text("QUANTITY"),
              ),
              DataColumn(
                label: Text("STATUS"),
              ),
              DataColumn(
                label: Text("ACTIONS"),
              ),
            ],
            rows: List.generate(
              lend.length,
              (index) => DataRow(
                cells: [
                  DataCell(Text(lend[index].isbn.toString())),
                  DataCell(Text(lend[index].title.toString())),
                  DataCell(Text(lend[index].quantity.toString())),
                  DataCell(Text(lend[index].status.toString())),
                  DataCell(
                    lend[index].status == 'PENDING'
                        ? TextButton(
                            onPressed: () {
                              // lends = service.lendRequest(
                              //     lend[index].isbn.toString());
                              // setState(() {});
                            },
                            child: const Text('Cancel'),
                          )
                        : TextButton(
                            onPressed: () {
                              // lends = service.lendRequest(
                              //     lend[index].isbn.toString());
                              // setState(() {});
                            },
                            child: const Text('Return'),
                          ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
