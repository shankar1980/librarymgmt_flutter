import 'package:flutter/material.dart';
import 'package:librarymgmt/lend_list.dart';
import 'package:librarymgmt/login.dart';
import 'package:librarymgmt/model/book_count.dart';
import 'package:librarymgmt/service/library_service.dart';

class BookCountPage extends StatefulWidget {
  const BookCountPage({Key? key}) : super(key: key);

  @override
  State<BookCountPage> createState() => _BookCountPageState();
}

class _BookCountPageState extends State<BookCountPage> {
  final LibraryService service = LibraryService();
  TextEditingController searchController = TextEditingController();
  late Future<List<BookCount>> books;

  loadBooks() {
    books = service.countBookList();
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
        title: const Text('Book Count'),
        actions: [
          IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              })
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<List<BookCount>>(
            future: books,
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
              List<BookCount> book = snapshot.data!;
              return DataTable(
                columnSpacing: 16.0,
                dataRowHeight: 50,
                columns: const [
                  DataColumn(
                    label: Text("TITLE"),
                  ),
                  DataColumn(
                    label: Text("QUANTITY"),
                  ),
                ],
                rows: List.generate(
                    book.length,
                    (index) => DataRow(cells: [
                          DataCell(Text(book[index].title.toString())),
                          DataCell(Text(book[index].quantity.toString())),
                        ])),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LendList()));
            },
            child: const Text('Borrowed Books'),
          )
        ],
      ),
    );
  }
}
