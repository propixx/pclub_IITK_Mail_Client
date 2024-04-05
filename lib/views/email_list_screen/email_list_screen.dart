import 'dart:convert';
import 'package:email_mobile_application/constants/strings.dart';
import 'package:email_mobile_application/local_db/local_db.dart';
import 'package:email_mobile_application/models/email.dart';
import 'package:email_mobile_application/models/email_tab.dart';
import 'package:email_mobile_application/views/email_send_screen/email_send_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

import 'widgets/email_widget.dart';

class EmailListScreen extends StatefulWidget {
  final Email? email; 
  const EmailListScreen({super.key, this.email});

  @override
  State<EmailListScreen> createState() => _EmailListScreenState();
}

class _EmailListScreenState extends State<EmailListScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<EmailTab> tabs = [
    EmailTab("Inbox", Icons.inbox_outlined),
    EmailTab("Sent", Icons.send_outlined),
    EmailTab("Star", Icons.star_border),
  ];
  List<Email> emails = [
    Email(
        body: "The Music Club comprises the music enthusiasts of the campus who share a passion for performing and creating music, as well as pushing the boundaries of their technique by experimenting with different dynamic aspects of music across a wide range of genres and domains. In addition to performance, we explore music production and recording, original compositions and releases, songwriting, collaborations, and mixing.Throughout the year, the club hosts three major performance events - Musical Extravaganza 1 & 2 and Acoustic Night - and competes in the major national competitions. Furthermore, we aim to foster creativity on campus through a variety of workshops, events, and competitions in the fields of instrumentals, vocals, music production, and original compositions. We also carry out many other initiatives and series like Sample & Song breakdowns, Theory Trivia, Album Reviews, and Genre Explore for the campus junta. We are looking forward to conducting New Events, Inter and Intra Club collaborations and competitions, and Alumni Collaborations in the upcoming semester.",
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        profileImage: "https://nwm.iitk.ac.in/skins/elastic/images/contactpic.svg",
        subject: "Call for Secretary Nominations",
        userName: "	General Secretary, Media and Culture", id: '78'),
    Email(
        body: "Your class assignment will be conducted by your section's instructor in the next week. The set of case studies and the instruction for the same are attached. You will be randomly sorted into groups of 3 and each group will be asked to discuss a randomly allocated case study (see PDF). Each of you must speak for 1 minute on the case study assigned to you and submit a written document on the same by the end of the week in the HelloIITK portal.Please note that proper participation in this is essential for you to pass this course, so I would recommend you to go through all the case studies and analyze the ethical dimensions in the same before you attend class.",
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        profileImage: "https://nwm.iitk.ac.in/skins/elastic/images/contactpic.svg",
        subject: "Class Assignment, ETH111",
        userName: "	pmoise", id: '79'),
    Email(
        body: "Based on the request received from all of you to add a juice run once a week to the basics of the mess menu, we would like to know your thoughts and consent as for your information let us tell you that it may have a slight impact on your BDMR.Even after knowing this if 70% students still agree to run juice once a week in the basics of mess menu then it can be implemented in mess menu.We are sharing the Google Form link below to know your views. Please share your views by tomorrow 5 PM( April 05, 2024).",
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        profileImage: "https://nwm.iitk.ac.in/skins/elastic/images/contactpic.svg",
        subject: "Lecture 6 and 7Fwd: Reg, Adding a juice in Basic mess menu and Mess closure on 5 April 2024",
        userName: "	Hall13 Ofice", id: '76'),
    Email(
        body: "Could you please forward this to student community.I had opened my cycle with  keys at KD cycle parking around 11:40 Am on 4th April and I am not finding my keys after that.It has 2 rooms keys (normal lock keys)1 cycle key, 1 lab key and a keychain with a grain written lavanya Reddy on it.",
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        profileImage: "https://nwm.iitk.ac.in/skins/elastic/images/contactpic.svg",
        subject: "FW: Lost my dignity",
        userName: "Dean, Students Affairs - IITK", id: '76'),
    Email(
        body: "As midsem break is over now, it's time to channelize energy into something new. In this direction, the hockey family brings you a two-day hockey workshop this week and get the feel of the exciting sport.There is no constraint on batch or gender, and there is no requirement of experience; just bring your 'enthu' and the rest will be taken care of. Hockey is a mixed-gender sport; hence, girls are highly encouraged to be a part of this workshop.",
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        profileImage: "https://nwm.iitk.ac.in/skins/elastic/images/contactpic.svg",
        subject: "Hockey Workshop'24 ",
        userName: "	sportsecy", id: '76'),
    Email(
        body: "This email is for all students who had missed to see their mid-sem answersheets due to their unavailability. They may come and see their answer sheets in lab12 (lab 301), 3rd floor, MFCEM today i..e April 4 2024,anytime between 6.30-7pm. Snehlata (cc'd) here will help you in thisprocess.This email is for all students who had missed to see their mid-sem answer sheets due to their unavailability. They may come and see their answersheets in lab12 (lab 301), 3rd floor, MFCEM today i..e April 4 2024,anytime between 6.30-7pm. Snehlata (cc'd) here will help you in this process.",
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        profileImage: "https://nwm.iitk.ac.in/skins/elastic/images/contactpic.svg",
        subject: "for students who had not seen their mid sem answer sheet",
        userName: "		asahoo@iitk.ac.in", id: '76'),
    Email(
        body: "Based on the request received from all of you to add a juice run once a week to the basics of the mess menu, we would like to know your thoughts and consent as for your information let us tell you that it may have a slight impact on your BDMR.Even after knowing this if 70% students still agree to run juice once a week in the basics of mess menu then it can be implemented in mess menu.We are sharing the Google Form link below to know your views. Please share your views by tomorrow 5 PM( April 05, 2024).",
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        profileImage: "https://nwm.iitk.ac.in/skins/elastic/images/contactpic.svg",
        subject: "Lecture 6 and 7Fwd: Reg, Adding a juice in Basic mess menu and Mess closure on 5 April 2024",
        userName: "	Hall13 Ofice", id: '76'),
  ];
  @override
  void initState() {
    if (LocalDB.email == null) {
      getAuthenticationTokenAndStoreEmail();
    } else {
      fetchEmails(0);
    }
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      fetchEmails(tabController.index);
    });
    super.initState();
  }

  String convertExpiry(timestampInSeconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        timestampInSeconds * 1000,
        isUtc: true);
    return dateTime.toIso8601String();
  }

  getAuthenticationTokenAndStoreEmail() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/gmail.modify',
        'https://www.googleapis.com/auth/gmail.settings.basic',
      ],
    );
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final credentials = await googleSignIn.currentUser!.authentication;
        final url = Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=$FIREBASE_API');

        final response = await post(url,
            headers: {'Content-type': 'application/json'},
            body: jsonEncode({
              'postBody':
                  'id_token=${credentials.idToken}&providerId=google.com',
              'requestUri': 'http://localhost',
              'returnIdpCredential': true,
              'returnSecureToken': true
            }));
        if (response.statusCode != 200) {
          throw 'Refresh token request failed: ${response.statusCode}';
        }

        final data = Map<String, dynamic>.of(jsonDecode(response.body));

        var payload = {
          "access_token": credentials.accessToken,
          "client_id": CLIENT_ID,
          "client_secret": CLIENT_SECRET,
          "refresh_token": data['refreshToken'],
          "token_expiry": convertExpiry(jsonDecode(data['rawUserInfo'])['exp']),
          "token_uri": "https://oauth2.googleapis.com/token",
          "user_agent": null,
          "revoke_uri": "https://oauth2.googleapis.com/revoke",
          "id_token": null,
          "id_token_jwt": null,
          "token_response": {
            "access_token": credentials.accessToken,
            "expires_in": data['expiresIn'],
            "scope":
                "https://www.googleapis.com/auth/gmail.modify https://www.googleapis.com/auth/gmail.settings.basic",
            "token_type": "Bearer"
          },
          "scopes": [
            "https://www.googleapis.com/auth/gmail.settings.basic",
            "https://www.googleapis.com/auth/gmail.modify"
          ],
          "token_info_uri": "https://oauth2.googleapis.com/tokeninfo",
          "invalid": false,
          "_class": "OAuth2Credentials",
          "_module": "oauth2client.client"
        };

        final authResponse = await post(
            Uri.parse('http://10.0.2.2:8000/authenticate'),
            headers: {'Content-type': 'application/json'},
            body: jsonEncode({
              "email": googleSignIn.currentUser!.email,
              "gmail_payload": payload
            }));

        if (authResponse.statusCode == 200) {
          LocalDB.setEmail(googleSignIn.currentUser!.email);
          LocalDB.setName(googleSignIn.currentUser!.displayName ?? "");
          LocalDB.setPhoto(googleSignIn.currentUser!.photoUrl ?? "");
          fetchEmails(0);
        } else {
          throw Exception("Authenticate endpoint not working!");
        }
      }
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  fetchEmails(int reqType) async {
    final response = await post(Uri.parse('http://10.0.2.2:8000/get-emails'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({"email": LocalDB.email, "req_type": reqType}));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      emails = data.map((e) => Email.fromJson(e)).toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EmailSendScreen()));
        },
        child: const Icon(Icons.edit),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(82),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              TabBar(
                controller: tabController,
                tabs: List.generate(
                  tabs.length,
                  (index) => Tab(
                    height: 50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(tabs[index].iconData),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(tabs[index].text),
                        const SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => EmailWidget(email: emails[index]),
          separatorBuilder: (context, index) => Divider(
                thickness: 0.3,
                indent: MediaQuery.of(context).size.width * 0.1,
                endIndent: MediaQuery.of(context).size.width * 0.1,
              ),
          itemCount: emails.length),
    );
  }
}
