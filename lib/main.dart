import 'package:chat_ify/screens/chat.dart';
import 'package:chat_ify/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:chat_ify/screens/auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FlutterChat",
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 63, 17, 177),
        ),
      ),
      home: StreamBuilder(                                //it just similar to the future builder widget(it listens to a future and then renders widgets conditionally)
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {   //snapshot is nothing but a token/user data you can say
          if(snapshot.connectionState == ConnectionState.waiting){
            return const SplashScreen();
          }
          
          if (snapshot.hasData) {
            return const ChatScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
