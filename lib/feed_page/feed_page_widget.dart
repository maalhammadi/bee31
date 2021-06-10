import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedPageWidget extends StatefulWidget {
  FeedPageWidget({Key key}) : super(key: key);

  @override
  _FeedPageWidgetState createState() => _FeedPageWidgetState();
}

class _FeedPageWidgetState extends State<FeedPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            print('IconButton pressed ...');
          },
          icon: Icon(
            Icons.highlight_off_outlined,
            color: Colors.black,
            size: 30,
          ),
          iconSize: 30,
        ),
        title: Text(
          'بيع',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          Container(
            width: 120,
            height: 120,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              'https://picsum.photos/seed/434/600',
            ),
          )
        ],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: StreamBuilder<List<PostsRecord>>(
          stream: queryPostsRecord(
            queryBuilder: (postsRecord) =>
                postsRecord.orderBy('created_at', descending: true),
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            List<PostsRecord> listViewPostsRecordList = snapshot.data;
            // Customize what your widget looks like with no query results.
            if (snapshot.data.isEmpty) {
              // return Container();
              // For now, we'll just include some dummy data.
              listViewPostsRecordList = createDummyPostsRecord(count: 4);
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: listViewPostsRecordList.length,
              itemBuilder: (context, listViewIndex) {
                final listViewPostsRecord =
                    listViewPostsRecordList[listViewIndex];
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: StreamBuilder<UsersRecord>(
                    stream: UsersRecord.getDocument(listViewPostsRecord.user),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final columnUsersRecord = snapshot.data;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            listViewPostsRecord.imageUrl,
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 25),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        columnUsersRecord.email,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      StreamBuilder<List<PostsRecord>>(
                                        stream: queryPostsRecord(
                                          queryBuilder: (postsRecord) =>
                                              postsRecord.orderBy('price',
                                                  descending: true),
                                          singleRecord: true,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                          List<PostsRecord>
                                              textPostsRecordList =
                                              snapshot.data;
                                          // Customize what your widget looks like with no query results.
                                          if (snapshot.data.isEmpty) {
                                            // return Container();
                                            // For now, we'll just include some dummy data.
                                            textPostsRecordList =
                                                createDummyPostsRecord(
                                                    count: 1);
                                          }
                                          final textPostsRecord =
                                              textPostsRecordList.first;
                                          return Text(
                                            listViewPostsRecord.price
                                                .toString(),
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: FlutterFlowTheme
                                                  .secondaryColor,
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                  child: Text(
                                    listViewPostsRecord.description,
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
