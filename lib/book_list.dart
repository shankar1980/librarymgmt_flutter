import 'package:flutter/material.dart';
import 'package:librarymgmt/lend_list.dart';
import 'package:librarymgmt/login.dart';
import 'package:librarymgmt/model/book_model.dart';
import 'package:librarymgmt/service/library_service.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final LibraryService service = LibraryService();
  TextEditingController searchController = TextEditingController();
  late Future<List<Book>> books;

  loadBooks() {
    books = service.getBookList();
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
        title: const Text('Book List'),
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
          Card(
            child: ListTile(
              leading: const Icon(Icons.search),
              title: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  books = service.searchBooks(searchController.text);
                  setState(() {});
                },
                child: const Text('Search'),
              ),
            ),
          ),
          FutureBuilder<List<Book>>(
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
              List<Book> book = snapshot.data!;
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
                    label: Text("AUTHOR"),
                  ),
                  DataColumn(
                    label: Text("PUBLISHER"),
                  ),
                  DataColumn(
                    label: Text("PAGES"),
                  ),
                  DataColumn(
                    label: Text("QUANTITY"),
                  ),
                  DataColumn(
                    label: Text("ACTIONS"),
                  ),
                ],
                rows: List.generate(
                    book.length,
                    (index) => DataRow(cells: [
                          DataCell(Text(book[index].isbn.toString())),
                          DataCell(Text(book[index].title.toString())),
                          DataCell(Text(book[index].author.toString())),
                          DataCell(Text(book[index].publisher.toString())),
                          DataCell(Text(book[index].pages.toString())),
                          DataCell(Text(book[index].available.toString())),
                          DataCell(book[index].available! > 0
                              ? TextButton(
                                  onPressed: () {
                                    books = service.lendRequest(
                                        book[index].isbn.toString());
                                    setState(() {});
                                  },
                                  child: const Text('Borrow'),
                                )
                              : const Text('Not Available'))
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
