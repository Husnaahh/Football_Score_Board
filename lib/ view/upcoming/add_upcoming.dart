import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/common_button.dart';
import '../../common/common_textfield.dart';
import '../../constant/app_color.dart';
import '../../constant/app_font_family.dart';
import '../../constant/team_a_logo.dart';
import '../../constant/team_b_logo.dart';
import '../../controller/upcoming_controller.dart';
import '../../model/team_logo_model.dart';
import '../../model/upcoming_model.dart';

class AddUpcoming extends StatefulWidget {
  const AddUpcoming({super.key});

  @override
  State<AddUpcoming> createState() => _AddUpcomingState();
}

class _AddUpcomingState extends State<AddUpcoming> {
  final TextEditingController teamAnameController = TextEditingController();
  final TextEditingController teamBnameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  TimeOfDay? selectedTime;

  @override
  void dispose() {
    teamAnameController.dispose();
    teamBnameController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UpcomingController>(context);

    return Scaffold(
      backgroundColor: AppColor.darkGrey,
      appBar: AppBar(
        backgroundColor: AppColor.darkGrey,
        title: Text('Add Upcoming Match', style: AppFontFamily.txt1),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            children: [
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(12),
                child: DropdownButtonFormField<TeamALogoModel>(
                  value: controller.selectedTeamA,
                  dropdownColor: AppColor.black70,
                  decoration: InputDecoration(
                    labelText: 'Select Team A',
                    labelStyle: AppFontFamily.txtField,
                  ),
                  items: teamAList.map((team) {
                    return DropdownMenuItem(
                      value: team,
                      child: Row(
                        children: [
                          Image.network(team.logoUrlA!, width: 30),
                          const SizedBox(width: 10),
                          Text(team.name!, style: AppFontFamily.txt3),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.setTeamA(value!);
                    teamAnameController.text = value.name!;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: DropdownButtonFormField<TeamBLogoModel>(
                  value: controller.selectedTeamB,
                  dropdownColor: AppColor.black70,
                  decoration: InputDecoration(
                    labelText: 'Select Team B',
                    labelStyle: AppFontFamily.txtField,
                  ),
                  items: teamBList.map((team) {
                    return DropdownMenuItem(
                      value: team,
                      child: Row(
                        children: [
                          Image.network(team.logoUrlB!, width: 30),
                          const SizedBox(width: 10),
                          Text(team.name!, style: AppFontFamily.txt3),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.setTeamB(value!);
                    teamBnameController.text = value.name!;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );

                    if (picked != null) {
                      dateController.text =
                      '${picked.day}/${picked.month}/${picked.year}';
                    }
                  },
                  child: AbsorbPointer(
                    child: CommonTextfield(
                      txt: 'Date',
                      controller: dateController,
                      obscureTxt: false,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      selectedTime = pickedTime;
                      timeController.text = pickedTime.format(context);
                    }
                  },
                  child: AbsorbPointer(
                    child: CommonTextfield(
                      txt: 'Time',
                      controller: timeController,
                      obscureTxt: false,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: CommonButton(
              txt: "Save",
              onPressed: () async {

                if (controller.selectedTeamA == null ||
                    controller.selectedTeamB == null ||
                    dateController.text.isEmpty ||
                    timeController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Fill all fields")),
                  );
                  return;
                }

                final model = UpcomingModel(
                  teamAName: teamAnameController.text.trim(),
                  teamBName: teamBnameController.text.trim(),
                  teamALogo: controller.selectedTeamA!.logoUrlA,
                  teamBLogo: controller.selectedTeamB!.logoUrlB,
                  date: dateController.text.trim(),
                  time: timeController.text.trim(),
                );

                await controller.addUpcomingMatch(model);

                controller.clearSelections();

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Match Added")),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}