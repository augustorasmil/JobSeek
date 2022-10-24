import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/empty_messages_widget.dart';
import '../d_e_t_a_i_l_s_chat/d_e_t_a_i_l_s_chat_widget.dart';
import '../flutter_flow/chat/index.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MAINChatWidget extends StatefulWidget {
  const MAINChatWidget({Key? key}) : super(key: key);

  @override
  _MAINChatWidgetState createState() => _MAINChatWidgetState();
}

class _MAINChatWidgetState extends State<MAINChatWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).darkText,
        automaticallyImplyLeading: false,
        title: Text(
          'Messages',
          style: FlutterFlowTheme.of(context).title3.override(
                fontFamily: 'Outfit',
                color: FlutterFlowTheme.of(context).tertiaryColor,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
          child: StreamBuilder<List<ChatsRecord>>(
            stream: queryChatsRecord(
              queryBuilder: (chatsRecord) => chatsRecord
                  .where('users', arrayContains: currentUserReference)
                  .orderBy('last_message_time', descending: true),
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: SpinKitThreeBounce(
                      color: FlutterFlowTheme.of(context).primaryColor,
                      size: 50,
                    ),
                  ),
                );
              }
              List<ChatsRecord> listViewChatsRecordList = snapshot.data!;
              if (listViewChatsRecordList.isEmpty) {
                return Center(
                  child: EmptyMessagesWidget(
                    title: 'No Messages',
                    bodyText:
                        'Once you apply to jobs your messages for that job post will live here.',
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: listViewChatsRecordList.length,
                itemBuilder: (context, listViewIndex) {
                  final listViewChatsRecord =
                      listViewChatsRecordList[listViewIndex];
                  return StreamBuilder<ChatsRecord>(
                    stream:
                        ChatsRecord.getDocument(listViewChatsRecord.reference),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: SpinKitThreeBounce(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              size: 50,
                            ),
                          ),
                        );
                      }
                      final chatPreviewChatsRecord = snapshot.data!;
                      return StreamBuilder<FFChatInfo>(
                        stream: FFChatManager.instance
                            .getChatInfo(chatRecord: chatPreviewChatsRecord),
                        builder: (context, snapshot) {
                          final chatInfo = snapshot.data ??
                              FFChatInfo(chatPreviewChatsRecord);
                          return FFChatPreview(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DETAILSChatWidget(
                                  chatUser: chatInfo.otherUsers.length == 1
                                      ? chatInfo.otherUsersList.first
                                      : null,
                                  chatRef: chatInfo.chatRecord.reference,
                                ),
                              ),
                            ),
                            lastChatText: chatInfo.chatPreviewMessage(),
                            lastChatTime:
                                chatPreviewChatsRecord.lastMessageTime,
                            seen: chatPreviewChatsRecord.lastMessageSeenBy!
                                .contains(currentUserReference),
                            title: chatInfo.chatPreviewTitle(),
                            userProfilePic: chatInfo.chatPreviewPic(),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            unreadColor:
                                FlutterFlowTheme.of(context).secondaryColor,
                            titleTextStyle: GoogleFonts.getFont(
                              'Outfit',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            dateTextStyle: GoogleFonts.getFont(
                              'Outfit',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                            previewTextStyle: GoogleFonts.getFont(
                              'Outfit',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(12, 3, 12, 3),
                            borderRadius: BorderRadius.circular(0),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
