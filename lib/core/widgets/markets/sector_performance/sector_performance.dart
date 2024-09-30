import 'package:flutter/material.dart';
import 'package:stock_learner/core/models/markets/sector_performance/sector_performance_model.dart';
import 'package:stock_learner/core/shared/colors.dart';
import 'package:stock_learner/core/shared/styles.dart';
import 'package:stock_learner/core/utils/color/color_helper.dart';


class SectorPerformance extends StatelessWidget {

  final SectorPerformanceModel performanceData;

  const SectorPerformance({super.key,
    required this.performanceData
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      addAutomaticKeepAlives: false,
      padding: const EdgeInsets.only(top: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: performanceData.performanceModelToday.sectors.length,
      itemBuilder: (BuildContext context, int index) => _buildListTile(
        sectorPerformance: performanceData.performanceModelToday.sectors[index]
      )
    );
  }
  
  Widget _buildListTile({required SingleSectorPerformance sectorPerformance}) {

    final changeString = sectorPerformance.change.replaceFirst(RegExp('%'), ''); 
    final change = double.parse(changeString);
    final width = change > 9.99 ? null : 75.5;

    return Column(
      children: <Widget>[
        const Divider(height: 2),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(sectorPerformance.name, style: const TextStyle(color: kLighterGray)),

          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: kSharpBorder,
              color: determineColorBasedOnChange(change),
            ),
            
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(sectorPerformance.change, textAlign: TextAlign.center,),
          ),
        )
      ],
    );
  }
}