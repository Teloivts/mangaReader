import 'package:flutter/material.dart';
import 'dart:io';
class ListView3 extends StatelessWidget {

  List<String> book = [];
  var heigh = 500.0;
  ListView3(List<String> x,double y){
    book = x;
    heigh = y;
  }
  @override
  Widget build(BuildContext context) {

    //下划线widget预定义以供复用。
    Widget divider1=Divider(color: Colors.blue,);
    Widget divider2=Divider(color: Colors.green);
    return ListView.separated(
      cacheExtent: heigh*10,
      itemCount: book.length,
      //列表项构造器
      itemBuilder: (BuildContext context, int index) {
        var num = 'http://81.68.213.251:8000/strategic-lovers-chapter-23/$index.rawkuma.com.jpg';
        num = book[index];
        //var img = Image.network(num);
        var img = Image.file(File(num));
        return img;
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return index%2==0?divider1:divider2;
      },
    );
  }

}