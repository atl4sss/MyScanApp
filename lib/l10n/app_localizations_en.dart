// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MyScan';

  @override
  String get homeSelectModality => 'Choose imaging\nmodality:';

  @override
  String get homeDescriptionPrefix => 'Our program detects most diseases with up to 97% accuracy. Read more about the spectrum of diseases ';

  @override
  String get homeDescriptionLink => 'here';

  @override
  String get homeDescriptionSuffix => '.';

  @override
  String get homeLungs => 'Lung CT';

  @override
  String get homeOct => 'Eye OCT';

  @override
  String get homeBrain => 'Brain MRI';

  @override
  String get modalityLungsTitle => 'Lung CT scan';

  @override
  String get modalityLungsHintPrefix => 'How to photograph correctly — see ';

  @override
  String get modalityLungsHintLink => 'here';

  @override
  String get modalityLungsHintSuffix => '.';

  @override
  String get modalityOctTitle => 'Eye OCT';

  @override
  String get modalityOctHintPrefix => 'Shooting recommendations are available ';

  @override
  String get modalityOctHintLink => 'here';

  @override
  String get modalityOctHintSuffix => '.';

  @override
  String get modalityBrainTitle => 'Brain MRI';

  @override
  String get modalityBrainHintPrefix => 'Instructions for a quality image — ';

  @override
  String get modalityBrainHintLink => 'here';

  @override
  String get modalityBrainHintSuffix => '.';

  @override
  String get attachPhotoTitle => 'Attach a photo:';

  @override
  String get analyzeButton => 'Analyze';

  @override
  String analysisError(String error) {
    return 'Analysis error: $error';
  }

  @override
  String get resultTitle => 'Analysis result';

  @override
  String get backButton => 'Go back';

  @override
  String get pillRisks => 'Risks';

  @override
  String get pillPrevention => 'Prevention';

  @override
  String get pillContact => 'Contact a doctor';

  @override
  String get pillCauses => 'Causes';

  @override
  String get infoUnavailable => 'Information is not available yet.';

  @override
  String diagnosisProbability(String diagnosis, String percent) {
    return '$diagnosis ($percent%)';
  }

  @override
  String get diagPneumoniaBrief => 'Pneumonia is an acute inflammation of lung tissue, most often caused by bacteria or viruses. Severity depends on the pathogen type, patient age, and comorbidities.';

  @override
  String get diagPneumoniaRisks => '• Acute complications: pleurisy, lung abscess, sepsis.\n• Possible chronic outcomes: decreased lung function, bronchiectasis.\n• Especially dangerous for children under 5, the elderly, and immunocompromised people.';

  @override
  String get diagPneumoniaPrevention => '• Vaccination (pneumococcal, influenza, COVID‑19).\n• Avoid smoking, maintain regular physical activity.\n• Timely treatment of colds and ENT infections.';

  @override
  String get diagPneumoniaContact => 'Fever > 38 °C for more than 3 days, shortness of breath or chest pain — contact a therapist/pulmonologist.\n\n📞 103 — emergency ambulance\n📞 Ministry of Health hotline: 8 800 080 88 87';

  @override
  String get diagPneumoniaCauses => '• Bacteria (most often Streptococcus pneumoniae, Haemophilus influenzae).\n• Viruses (influenza, SARS‑CoV‑2, etc.).\n• Atypical agents (Mycoplasma, Chlamydophila).\n• Aspiration of gastric contents.';

  @override
  String get diagMeningiomaBrief => 'A meningioma is a benign tumor of the meninges; it grows slowly and is often found incidentally. It may cause headaches, seizures and focal neurological symptoms due to compression.';

  @override
  String get diagMeningiomaRisks => '• Brain structure compression → limb weakness, speech or vision problems.\n• Brain edema and raised intracranial pressure (headache, nausea, seizures).\n• Cranial nerve involvement in basal location.\n• Rare (< 2%) malignant transformation to atypical/anaplastic form.';

  @override
  String get diagMeningiomaPrevention => 'No specific measures; however:\n• Minimize unnecessary radiation (CT without indication).\n• Manage hormone therapy with your doctor.\n• Maintain vascular/metabolic health.\n• Regular MRI screening for NF2 or prior head irradiation.';

  @override
  String get diagMeningiomaContact => 'Consult a neurosurgeon/neurologist if you have:\n• Persistent progressive headaches.\n• New seizure episodes.\n• Visual/hearing disturbances or paresis.\n\n📞 Republican Neurosurgery Center: +7 7172 62‑18‑27\n📞 Emergency: 103';

  @override
  String get diagMeningiomaCauses => '• Ionizing radiation — the most proven factor.\n• Genetic syndromes (NF2).\n• Hormonal influence: 2–3× more common in women.\n• Trauma and chronic inflammation are discussed but weakly proven.\n\n⚠️ Most meningiomas are benign (Grade I) and slow-growing; management includes observation, microsurgery or radiosurgery.';

  @override
  String get infoTitle => 'Information board';

  @override
  String get infoPrivacyTitle => 'Privacy';

  @override
  String get infoPrivacyBody => 'Privacy\n\nWe strictly follow principles of confidentiality and personal data protection. All data transferred through our platform — medical scans, reports, complaints, passwords and other user information — are stored in encrypted form and securely protected.\nOur system complies with current information security standards and the legislation of the Republic of Kazakhstan.';

  @override
  String get infoPhotoTitle => 'Photos';

  @override
  String get infoPhotoBody => 'For correct image processing and accurate diagnostics it is crucial to meet quality requirements. Please read the recommendations before uploading files.\n\n• Full frame coverage: the image must fully fit without cropped areas.\n• Lighting: take photos in good, even light. Avoid glare, shadows and overexposure.\n• File formats: PNG and JPEG (JPG) are supported.';

  @override
  String get infoDiseasesTitle => 'Diseases';

  @override
  String get infoDiseasesBody => 'Our system supports automatic recognition of a wide range of pathologies and conditions based on different medical images. The algorithms are validated against international standards and adapted to clinical practice.\n\n1. Brain MRI:\n- Pituitary adenoma\n- Glioma\n- Meningioma\n- Normal\n\n2. Eye OCT (retina):\n- Choroidal neovascularization (CNV)\n- Diabetic macular edema (DME)\n- Drusen (drusenoid dystrophy)\n- Normal\n\n3. Chest CT (lungs):\n- Pneumonia\n- Tuberculosis\n- COVID‑19\n- Normal\n\nWe regularly update and expand the list of supported conditions based on new clinical data and global medical guidelines.';

  @override
  String get infoLimitationsTitle => 'Limitations';

  @override
  String get infoLimitationsBody => 'Despite high accuracy, our system has a number of technical and clinical limitations. We strive for the most correct interpretation; however:\n- Results are for reference only and do not replace an in‑person doctor consultation.\n- The system does not detect rare or atypical pathologies outside the supported list.\n- Low‑quality, artifact‑ridden or cropped photos may be misclassified or rejected.\n- Printed scans, screenshots or distorted images (glare, overlays) may lead to incorrect results.\n\nThe user is responsible for the correctness of the uploaded image.';

  @override
  String get infoFaqTitle => 'FAQ';

  @override
  String get infoFaqBody => 'Frequently Asked Questions (FAQ)\n\n- Can I upload photos from a phone?\nYes, if quality requirements are met (see “Photos”).\n\n- Is the original scanner file required?\nNo. A clear photo of the screen is acceptable if it is sharp, uncropped and without glare.\n\n- How long does analysis take?\nUsually from a few seconds to one minute depending on server load.\n\n- Can I use old scans?\nYes, if they are of good quality and meet technical requirements.\n\n- What if I doubt the result?\nConsult a specialist. The system supports decision‑making, not final diagnosis.';

  @override
  String get infoValidationTitle => 'Accuracy & validation';

  @override
  String get infoValidationBody => 'System accuracy is confirmed by a series of validation tests on representative datasets. We use advanced deep learning and computer vision methods repeatedly verified on clinical data.\n\nIndividual models are developed for each pathology, trained on thousands of annotated images with certified physicians. Average sensitivity and specificity for major classes exceed 90%.\n\nContinuous model retraining and strict quality control ensure stability and reliability of results.';

  @override
  String get infoAboutTitle => 'About the system';

  @override
  String get infoAboutBody => 'Our platform is an intelligent clinical decision support system designed to analyse diagnostic images using artificial intelligence.\n\nThe goal is to provide doctors and patients with a preliminary analysis tool that accelerates pathology detection and improves diagnostic accuracy.\n\nThe system is adapted for various study types (MRI, CT, OCT) and can be used in clinical practice or personally.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profilePersonalDataTitle => 'Personal data';

  @override
  String get profileMedicalInfoTitle => 'Medical information';

  @override
  String get profileStatsTitle => 'MyScan statistics';

  @override
  String get profileInsuranceTitle => 'Insurance';

  @override
  String get profileEmergencyContactsTitle => 'Emergency contacts';

  @override
  String get profileHistoryButton => 'Scan history';

  @override
  String get profileDOBLabel => 'Date of birth';

  @override
  String get profileAgeLabel => 'Age';

  @override
  String get profileGenderLabel => 'Gender';

  @override
  String get profileAddressLabel => 'Address';

  @override
  String get profileClinicLabel => 'Assigned clinic';

  @override
  String get profileDoctorLabel => 'Primary doctor';

  @override
  String get profileBloodGroupLabel => 'Blood group';

  @override
  String get profileAllergiesLabel => 'Allergies';

  @override
  String get profileChronicDiseasesLabel => 'Chronic diseases';

  @override
  String get profileLastCheckupLabel => 'Last check-up';

  @override
  String get profilePolicyLabel => 'Policy';

  @override
  String get profileValidUntilLabel => 'Valid until';

  @override
  String get profileMotherLabel => 'Mother';

  @override
  String get profileFatherLabel => 'Father';

  @override
  String get profileNameValue => 'Alisher Omarov';

  @override
  String get profilePhoneValue => '+7 747 193 6733';

  @override
  String get profileEmailValue => 'alisher.omarov@example.kz';

  @override
  String get profileDOBValue => '14 March 2006';

  @override
  String get profileAgeValue => '18 years';

  @override
  String get profileGenderValue => 'male';

  @override
  String get profileAddressValue => 'Almaty, Seifullin Ave. 215, apt. 48';

  @override
  String get profileClinicValue => 'City Polyclinic No. 12';

  @override
  String get profileDoctorValue => 'Turebaeva Zh. K. (therapist)';

  @override
  String get profileBloodGroupValue => 'O (I) Rh +';

  @override
  String get profileAllergiesValue => 'no data';

  @override
  String get profileChronicDiseasesValue => 'bronchial asthma (mild, controlled)';

  @override
  String get profileLastCheckupValue => '12 October 2024';

  @override
  String get profilePolicyValue => 'MedLife JSC No. B‑374‑221‑99';

  @override
  String get profilePolicyValidUntilValue => '31 December 2025';

  @override
  String get profileMotherValue => 'Omarova Aizhan • +7 701 555 2244';

  @override
  String get profileFatherValue => 'Omarov Nurlan • +7 701 888 1321';

  @override
  String get profileStatBrainMRI => 'Brain MRI';

  @override
  String get profileStatLungCT => 'Lung CT';

  @override
  String get profileStatRetinaOCT => 'Retina OCT';

  @override
  String get reportsTitle => 'Generate report';

  @override
  String get reportsSubtitle => 'AI will format your complaints, symptoms\nand images into a clear PDF for your doctor';

  @override
  String get reportsPickImageTitle => 'Choose an image:';

  @override
  String get reportsComplaintsTitle => 'List your complaints:';

  @override
  String get reportsComplaintHint => 'Describe symptoms…';

  @override
  String get reportsSubmitButton => 'Generate';

  @override
  String get reportsEmptyError => 'Please describe your symptoms';

  @override
  String reportsOpenError(String error) {
    return 'Failed to open report: $error';
  }

  @override
  String get chatTitle => 'MyScanAI';

  @override
  String get chatCloseTooltip => 'Close';

  @override
  String get chatHint => 'Your question…';

  @override
  String chatError(String error) {
    return 'Error: $error';
  }

  @override
  String get chatDummy1 => 'Hello! I\'m MyScanAI. How can I help you? 😊';

  @override
  String get chatDummy2 => 'Yes, passive smoking increases the risk of pneumonia. Inhaled toxic substances damage the airway lining and weaken local immunity, making it easier for pathogens to enter.';

  @override
  String get diagNormalName => 'Normal';

  @override
  String get diagPneumoniaName => 'Pneumonia';

  @override
  String get diagCNVName => 'Choroidal neovascularization (CNV)';

  @override
  String get diagDMEName => 'Diabetic macular edema (DME)';

  @override
  String get diagDrusenName => 'Drusen';

  @override
  String get diagGliomaName => 'Glioma';

  @override
  String get diagMeningiomaName => 'Meningioma';

  @override
  String get diagPituitaryName => 'Pituitary adenoma';

  @override
  String get diagNoTumorName => 'No tumor';
}
