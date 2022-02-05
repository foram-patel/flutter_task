import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:my_flutter_task/utils/app_drawer.dart';
import 'package:my_flutter_task/utils/app_utils.dart';
import 'package:nb_utils/nb_utils.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static const int _pageSize = 10;

  Dio dio = Dio();

  final PagingController<int, dynamic> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    // TODO: implement initState
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: AppDrawer(),
      body: PagedListView<int, dynamic>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<dynamic>(itemBuilder: (context, item, index) => _listItem(item)),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await dio.get('${baseUrl}users', queryParameters: {
        'per_page': 10,
        'page': pageKey,
      });
      final isLastPage = response.data['total'] < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(response.data['data']);
      } else {
        int nextPageKey = pageKey + response.data['data'].length as int;
        _pagingController.appendPage(response.data['data'], nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  _listItem(item) {
    return Container(
      color: white,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8,),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(flex: 2, child: Image.network(item['avatar'])),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          text('First Name:'),
                          5.width,
                          text(item['first_name'],fontFamily: fontBold,)
                        ],
                      ),
                      Row(
                        children: [
                          text('Last Name:'),
                          5.width,
                          text(item['last_name'],fontFamily: fontBold,)
                        ],
                      ),
                      Row(
                        children: [
                          text('Email:'),
                          5.width,
                          text(item['email'],fontFamily: fontBold,)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: PopupMenuButton(
              onSelected:(value){
                if(value=='edit'){
                  performEdit(item);
                }else if(value=='delete'){
                  performDelete(item['id']);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text("Edit"),
                  value: 'edit',
                ),
                const PopupMenuItem(
                  child: Text("Delete"),
                  value: 'delete',
                ),
              ],
            ),
          ),
        ],
      ),
    ).withHeight(100);
  }

  void performEdit(item) {
    Get.toNamed('edit-user',arguments: item)!.then((value) {
      _pagingController.refresh();
    });
  }

  void performDelete(id) {
    dio.delete('${baseUrl}users/$id').then((response) {
      if(response.statusCode==204){
        toast('User Deleted');
        _pagingController.refresh();
      }
    });
  }
}
