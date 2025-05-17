import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mesdo/controller/onBoarding_controller.dart';

class CommonWidgets {
  Widget buildSkillInputChips({
    required TextEditingController controller,
    required List<String> skills,
    required Function(String skill) onAdd,
    required Function(String skill) onDelete,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skills / Specialization',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                  color: Colors.grey[200]!,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a Skill',
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 5),
            IconButton(
              onPressed: () {
                final skill = controller.text.trim();
                if (skill.isNotEmpty) {
                  onAdd(skill);
                  controller.clear();
                }
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children:
              skills.map((skill) {
                return Chip(
                  label: Text(skill),
                  onDeleted: () => onDelete(skill),
                  backgroundColor: Colors.grey[200],
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget buildUpload({
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
    required VoidCallback onPressedUpload,
    required VoidCallback onPressedSave,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Document',
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        const SizedBox(height: 8),
        Text(
          'It helps us to verify and provide verification tag on your profile',
          style: const TextStyle(color: Colors.black, fontSize: 12.0),
        ),
        const SizedBox(height: 15),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              hint: Text(
                'Select',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              items:
                  ['Pdf', 'Docx']
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
              onChanged: onChanged,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              dropdownColor: Colors.grey[200],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onPressedUpload,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            minimumSize: Size(326, 44),
            foregroundColor: Colors.grey,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text('Upload', style: TextStyle(color: Colors.grey)),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onPressedSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[200],
            minimumSize: Size(326, 40),
            foregroundColor: Colors.green,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text('Save', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }

  Widget buildProgress({required int currentPage}) {
    return LinearProgressIndicator(
      value: currentPage / 7,
      minHeight: 7,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }

  Widget buildTextEntires({
    required String title,
    required String hint,
    required TextInputType keyboardinput,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$title',
                style: const TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              const TextSpan(
                text: '*',
                style: TextStyle(color: Colors.redAccent, fontSize: 16.0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!, width: 1),
            color: Colors.grey[200]!,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            style: const TextStyle(fontSize: 14),
            keyboardType: keyboardinput,
          ),
        ),
      ],
    );
  }

  Widget buildDateEntires({
    required BuildContext context,
    required String title,
    required String hint,
    required TextInputType keyboardinput,
    required TextEditingController controller,
    required bool readOnly,
    required VoidCallback? ontap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$title',
                style: const TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!, width: 1),
            color: Colors.grey[200]!,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (readOnly) {
                      FocusScope.of(context).unfocus(); // Dismiss keyboard
                      return;
                    }
                    ontap?.call();
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                      keyboardType: keyboardinput,
                      readOnly: true,
                    ),
                  ),
                ),
              ),
              if (controller.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    controller.clear();
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTextEntiresWithoutRed({
    required String title,
    required String hint,
    required TextInputType keyboardinput,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$title',
                style: const TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!, width: 1),
            color: Colors.grey[200]!,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            style: const TextStyle(fontSize: 14),
            keyboardType: keyboardinput,
          ),
        ),
      ],
    );
  }

  Widget buildPara({
    required double height,
    required TextEditingController controller,
    required String hint,
    required TextInputType keyboardinput,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 1),
        color: Colors.grey[200]!,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardinput,
        expands: true, // Fills the height of parent container
        maxLines: null, // Allows unlimited lines
        minLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget buildHeader({required String title, required String subtitle}) {
    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 28.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 14.0),
          ),
        ),
      ],
    );
  }

  Widget buildGenderDropdown({
    required String? selectedGender,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Gender',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedGender,
              isExpanded: true,
              hint: Text(
                'Select',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              items:
                  ['Male', 'Female', 'Other']
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
              onChanged: onChanged,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              dropdownColor: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildStateDropdown({
    required String? selectedState,
    required List<Map<String, String>> states,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'State',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value:
                  selectedState != null &&
                          states.any((s) => s['name'] == selectedState)
                      ? selectedState
                      : null,
              isExpanded: true,
              hint: Text(
                'Select State',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              items:
                  states
                      .map(
                        (state) => DropdownMenuItem(
                          value: state["name"],
                          child: Text(state["name"] ?? ''),
                        ),
                      )
                      .toList(),
              onChanged: onChanged,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              dropdownColor: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCityDropdown({
    required String? selectedCity,
    required List<String> cities,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'City',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value:
                  selectedCity != null && cities.contains(selectedCity)
                      ? selectedCity
                      : null,

              isExpanded: true,
              hint: Text(
                'Select City',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              items:
                  cities
                      .map(
                        (city) =>
                            DropdownMenuItem(value: city, child: Text(city)),
                      )
                      .toList(),
              onChanged: onChanged,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              dropdownColor: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required double height,
    required double width,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(width, height),
        foregroundColor: textColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text('$text', style: TextStyle(color: textColor)),
    );
  }

  Widget buildQualificationDropdown({
    required String? headline,
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$headline',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              hint: Text(
                'Select',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              items:
                  items
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
              onChanged: onChanged,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              dropdownColor: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }
}
