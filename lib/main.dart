import 'package:dioapidemo/scroll_provider.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScrollProvider(),
      child: MaterialApp(
        title: 'Lazy Load Demo',
        home: MyHomePage(title: 'Lazy Load Demo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ScrollProvider>(context, listen: false).loadMore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Consumer<ScrollProvider>(
          builder: (context, scrollProvider, child) {
            return LazyLoadScrollView(
              isLoading: scrollProvider.isLoading,
              onEndOfPage: () => scrollProvider.loadMore(),
              child: Scrollbar(
                child: ListView.builder(
                    itemCount: scrollProvider.postList.length + 0,
                    itemBuilder: (context, index) {
                      return
                          // scrollProvider.postList.length == index
                          //     ? const Center(
                          //         child: CircularProgressIndicator(),
                          //       )
                          //     :
                          ListTile(
                        title: Text(
                            scrollProvider.postList[index]['title'].toString()),
                        subtitle: Text(scrollProvider.postList[index]['body']),
                        leading: Text(
                            scrollProvider.postList[index]['id'].toString()),
                      );
                    }),
              ),
            );
          },
        ));
  }
}
