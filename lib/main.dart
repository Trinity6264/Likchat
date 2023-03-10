import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:likchat/logic/bloc/internet/internet_bloc.dart';
import 'package:likchat/logic/cubit/chat/chat_cubit.dart';
import 'package:likchat/repo/chat_repo.dart';
import 'package:likchat/screens/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(
    chatRepo: ChatRepo(),
  ));
}

class MyApp extends StatelessWidget {
  final ChatRepo chatRepo;
  const MyApp({
    super.key,
    required this.chatRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetBloc>(create: (context) => InternetBloc()),
        BlocProvider<ChatCubit>(
            create: (context) => ChatCubit(chatRepo: chatRepo)),
      ],
      child: MaterialApp(
        title: 'Infotess',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const SplashView(),
      ),
    );
  }
}
