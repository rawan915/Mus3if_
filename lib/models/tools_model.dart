enum FirstAidCategory {
  cleaningAndDisinfecting,
  woundCoveringMaterials,
  basicMedications,
  tools,
}

class ToolModel {
  final String id;
  final String name;
  final String subtitle;
  final String description;
  final String notes;
  final FirstAidCategory category;
  final String imagePath;

  const ToolModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.notes,
    required this.category,
    required this.imagePath,
  });
}