import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_learner/core/bloc/portfolio/portfolio_bloc.dart';
import 'package:stock_learner/core/bloc/profile/profile_bloc.dart';
import 'package:stock_learner/core/bloc/search/search_bloc.dart';
import 'package:stock_learner/core/bloc/sector_performance/sector_performance_bloc.dart';
import 'package:stock_learner/core/constants/api_keys.dart';
import 'package:stock_learner/core/widgets/about/about.dart';
import 'package:stock_learner/core/widgets/home.dart';
import 'package:stock_learner/core/bloc/news/news_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Sentry for error reporting
  await SentryFlutter.init(
    (options) {
      options.dsn = kSentryDomainNameSystem;
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () =>
        runApp(const MyApp()), // Runs the app after Sentry is initialized
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PortfolioBloc>(
          create: (context) => PortfolioBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<SectorPerformanceBloc>(
          create: (context) => SectorPerformanceBloc(),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Stock Market App',
        theme: ThemeData(brightness: Brightness.dark),
        home: const StockMarketAppHome(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/about': (context) => AboutSection(),
        },
      ),
    );
  }
}
