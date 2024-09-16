import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kelompok7_a2/navigator/navigator.dart';
import 'package:kelompok7_a2/provider/category_provider.dart';
import 'package:kelompok7_a2/provider/product_provider.dart';

import 'package:kelompok7_a2/screen/splash/splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (contex) => ProductProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (contex) => CategoryProvider(),
        ),

        // ChangeNotifierProvider<CekProvider>(
        //   create: (contex) => CekProvider(),
        // ),
        // Provider lainnya jika ada
      ],
      child: MaterialApp(
        title: 'Toko Oleh Oleh',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/home': (context) => const NavigatorScreen(),
        },
        home: StreamBuilder<User?>(
          stream: authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final user = snapshot.data;
              if (user == null) {
                // Pengguna tidak masuk
                // Navigasi ke layar masuk atau tampilkan konten sesuai kebutuhan
                return const NavigatorScreen(); // Contoh: Navigasi ke layar masuk
              } else {
                // Pengguna berhasil masuk
                // Lanjutkan dengan konten aplikasi yang sesuai
                return const NavigatorScreen(); // Contoh: Navigasi ke layar utama
              }
            }
            return const CircularProgressIndicator(); // atau widget lain yang sesuai
          },
        ),
      ),
    );
  }
}
