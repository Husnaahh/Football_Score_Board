import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_font_family.dart';
import '../../../controller/league_controller.dart';
import '../../../model/league_model.dart';

class LeagueCard extends StatelessWidget {
  final LeagueModel model;

  const LeagueCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 250,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColor.black90,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: AppColor.black60, blurRadius: 20)],
      ),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Image.network(
                  model.imageUrl ?? '',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: 20,),

              Consumer<LeagueController>(
                builder: (context, controller, child) {
                  return IconButton(
                    onPressed: () {
                      if (model.id != null) {
                        controller.deleteLeague(model.id!);
                      }
                    },
                    icon: Icon(
                      EneftyIcons.close_circle_outline,
                      color: AppColor.accentGreen,
                    ),
                  );
                },
              ),
            ],
          ),

          SizedBox(height: 20,),

          Text(
            model.name ?? '',
            style: AppFontFamily.txt4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 25,),

          Container(
            width: 120,
            height: 2,
            decoration: BoxDecoration(
              color: AppColor.accentGreen,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}