import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stock_learner/core/bloc/portfolio/portfolio_bloc.dart';
import 'package:stock_learner/core/models/storage/storage.dart';


class WatchlistButtonWidget extends StatefulWidget {

  final Color color;
  final bool isSaved;
  final StorageModel storageModel;

  const WatchlistButtonWidget({super.key,
    required this.color,
    required this.isSaved,
    required this.storageModel
  });

  @override
  _WatchlistButtonWidgetState createState() => _WatchlistButtonWidgetState();
}

class _WatchlistButtonWidgetState extends State<WatchlistButtonWidget> {

  late bool isSaved;
  late Color color;
  
  @override
  void initState() {
    isSaved = widget.isSaved;
    color = isSaved
    ? widget.color
    : const Color(0X88ffffff);

    super.initState();
  }

  @override
  void dispose() {
    isSaved = false;
    // color = null;

    super.dispose();
  }

  void changeState({required bool isSaved,required Color color}) {
    setState(() {
      this.isSaved = isSaved;
      this.color = color;
    });
  }

  void onPressedHandler() {

    if (isSaved) {
      changeState(isSaved: false, color: const Color(0X88ffffff));

      BlocProvider
      .of<PortfolioBloc>(context)
      .add(DeleteProfile(symbol: widget.storageModel.symbol));
    } else {
      changeState(isSaved: true, color: widget.color);

      BlocProvider
      .of<PortfolioBloc>(context)
      .add(SaveProfile(storageModel: widget.storageModel));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: Icon(FontAwesomeIcons.solidBookmark, color: color),
      onPressed: () => onPressedHandler()
    );
  }
}