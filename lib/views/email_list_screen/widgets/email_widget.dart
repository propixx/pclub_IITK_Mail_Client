import 'package:email_mobile_application/models/email.dart';
import 'package:email_mobile_application/views/email_send_screen/email_send_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

class EmailWidget extends StatelessWidget {
  final Email email;

  const EmailWidget({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    int emailBoyLimiter = 70;
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EmailSendScreen(email: email)));
      },
      leading: CircleAvatar(
        backgroundImage: email.profileImage != null
        ? NetworkImage(email.profileImage!)
        :null,
      ),
      title:Text(email.userName!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(email.subject!, style: Theme.of(context).textTheme.bodyMedium,),
          Text("${email.body!.substring(0, email.body!.length > 100 ? 100 : email.body!.length)}${email.body!.length > 100? '...' : ''}", 
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54),
          ),
        ],
      ),
      trailing: Column(
        children: [
          Text(GetTimeAgo.parse(email.dateTime!))
        ],
      ),
   );
    

  }
}
