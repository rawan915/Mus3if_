import 'package:flutter/material.dart';
import 'package:mus3if/data/dummy_data.dart';
import 'package:mus3if/models/emergancy_contact.dart';
import 'package:mus3if/local_storage/contact_storage.dart';
import 'package:mus3if/widgets/custom_text_field.dart';
import 'package:mus3if/widgets/custom_dropdown.dart';
import 'package:mus3if/services/contact_service.dart';

class AddContactScreen extends StatefulWidget {
  final VoidCallback? onContactAdded;

  const AddContactScreen({super.key, this.onContactAdded});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _alternatePhoneController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _locationController = TextEditingController();
  final _scheduleController = TextEditingController();

  String _selectedType = ContactService.typePersonal;
  bool _isSaving = false;

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _nameController.dispose();
    _phoneController.dispose();
    _alternatePhoneController.dispose();
    _relationshipController.dispose();
    _specialtyController.dispose();
    _locationController.dispose();
    _scheduleController.dispose();
  }

  Future<void> _addContact() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final newContact = _buildContact();
      await _saveContact(newContact);
      _showSuccessMessage(newContact.name);
      _navigateBack();
    } catch (e) {
      _showErrorMessage(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  EmergencyContact _buildContact() {
    return EmergencyContact(
      name: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      alternatePhone: ContactService.getOptionalValue(
        _alternatePhoneController,
      ),
      relationship: ContactService.getOptionalValue(_relationshipController),
      specialty: ContactService.getOptionalValue(_specialtyController),
      location: ContactService.getOptionalValue(_locationController),
      schedule: ContactService.getOptionalValue(_scheduleController),
      type: _selectedType,
    );
  }

  Future<void> _saveContact(EmergencyContact contact) async {
    contacts.add(contact);
    await ContactStorage.saveContacts(contacts);
    widget.onContactAdded?.call();
  }

  void _showSuccessMessage(String name) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$name added successfully!"),
        backgroundColor: ContactService.colorSuccess,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(String error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error saving contact: $error"),
        backgroundColor: ContactService.colorError,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _navigateBack() {
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("Add Emergency Contact"),
      backgroundColor: ContactService.colorPrimary,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: _isSaving ? _buildLoadingIndicator() : const Icon(Icons.save),
          onPressed: _isSaving ? null : _addContact,
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildContactTypeDropdown(),
            const SizedBox(height: 16),
            _buildNameField(),
            const SizedBox(height: 16),
            _buildPhoneField(),
            const SizedBox(height: 16),
            _buildAlternatePhoneField(),
            ..._buildConditionalFields(),
            const SizedBox(height: 16),
            _buildLocationField(),
            if (_selectedType == ContactService.typeDoctor) ...[
              const SizedBox(height: 16),
              _buildScheduleField(),
            ],
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTypeDropdown() {
    return CustomDropdown(
      value: _selectedType,
      items: ContactService.contactTypes,
      label: "Contact Type",
      onChanged: (value) => setState(() => _selectedType = value!),
    );
  }

  Widget _buildNameField() {
    return CustomTextField(
      controller: _nameController,
      label: "Full Name *",
      icon: Icons.person,
      validator: ContactService.validateName,
    );
  }

  Widget _buildPhoneField() {
    return CustomTextField(
      controller: _phoneController,
      label: "Phone Number *",
      icon: Icons.phone,
      keyboardType: TextInputType.phone,
      validator: ContactService.validatePhone,
    );
  }

  Widget _buildAlternatePhoneField() {
    return CustomTextField(
      controller: _alternatePhoneController,
      label: "Alternate Phone",
      icon: Icons.phone_iphone,
      keyboardType: TextInputType.phone,
    );
  }

  List<Widget> _buildConditionalFields() {
    if (_selectedType == ContactService.typePersonal) {
      return [const SizedBox(height: 16), _buildRelationshipField()];
    } else if (_selectedType == ContactService.typeDoctor ||
        _selectedType == ContactService.typeHospital) {
      return [const SizedBox(height: 16), _buildSpecialtyField()];
    }
    return [];
  }

  Widget _buildRelationshipField() {
    return CustomTextField(
      controller: _relationshipController,
      label: "Relationship",
      icon: Icons.group,
    );
  }

  Widget _buildSpecialtyField() {
    return CustomTextField(
      controller: _specialtyController,
      label: _selectedType == ContactService.typeDoctor
          ? "Specialty"
          : "Hospital Type",
      icon: Icons.medical_services,
    );
  }

  Widget _buildLocationField() {
    return CustomTextField(
      controller: _locationController,
      label: "Location/Address",
      icon: Icons.location_on,
      maxLines: 2,
    );
  }

  Widget _buildScheduleField() {
    return CustomTextField(
      controller: _scheduleController,
      label: "Schedule",
      icon: Icons.schedule,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isSaving ? null : _addContact,
        style: ElevatedButton.styleFrom(
          backgroundColor: ContactService.colorPrimary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: _isSaving
            ? _buildLoadingIndicator()
            : const Text(
                "Add Contact",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
