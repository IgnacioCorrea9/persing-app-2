import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String ranking;
  final String comment;
  final String initials;
  const CommentCard(
      {super.key,
      required this.ranking,
      required this.comment,
      required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: double.infinity),
      child: Card(
          elevation: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 36.0,
                    width: 36.0,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFFFF1D5),
                      child: Text(
                        initials,
                        style: TextStyle(color: Color(0xFFFFAA00)),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                      // constraints: BoxConstraints(maxHeight: double.infinity),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ranking: ' + ranking,
                                  style: TextStyle(
                                      color: Color(0xFF707070), fontSize: 14)),
                              Icon(
                                Icons.feedback_outlined,
                                color: Colors.grey,
                                size: 19,
                              )
                            ],
                          ),
                          Wrap(
                            children: [
                              Text(
                                comment,
                              )
                            ],
                          )
                        ],
                      )))
            ],
          )),
    );
  }
}
