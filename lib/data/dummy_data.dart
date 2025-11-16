import 'package:mus3if/models/emergancy_contact.dart';
import 'package:mus3if/models/guides.dart';

final List<Guide> guides = [
  Guide(
    title: "Heart Attack",
    description:
        "How to recognize and respond to a heart attack emergency situation",
    category: "Cardiac Emergency",
    steps: [
      "Call emergency services immediately (911)",
      "Help the person sit down and rest comfortably",
      "Loosen any tight clothing around neck and waist",
      "If prescribed, help them take their medication",
      "Monitor breathing and be prepared to perform CPR if needed",
      "Do not leave the person alone until help arrives",
      "Keep the person calm and reassured",
    ],
  ),
  Guide(
    title: "Severe Bleeding",
    description: "Steps to control severe bleeding and prevent blood loss",
    category: "Bleeding Emergency",
    steps: [
      "Wear gloves if available to protect yourself",
      "Apply direct pressure to the wound with a clean cloth",
      "Elevate the injured area above heart level if possible",
      "Do not remove soaked bandages - add more layers on top",
      "Apply pressure to arterial points if bleeding continues",
      "Keep the person warm and monitor for signs of shock",
      "Seek immediate medical attention for severe bleeding",
    ],
  ),
  Guide(
    title: "Burns",
    description: "Proper first aid treatment for different types of burns",
    category: "Burn Injury",
    steps: [
      "Cool the burn with cool running water for 10-20 minutes",
      "Remove jewelry or tight clothing from the burned area",
      "Cover the burn with a sterile non-stick dressing",
      "Do not apply creams, ointments, or ice directly to the burn",
      "Do not break blisters as they protect against infection",
      "Give pain relief if appropriate and available",
      "Seek medical attention for serious burns or if unsure",
    ],
  ),
  Guide(
    title: "Fractures",
    description: "How to immobilize and care for bone fractures and injuries",
    category: "Bone Injury",
    steps: [
      "Keep the injured area still and supported",
      "Apply ice pack wrapped in cloth to reduce swelling",
      "Do not try to realign or push the bone back into place",
      "Create a splint using available materials if necessary",
      "Elevate the injured limb if possible to reduce swelling",
      "Monitor circulation and sensation in the affected area",
      "Get medical help immediately for proper treatment",
    ],
  ),
  Guide(
    title: "CPR",
    description: "Cardiopulmonary resuscitation for adults in cardiac arrest",
    category: "Life Saving",
    steps: [
      "Check for responsiveness and normal breathing",
      "Call emergency services or ask someone to call",
      "Place heel of hand on center of chest",
      "Push hard and fast (100-120 compressions per minute)",
      "Allow chest to recoil completely between compressions",
      "Continue CPR until help arrives or person shows signs of life",
      "Use AED if available and follow its instructions",
    ],
  ),
  Guide(
    title: "Choking",
    description: "First aid procedures for conscious choking victims",
    category: "Airway Emergency",
    steps: [
      "Ask 'Are you choking?' - if they can cough, encourage coughing",
      "Stand behind the person and wrap arms around their waist",
      "Make a fist and place it above the navel, below the ribcage",
      "Grasp fist with other hand and perform quick upward thrusts",
      "Continue abdominal thrusts until object is dislodged",
      "If person becomes unconscious, begin CPR",
      "Call emergency services if choking persists or worsens",
    ],
  ),
];

final List<EmergencyContact> defaultContacts = [
  EmergencyContact(
    name: "Dr. Mohamed Salah El-Gendy",
    phoneNumber: "01005396843",
    specialty: "General Practitioner",
    location:
        "Same building as Dr. Maher El-Amir clinic - Gamal Abdel Nasser Street",
    schedule: "Saturday and Tuesday",
    type: "doctor",
  ),
  EmergencyContact(
    name: "Dr. Mohamed Gomaa",
    phoneNumber: "01026388989",
    alternatePhone: "01144497717",
    specialty: "General Practitioner",
    location: "Next to El-Shorbagy in El-Sawaki",
    type: "doctor",
  ),
  EmergencyContact(
    name: "Dr. Hala Shaheen",
    phoneNumber: "01154398657",
    specialty: "General Practitioner",
    location: "Near rescue file at hospital general intersections",
    type: "doctor",
  ),
  EmergencyContact(
    name: "Dr. Hadeer Mahmoud Abdel Ghaffar",
    phoneNumber: "01003569209",
    alternatePhone: "01091023444",
    specialty: "Pediatric Neurology Specialist",
    location: "Downtown, next to the Commercial Chamber",
    type: "doctor",
  ),

  EmergencyContact(
    name: "Makkah Hospital",
    phoneNumber: "01001821667",
    alternatePhone: "0846301050",
    specialty: "General Hospital",
    location: "3 El-Sheikh Hamza Street, behind the Technical School for Girls",
    type: "hospital",
  ),
  EmergencyContact(
    name: "Al-Zahraa Hospital",
    phoneNumber: "0842074140",
    alternatePhone: "0842074113",
    specialty: "General Hospital",
    location: "14 Algeria Street, Bagous",
    type: "hospital",
  ),
  EmergencyContact(
    name: "Al-Nada Hospital",
    phoneNumber: "0846375054",
    alternatePhone: "0846375053",
    specialty: "General Hospital",
    location: "Al-Masalla, next to the automatic mill",
    type: "hospital",
  ),
];

List<EmergencyContact> contacts = [];

// final UserProfile currentUser = UserProfile(
//   name: "Rawan Gamal",
//   bloodType: "O-",
//   allergies: "Peanuts, Shellfish, Penicillin",
//   contacts: contacts.where((contact) => contact.type == 'personal').toList(),
// );
