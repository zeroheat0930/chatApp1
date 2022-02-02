import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(this.message, this.isMe, {Key? key}) : super(key: key);
  //알규먼트를 메세지 변수에 바인드 해줌
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
            ), //컨테이너 모서리 부분을 둥글게 하기위해
          ),
          width: 145,
          padding: EdgeInsets.symmetric(
              vertical: 10, horizontal: 16), //가로세로값 달리주기 위해서 시매트릭 속성
          margin: EdgeInsets.symmetric(
              vertical: 4, horizontal: 8), //메세지간의 구별되는 공간 확보
          child: Text(
            message,
            style: TextStyle(color: isMe ? Colors.black : Colors.white),
          ),
        ),
      ],
    );
  }
}
