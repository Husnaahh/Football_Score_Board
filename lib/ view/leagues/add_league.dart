import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/common_button.dart';
import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../../constant/league_logo.dart';
import '../../controller/league_controller.dart';
import '../../model/league_logo_model.dart';
import '../../model/league_model.dart';

class AddLeague extends StatefulWidget {
  const AddLeague({super.key});

  @override
  State<AddLeague> createState() => _AddLeagueState();
}

class _AddLeagueState extends State<AddLeague> {

  final TextEditingController teamNameController = TextEditingController();

  LeagueLogoModel? selectedTeam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkGrey,
      appBar: AppBar(
        backgroundColor: AppColor.darkGrey,
        foregroundColor: AppColor.white,
        title: Text('Add League', style: AppFontFamily.txt1),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 23,
                  vertical: 8,
                ),
                child: Consumer<LeagueController>(
                  builder: (context, controller, child) {
                    return DropdownButtonFormField<LeagueLogoModel>(
                      value: controller.selectedTeam,
                      dropdownColor: AppColor.black70,
                      decoration: InputDecoration(
                        labelText: 'Select Team',
                        labelStyle: AppFontFamily.txtField,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.accentGreen),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColor.accentGreen),
                        ),
                      ),
                      items: leagueList.map((team) {
                        return DropdownMenuItem<LeagueLogoModel>(
                          value: team,
                          child: Row(
                            children: [
                              Image.network(
                                team.logoUrl!,
                                width: 30,
                                height: 30,
                              ),

                              SizedBox(height: 10),

                              Text(team.name!, style: AppFontFamily.txt3),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) return;

                        controller.setSelecTeam(value);

                        teamNameController.text = value.name!;
                      },
                    );
                  },
                ),
              ),


            ],
          ),
          Column(
            children: [
              Consumer<LeagueController>(
                builder: (context, controller, child) {
                  return CommonButton(
                    onPressed: () async {
                      final model = LeagueModel(
                        name: teamNameController.text.trim(),
                        imageUrl: controller.selectedTeam?.logoUrl,
                      );

                      await controller.addLeague(model);

                      Navigator.pop(context);
                    },
                    txt: 'Save',
                  );
                },
              ),

              SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}