import 'package:blogapp/Model/addBlogModels.dart';
import 'package:blogapp/NetworkHandler.dart';
import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  const Blog({Key key, this.addBlogModel, this.networkHandler, this.del})
      : super(key: key);
  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;
  final bool del;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 8,
              child: Column(
                children: [
                  Container(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: networkHandler.getImage(addBlogModel.id),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      addBlogModel.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.chat_bubble,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              addBlogModel.comment.toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.thumb_up,
                              size: 18,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              addBlogModel.count.toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.share,
                              size: 18,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              addBlogModel.share.toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              width: 90,
                            ),
                            Text(
                              "@${addBlogModel.username}",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        if (del) ...[
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              deleteBlog(addBlogModel.id, networkHandler);

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromWidth(500),
                                primary: Colors.red),
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 15,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Text(addBlogModel.body),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void deleteBlog(id, networkHandler) async {
  var response = await networkHandler.delete("/blogPost/delete/$id");
  print(response.body);
}
