import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter20/chatting/chat/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      //채팅메세지를 구독하고 있다가 보여줘야되서 스트림빌더 사용
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('time', descending: true)
          .snapshots(),
      //파이어스토어 메세지를 불러오는 코드
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        // 빌더는 컨텍스트, asyncsnapshot필요해서 이코드씀
        if (snapshot.connectionState == ConnectionState.waiting) {
          //빌더안에서 로딩스테이츠를 점검하는 코드
          //만약 스냅샷의 커넥트스테이트가 웨이팅일때 센터 위젯을 리턴
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;
        // chatdocs라는 파이널 변수 생성 = 다큐먼트의 데이터가 널값이면 안되서 data뒤에서 !붙임

        return ListView.builder(
          //데이터가 전달되면 리스트뷰.빌더를 리턴
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            return ChatBubble(
              chatDocs[index]['text'],
              chatDocs[index]['userID'].toString() == user!.uid,
            );
            //모든 메세지는 텍스트 형태여야 함
          },
        );
      },
    );
  }
}
