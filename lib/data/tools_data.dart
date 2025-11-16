import '../models/tools_model.dart';

final List<ToolModel> firstAidItems = [
  ToolModel(
    id: '1',
    name: 'Medicinal Alcohol 70%',
    subtitle: 'Antiseptic solution for external use',
    description:
        'A 70% alcohol solution used for disinfecting skin and cleaning minor wounds. Effective against bacteria, viruses, and fungi.',
    notes:
        'For external use only. Keep away from heat and flames. Store in a cool, dry place.',
    category: FirstAidCategory.cleaningAndDisinfecting,
    imagePath: 'assets/images/medicalalcohol.png',
  ),
  ToolModel(
    id: '2',
    name: 'Betadine (Povidone-Iodine)',
    subtitle: 'Antiseptic solution 100 mg/ml',
    description:
        'Povidone-iodine antiseptic solution that kills bacteria, viruses, fungi, and protozoa. Used for wound cleaning and skin disinfection.',
    notes:
        'May stain skin and clothing. Not suitable for individuals with iodine allergies. Avoid contact with eyes.',
    category: FirstAidCategory.cleaningAndDisinfecting,
    imagePath: 'assets/images/betadine.png',
  ),
  ToolModel(
    id: '3',
    name: 'Hand Sanitizer Gel',
    subtitle: '75% Ethanol with Aloe',
    description:
        'Alcohol-based hand sanitizer with aloe vera for moisturizing. Kills 99.9% of germs without water.',
    notes:
        'For external use only. Keep out of reach of children. Flammable - keep away from heat.',
    category: FirstAidCategory.cleaningAndDisinfecting,
    imagePath: 'assets/images/hand_sanitizer_gel.png',
  ),

  // Wound Covering Materials
  ToolModel(
    id: '4',
    name: 'Cotton Balls',
    subtitle: '100% Pure Cotton - 300 Count',
    description:
        'Soft, absorbent cotton balls for cleaning wounds, applying antiseptics, or removing makeup. Made from 100% natural cotton.',
    notes:
        'Non-sterile. Single-use only. Keep in a dry place to maintain hygiene.',
    category: FirstAidCategory.woundCoveringMaterials,
    imagePath: 'assets/images/cotton_balls.png',
  ),
  ToolModel(
    id: '5',
    name: 'Sterile Gauze Pad',
    subtitle: '4" x 4" Medical Grade',
    description:
        'Sterile gauze pads for covering wounds, absorbing blood and fluids. Individually wrapped to maintain sterility.',
    notes:
        'Do not reuse. Replace if package is damaged. Apply with clean hands.',
    category: FirstAidCategory.woundCoveringMaterials,
    imagePath: 'assets/images/sterile_gauze.png',
  ),
  ToolModel(
    id: '6',
    name: 'Adhesive Bandages',
    subtitle: 'Assorted sizes',
    description:
        'Flexible adhesive bandages for covering minor cuts, scrapes, and blisters. Breathable material with non-stick pad.',
    notes:
        'Change daily or when wet. Clean wound before application. Not for deep wounds.',
    category: FirstAidCategory.woundCoveringMaterials,
    imagePath: 'assets/images/bandages.png',
  ),
  ToolModel(
    id: '7',
    name: 'Medical Tape',
    subtitle: 'Waterproof Adhesive Tape',
    description:
        'Hypoallergenic medical tape for securing bandages and gauze. Waterproof and breathable.',
    notes:
        'For external use only. Remove carefully to avoid skin irritation. Not for use on sensitive skin.',
    category: FirstAidCategory.woundCoveringMaterials,
    imagePath: 'assets/images/adhesive_tape.png',
  ),
  ToolModel(
    id: '8',
    name: 'Elastic Bandage',
    subtitle: 'Compression wrap with clips',
    description:
        'Elastic compression bandage for supporting sprains, strains, and joint injuries. Reusable with metal clips.',
    notes:
        'Do not wrap too tightly. Check circulation regularly. Wash before reuse.',
    category: FirstAidCategory.woundCoveringMaterials,
    imagePath: 'assets/images/compression_wrap.png',
  ),

  // Basic Medications
  ToolModel(
    id: '9',
    name: 'Paracetamol (Acetaminophen)',
    subtitle: '500mg Capsules - Pain Relief',
    description:
        'Paracetamol for relief of mild to moderate pain and fever. Effective for headaches, muscle aches, and cold symptoms.',
    notes:
        'Adults: 1-2 capsules every 4-6 hours. Do not exceed 8 capsules in 24 hours. Not for children under 12.',
    category: FirstAidCategory.basicMedications,
    imagePath: 'assets/images/paracetamol.png',
  ),
  ToolModel(
    id: '10',
    name: 'Mebo Ointment',
    subtitle: 'Burns and wound healing cream',
    description:
        'Natural herbal ointment for treating burns, wounds, and skin injuries. Promotes healing and reduces scarring.',
    notes:
        'Apply thin layer to affected area 2-3 times daily. For external use only. Avoid eyes.',
    category: FirstAidCategory.basicMedications,
    imagePath: 'assets/images/mebo.png',
  ),
  ToolModel(
    id: '11',
    name: 'Triple Antibiotic Ointment',
    subtitle: 'Bacitracin, Neomycin, Polymyxin B',
    description:
        'First aid antibiotic ointment for preventing infection in minor cuts, scrapes, and burns. Contains three antibiotics.',
    notes:
        'Clean wound before application. Use 1-3 times daily. Stop if rash develops. For external use only.',
    category: FirstAidCategory.basicMedications,
    imagePath: 'assets/images/antibiotic_ointment.png',
  ),
  ToolModel(
    id: '12',
    name: 'Loratadine Tablets',
    subtitle: '10mg Non-drowsy Antihistamine',
    description:
        '24-hour relief from allergies and hayfever symptoms. Non-drowsy formula suitable for daily use.',
    notes:
        'Adults and children 12+: One tablet daily. May take with or without food. Consult doctor if pregnant.',
    category: FirstAidCategory.basicMedications,
    imagePath: 'assets/images/loratadine.png',
  ),

  // Tools
  ToolModel(
    id: '13',
    name: 'Medical Scissors',
    subtitle: 'Stainless steel bandage scissors',
    description:
        'Sharp medical scissors with angled blades for cutting bandages, tape, and clothing. Blunt tip for safety.',
    notes:
        'Sterilize before use on wounds. Keep sharp edge away from skin. Clean after each use.',
    category: FirstAidCategory.tools,
    imagePath: 'assets/images/small_medical_scissors.png',
  ),
  ToolModel(
    id: '14',
    name: 'Tweezers',
    subtitle: 'Precision medical tweezers',
    description:
        'Stainless steel tweezers with angled tips for removing splinters, debris, and ticks. Essential for wound care.',
    notes:
        'Sterilize before use. Grip firmly but gently. Clean with alcohol after each use.',
    category: FirstAidCategory.tools,
    imagePath: 'assets/images/tweezers.png',
  ),
];
