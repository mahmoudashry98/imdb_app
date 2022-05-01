import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:imdb_app/layout/cubit/cubit.dart';
import 'package:imdb_app/layout/cubit/states.dart';
import 'package:imdb_app/layout/home_layout.dart';
import 'package:imdb_app/shared/bloc_observer.dart';
import 'package:imdb_app/shared/network/remote/dio_helper.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

//firebaseMessagingBackgroundHandler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();

  //push message when using app
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  //push message when app run in my foreground
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  print(token);
  //push message when app is closed
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //initialize BloObserver
  Bloc.observer = MyBlocObserver();

  //navigate router
  Widget? widget = HomeLayout();

  // initialize DioHelper
  DioHelper.init();

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getMovies(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.amber,
            ),
            home: SplashScreenView(
              navigateRoute: startWidget,
              duration: 5000,
              imageSize: 200,
              imageSrc: "assets/images/flutter5786.jpg",
               text: "IMDB",
              textType: TextType.ColorizeAnimationText,
              textStyle: TextStyle(
                fontSize: 40.0,
              ),
              colors: [
                Colors.orange,
                Colors.brown,
                Colors.yellow,
              ],
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  // void initState() {
  //   super.initState();
  //   _initURIHandler();
  //   _incomingLinkHandler();
  // }

  @override
  // void dispose() {
  //   _streamSubscription?.cancel();
  //   super.dispose();
  // }

  // bool _initialURILinkHandled = false;
  // Uri? _initialURI;
  // Uri? _currentURI;
  // Object? _err;

  //StreamSubscription? _streamSubscription;
  // Future<void> _initURIHandler() async {
  //   // 1
  //   if (!_initialURILinkHandled) {
  //     _initialURILinkHandled = true;
  //     // 2
  //     Fluttertoast.showToast(
  //         msg: "Invoked _initURIHandler",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white
  //     );
  //     try {
  //       // 3
  //       final initialURI = await getInitialUri();
  //       // 4
  //       if (initialURI != null) {
  //         debugPrint("Initial URI received $initialURI");
  //         if (!mounted) {
  //           return;
  //         }
  //         setState(() {
  //           _initialURI = initialURI;
  //         });
  //       } else {
  //         debugPrint("Null Initial URI received");
  //       }
  //     } on PlatformException { // 5
  //       debugPrint("Failed to receive initial uri");
  //     } on FormatException catch (err) { // 6
  //       if (!mounted) {
  //         return;
  //       }
  //       debugPrint('Malformed Initial URI received');
  //       setState(() => _err = err);
  //     }
  //   }
  // }
  // void _incomingLinkHandler() {
  //   // 1
  //   if (!kIsWeb) {
  //     // 2
  //     _streamSubscription = uriLinkStream.listen((Uri? uri) {
  //       if (!mounted) {
  //         return;
  //       }
  //       debugPrint('Received URI: $uri');
  //       setState(() {
  //         _currentURI = uri;
  //         _err = null;
  //       });
  //       // 3
  //     }, onError: (Object err) {
  //       if (!mounted) {
  //         return;
  //       }
  //       debugPrint('Error occurred: $err');
  //       setState(() {
  //         _currentURI = null;
  //         if (err is FormatException) {
  //           _err = err;
  //         } else {
  //           _err = null;
  //         }
  //       });
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(),
        // Center(
        // child: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       // 1
        //       ListTile(
        //         title: const Text("Initial Link"),
        //         subtitle: Text(_initialURI.toString()),
        //       ),
        //       // 2
        //       if (!kIsWeb) ...[
        //         // 3
        //         ListTile(
        //           title: const Text("Current Link Host"),
        //           subtitle: Text('${_currentURI?.host}'),
        //         ),
        //         // 4
        //         ListTile(
        //           title: const Text("Current Link Scheme"),
        //           subtitle: Text('${_currentURI?.scheme}'),
        //         ),
        //         // 5
        //         ListTile(
        //           title: const Text("Current Link"),
        //           subtitle: Text(_currentURI.toString()),
        //         ),
        //         // 6
        //         ListTile(
        //           title: const Text("Current Link Path"),
        //           subtitle: Text('${_currentURI?.path}'),
        //         )
        //       ],
        //       // 7
        //       if (_err != null)
        //         ListTile(
        //           title: const Text('Error', style: TextStyle(color: Colors.red)),
        //           subtitle: Text(_err.toString()),
        //         ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       const Text("Check the blog for testing instructions")
        //     ],
        //   ),
        // )),
    );
  }
}
