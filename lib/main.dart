import 'package:audio_app/bloc/download/download_bloc.dart';
import 'package:audio_app/bloc/favorite/favorite_bloc.dart';
import 'package:audio_app/tools/audio_handler.dart';
import 'package:audio_app/tools/download_service.dart';
import 'package:audio_service/audio_service.dart';
import 'imports/imports.dart';

late final AudioHandler audioHandler;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  audioHandler = await AudioService.init(
    builder: () => AppAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'music_app',
      androidNotificationChannelName: 'Music Playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoriteBloc()..add(LoadFavorites())),
        BlocProvider(create: (_) => DownloadBloc()..add(LoadDownloads())),
        BlocProvider(create: (context) => TrackBloc(AppAudioService())),
        BlocProvider(
          create: (_) => PlaylistBloc(AppAudioService())
            ..add(FetchPlaylists(PlaylistCategory.trending))
            ..add(FetchPlaylists(PlaylistCategory.popular))
            ..add(FetchPlaylists(PlaylistCategory.phonk)),
        ),
        BlocProvider(create: (_) => PlaylistTrackBloc(AppAudioService())),
        BlocProvider(
          create: (_) => PlayerBloc(AppAudioHandler(), DownloadService()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthWrapper(),
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MainPage();
        }
        return LoginOrRegisterPage();
      },
    );
  }
}
