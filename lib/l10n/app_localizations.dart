import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MyScan'**
  String get appTitle;

  /// No description provided for @homeSelectModality.
  ///
  /// In en, this message translates to:
  /// **'Choose imaging\nmodality:'**
  String get homeSelectModality;

  /// No description provided for @homeDescriptionPrefix.
  ///
  /// In en, this message translates to:
  /// **'Our program detects most diseases with up to 97% accuracy. Read more about the spectrum of diseases '**
  String get homeDescriptionPrefix;

  /// No description provided for @homeDescriptionLink.
  ///
  /// In en, this message translates to:
  /// **'here'**
  String get homeDescriptionLink;

  /// No description provided for @homeDescriptionSuffix.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get homeDescriptionSuffix;

  /// No description provided for @homeLungs.
  ///
  /// In en, this message translates to:
  /// **'Lung CT'**
  String get homeLungs;

  /// No description provided for @homeOct.
  ///
  /// In en, this message translates to:
  /// **'Eye OCT'**
  String get homeOct;

  /// No description provided for @homeBrain.
  ///
  /// In en, this message translates to:
  /// **'Brain MRI'**
  String get homeBrain;

  /// No description provided for @modalityLungsTitle.
  ///
  /// In en, this message translates to:
  /// **'Lung CT scan'**
  String get modalityLungsTitle;

  /// No description provided for @modalityLungsHintPrefix.
  ///
  /// In en, this message translates to:
  /// **'How to photograph correctly — see '**
  String get modalityLungsHintPrefix;

  /// No description provided for @modalityLungsHintLink.
  ///
  /// In en, this message translates to:
  /// **'here'**
  String get modalityLungsHintLink;

  /// No description provided for @modalityLungsHintSuffix.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get modalityLungsHintSuffix;

  /// No description provided for @modalityOctTitle.
  ///
  /// In en, this message translates to:
  /// **'Eye OCT'**
  String get modalityOctTitle;

  /// No description provided for @modalityOctHintPrefix.
  ///
  /// In en, this message translates to:
  /// **'Shooting recommendations are available '**
  String get modalityOctHintPrefix;

  /// No description provided for @modalityOctHintLink.
  ///
  /// In en, this message translates to:
  /// **'here'**
  String get modalityOctHintLink;

  /// No description provided for @modalityOctHintSuffix.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get modalityOctHintSuffix;

  /// No description provided for @modalityBrainTitle.
  ///
  /// In en, this message translates to:
  /// **'Brain MRI'**
  String get modalityBrainTitle;

  /// No description provided for @modalityBrainHintPrefix.
  ///
  /// In en, this message translates to:
  /// **'Instructions for a quality image — '**
  String get modalityBrainHintPrefix;

  /// No description provided for @modalityBrainHintLink.
  ///
  /// In en, this message translates to:
  /// **'here'**
  String get modalityBrainHintLink;

  /// No description provided for @modalityBrainHintSuffix.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get modalityBrainHintSuffix;

  /// No description provided for @attachPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Attach a photo:'**
  String get attachPhotoTitle;

  /// No description provided for @analyzeButton.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get analyzeButton;

  /// No description provided for @analysisError.
  ///
  /// In en, this message translates to:
  /// **'Analysis error: {error}'**
  String analysisError(String error);

  /// No description provided for @resultTitle.
  ///
  /// In en, this message translates to:
  /// **'Analysis result'**
  String get resultTitle;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get backButton;

  /// No description provided for @pillRisks.
  ///
  /// In en, this message translates to:
  /// **'Risks'**
  String get pillRisks;

  /// No description provided for @pillPrevention.
  ///
  /// In en, this message translates to:
  /// **'Prevention'**
  String get pillPrevention;

  /// No description provided for @pillContact.
  ///
  /// In en, this message translates to:
  /// **'Contact a doctor'**
  String get pillContact;

  /// No description provided for @pillCauses.
  ///
  /// In en, this message translates to:
  /// **'Causes'**
  String get pillCauses;

  /// No description provided for @infoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Information is not available yet.'**
  String get infoUnavailable;

  /// No description provided for @diagnosisProbability.
  ///
  /// In en, this message translates to:
  /// **'{diagnosis} ({percent}%)'**
  String diagnosisProbability(String diagnosis, String percent);

  /// No description provided for @diagPneumoniaBrief.
  ///
  /// In en, this message translates to:
  /// **'Pneumonia is an acute inflammation of lung tissue, most often caused by bacteria or viruses. Severity depends on the pathogen type, patient age, and comorbidities.'**
  String get diagPneumoniaBrief;

  /// No description provided for @diagPneumoniaRisks.
  ///
  /// In en, this message translates to:
  /// **'• Acute complications: pleurisy, lung abscess, sepsis.\n• Possible chronic outcomes: decreased lung function, bronchiectasis.\n• Especially dangerous for children under 5, the elderly, and immunocompromised people.'**
  String get diagPneumoniaRisks;

  /// No description provided for @diagPneumoniaPrevention.
  ///
  /// In en, this message translates to:
  /// **'• Vaccination (pneumococcal, influenza, COVID‑19).\n• Avoid smoking, maintain regular physical activity.\n• Timely treatment of colds and ENT infections.'**
  String get diagPneumoniaPrevention;

  /// No description provided for @diagPneumoniaContact.
  ///
  /// In en, this message translates to:
  /// **'Fever > 38 °C for more than 3 days, shortness of breath or chest pain — contact a therapist/pulmonologist.\n\n📞 103 — emergency ambulance\n📞 Ministry of Health hotline: 8 800 080 88 87'**
  String get diagPneumoniaContact;

  /// No description provided for @diagPneumoniaCauses.
  ///
  /// In en, this message translates to:
  /// **'• Bacteria (most often Streptococcus pneumoniae, Haemophilus influenzae).\n• Viruses (influenza, SARS‑CoV‑2, etc.).\n• Atypical agents (Mycoplasma, Chlamydophila).\n• Aspiration of gastric contents.'**
  String get diagPneumoniaCauses;

  /// No description provided for @diagMeningiomaBrief.
  ///
  /// In en, this message translates to:
  /// **'A meningioma is a benign tumor of the meninges; it grows slowly and is often found incidentally. It may cause headaches, seizures and focal neurological symptoms due to compression.'**
  String get diagMeningiomaBrief;

  /// No description provided for @diagMeningiomaRisks.
  ///
  /// In en, this message translates to:
  /// **'• Brain structure compression → limb weakness, speech or vision problems.\n• Brain edema and raised intracranial pressure (headache, nausea, seizures).\n• Cranial nerve involvement in basal location.\n• Rare (< 2%) malignant transformation to atypical/anaplastic form.'**
  String get diagMeningiomaRisks;

  /// No description provided for @diagMeningiomaPrevention.
  ///
  /// In en, this message translates to:
  /// **'No specific measures; however:\n• Minimize unnecessary radiation (CT without indication).\n• Manage hormone therapy with your doctor.\n• Maintain vascular/metabolic health.\n• Regular MRI screening for NF2 or prior head irradiation.'**
  String get diagMeningiomaPrevention;

  /// No description provided for @diagMeningiomaContact.
  ///
  /// In en, this message translates to:
  /// **'Consult a neurosurgeon/neurologist if you have:\n• Persistent progressive headaches.\n• New seizure episodes.\n• Visual/hearing disturbances or paresis.\n\n📞 Republican Neurosurgery Center: +7 7172 62‑18‑27\n📞 Emergency: 103'**
  String get diagMeningiomaContact;

  /// No description provided for @diagMeningiomaCauses.
  ///
  /// In en, this message translates to:
  /// **'• Ionizing radiation — the most proven factor.\n• Genetic syndromes (NF2).\n• Hormonal influence: 2–3× more common in women.\n• Trauma and chronic inflammation are discussed but weakly proven.\n\n⚠️ Most meningiomas are benign (Grade I) and slow-growing; management includes observation, microsurgery or radiosurgery.'**
  String get diagMeningiomaCauses;

  /// No description provided for @infoTitle.
  ///
  /// In en, this message translates to:
  /// **'Information board'**
  String get infoTitle;

  /// No description provided for @infoPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get infoPrivacyTitle;

  /// No description provided for @infoPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'Privacy\n\nWe strictly follow principles of confidentiality and personal data protection. All data transferred through our platform — medical scans, reports, complaints, passwords and other user information — are stored in encrypted form and securely protected.\nOur system complies with current information security standards and the legislation of the Republic of Kazakhstan.'**
  String get infoPrivacyBody;

  /// No description provided for @infoPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get infoPhotoTitle;

  /// No description provided for @infoPhotoBody.
  ///
  /// In en, this message translates to:
  /// **'For correct image processing and accurate diagnostics it is crucial to meet quality requirements. Please read the recommendations before uploading files.\n\n• Full frame coverage: the image must fully fit without cropped areas.\n• Lighting: take photos in good, even light. Avoid glare, shadows and overexposure.\n• File formats: PNG and JPEG (JPG) are supported.'**
  String get infoPhotoBody;

  /// No description provided for @infoDiseasesTitle.
  ///
  /// In en, this message translates to:
  /// **'Diseases'**
  String get infoDiseasesTitle;

  /// No description provided for @infoDiseasesBody.
  ///
  /// In en, this message translates to:
  /// **'Our system supports automatic recognition of a wide range of pathologies and conditions based on different medical images. The algorithms are validated against international standards and adapted to clinical practice.\n\n1. Brain MRI:\n- Pituitary adenoma\n- Glioma\n- Meningioma\n- Normal\n\n2. Eye OCT (retina):\n- Choroidal neovascularization (CNV)\n- Diabetic macular edema (DME)\n- Drusen (drusenoid dystrophy)\n- Normal\n\n3. Chest CT (lungs):\n- Pneumonia\n- Tuberculosis\n- COVID‑19\n- Normal\n\nWe regularly update and expand the list of supported conditions based on new clinical data and global medical guidelines.'**
  String get infoDiseasesBody;

  /// No description provided for @infoLimitationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Limitations'**
  String get infoLimitationsTitle;

  /// No description provided for @infoLimitationsBody.
  ///
  /// In en, this message translates to:
  /// **'Despite high accuracy, our system has a number of technical and clinical limitations. We strive for the most correct interpretation; however:\n- Results are for reference only and do not replace an in‑person doctor consultation.\n- The system does not detect rare or atypical pathologies outside the supported list.\n- Low‑quality, artifact‑ridden or cropped photos may be misclassified or rejected.\n- Printed scans, screenshots or distorted images (glare, overlays) may lead to incorrect results.\n\nThe user is responsible for the correctness of the uploaded image.'**
  String get infoLimitationsBody;

  /// No description provided for @infoFaqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get infoFaqTitle;

  /// No description provided for @infoFaqBody.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions (FAQ)\n\n- Can I upload photos from a phone?\nYes, if quality requirements are met (see “Photos”).\n\n- Is the original scanner file required?\nNo. A clear photo of the screen is acceptable if it is sharp, uncropped and without glare.\n\n- How long does analysis take?\nUsually from a few seconds to one minute depending on server load.\n\n- Can I use old scans?\nYes, if they are of good quality and meet technical requirements.\n\n- What if I doubt the result?\nConsult a specialist. The system supports decision‑making, not final diagnosis.'**
  String get infoFaqBody;

  /// No description provided for @infoValidationTitle.
  ///
  /// In en, this message translates to:
  /// **'Accuracy & validation'**
  String get infoValidationTitle;

  /// No description provided for @infoValidationBody.
  ///
  /// In en, this message translates to:
  /// **'System accuracy is confirmed by a series of validation tests on representative datasets. We use advanced deep learning and computer vision methods repeatedly verified on clinical data.\n\nIndividual models are developed for each pathology, trained on thousands of annotated images with certified physicians. Average sensitivity and specificity for major classes exceed 90%.\n\nContinuous model retraining and strict quality control ensure stability and reliability of results.'**
  String get infoValidationBody;

  /// No description provided for @infoAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About the system'**
  String get infoAboutTitle;

  /// No description provided for @infoAboutBody.
  ///
  /// In en, this message translates to:
  /// **'Our platform is an intelligent clinical decision support system designed to analyse diagnostic images using artificial intelligence.\n\nThe goal is to provide doctors and patients with a preliminary analysis tool that accelerates pathology detection and improves diagnostic accuracy.\n\nThe system is adapted for various study types (MRI, CT, OCT) and can be used in clinical practice or personally.'**
  String get infoAboutBody;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profilePersonalDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal data'**
  String get profilePersonalDataTitle;

  /// No description provided for @profileMedicalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Medical information'**
  String get profileMedicalInfoTitle;

  /// No description provided for @profileStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'MyScan statistics'**
  String get profileStatsTitle;

  /// No description provided for @profileInsuranceTitle.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get profileInsuranceTitle;

  /// No description provided for @profileEmergencyContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency contacts'**
  String get profileEmergencyContactsTitle;

  /// No description provided for @profileHistoryButton.
  ///
  /// In en, this message translates to:
  /// **'Scan history'**
  String get profileHistoryButton;

  /// No description provided for @profileDOBLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get profileDOBLabel;

  /// No description provided for @profileAgeLabel.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get profileAgeLabel;

  /// No description provided for @profileGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get profileGenderLabel;

  /// No description provided for @profileAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get profileAddressLabel;

  /// No description provided for @profileClinicLabel.
  ///
  /// In en, this message translates to:
  /// **'Assigned clinic'**
  String get profileClinicLabel;

  /// No description provided for @profileDoctorLabel.
  ///
  /// In en, this message translates to:
  /// **'Primary doctor'**
  String get profileDoctorLabel;

  /// No description provided for @profileBloodGroupLabel.
  ///
  /// In en, this message translates to:
  /// **'Blood group'**
  String get profileBloodGroupLabel;

  /// No description provided for @profileAllergiesLabel.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get profileAllergiesLabel;

  /// No description provided for @profileChronicDiseasesLabel.
  ///
  /// In en, this message translates to:
  /// **'Chronic diseases'**
  String get profileChronicDiseasesLabel;

  /// No description provided for @profileLastCheckupLabel.
  ///
  /// In en, this message translates to:
  /// **'Last check-up'**
  String get profileLastCheckupLabel;

  /// No description provided for @profilePolicyLabel.
  ///
  /// In en, this message translates to:
  /// **'Policy'**
  String get profilePolicyLabel;

  /// No description provided for @profileValidUntilLabel.
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get profileValidUntilLabel;

  /// No description provided for @profileMotherLabel.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get profileMotherLabel;

  /// No description provided for @profileFatherLabel.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get profileFatherLabel;

  /// No description provided for @profileNameValue.
  ///
  /// In en, this message translates to:
  /// **'Alisher Omarov'**
  String get profileNameValue;

  /// No description provided for @profilePhoneValue.
  ///
  /// In en, this message translates to:
  /// **'+7 747 193 6733'**
  String get profilePhoneValue;

  /// No description provided for @profileEmailValue.
  ///
  /// In en, this message translates to:
  /// **'alisher.omarov@example.kz'**
  String get profileEmailValue;

  /// No description provided for @profileDOBValue.
  ///
  /// In en, this message translates to:
  /// **'14 March 2006'**
  String get profileDOBValue;

  /// No description provided for @profileAgeValue.
  ///
  /// In en, this message translates to:
  /// **'18 years'**
  String get profileAgeValue;

  /// No description provided for @profileGenderValue.
  ///
  /// In en, this message translates to:
  /// **'male'**
  String get profileGenderValue;

  /// No description provided for @profileAddressValue.
  ///
  /// In en, this message translates to:
  /// **'Almaty, Seifullin Ave. 215, apt. 48'**
  String get profileAddressValue;

  /// No description provided for @profileClinicValue.
  ///
  /// In en, this message translates to:
  /// **'City Polyclinic No. 12'**
  String get profileClinicValue;

  /// No description provided for @profileDoctorValue.
  ///
  /// In en, this message translates to:
  /// **'Turebaeva Zh. K. (therapist)'**
  String get profileDoctorValue;

  /// No description provided for @profileBloodGroupValue.
  ///
  /// In en, this message translates to:
  /// **'O (I) Rh +'**
  String get profileBloodGroupValue;

  /// No description provided for @profileAllergiesValue.
  ///
  /// In en, this message translates to:
  /// **'no data'**
  String get profileAllergiesValue;

  /// No description provided for @profileChronicDiseasesValue.
  ///
  /// In en, this message translates to:
  /// **'bronchial asthma (mild, controlled)'**
  String get profileChronicDiseasesValue;

  /// No description provided for @profileLastCheckupValue.
  ///
  /// In en, this message translates to:
  /// **'12 October 2024'**
  String get profileLastCheckupValue;

  /// No description provided for @profilePolicyValue.
  ///
  /// In en, this message translates to:
  /// **'MedLife JSC No. B‑374‑221‑99'**
  String get profilePolicyValue;

  /// No description provided for @profilePolicyValidUntilValue.
  ///
  /// In en, this message translates to:
  /// **'31 December 2025'**
  String get profilePolicyValidUntilValue;

  /// No description provided for @profileMotherValue.
  ///
  /// In en, this message translates to:
  /// **'Omarova Aizhan • +7 701 555 2244'**
  String get profileMotherValue;

  /// No description provided for @profileFatherValue.
  ///
  /// In en, this message translates to:
  /// **'Omarov Nurlan • +7 701 888 1321'**
  String get profileFatherValue;

  /// No description provided for @profileStatBrainMRI.
  ///
  /// In en, this message translates to:
  /// **'Brain MRI'**
  String get profileStatBrainMRI;

  /// No description provided for @profileStatLungCT.
  ///
  /// In en, this message translates to:
  /// **'Lung CT'**
  String get profileStatLungCT;

  /// No description provided for @profileStatRetinaOCT.
  ///
  /// In en, this message translates to:
  /// **'Retina OCT'**
  String get profileStatRetinaOCT;

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Generate report'**
  String get reportsTitle;

  /// No description provided for @reportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'AI will format your complaints, symptoms\nand images into a clear PDF for your doctor'**
  String get reportsSubtitle;

  /// No description provided for @reportsPickImageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose an image:'**
  String get reportsPickImageTitle;

  /// No description provided for @reportsComplaintsTitle.
  ///
  /// In en, this message translates to:
  /// **'List your complaints:'**
  String get reportsComplaintsTitle;

  /// No description provided for @reportsComplaintHint.
  ///
  /// In en, this message translates to:
  /// **'Describe symptoms…'**
  String get reportsComplaintHint;

  /// No description provided for @reportsSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get reportsSubmitButton;

  /// No description provided for @reportsEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please describe your symptoms'**
  String get reportsEmptyError;

  /// No description provided for @reportsOpenError.
  ///
  /// In en, this message translates to:
  /// **'Failed to open report: {error}'**
  String reportsOpenError(String error);

  /// No description provided for @chatTitle.
  ///
  /// In en, this message translates to:
  /// **'MyScanAI'**
  String get chatTitle;

  /// No description provided for @chatCloseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get chatCloseTooltip;

  /// No description provided for @chatHint.
  ///
  /// In en, this message translates to:
  /// **'Your question…'**
  String get chatHint;

  /// No description provided for @chatError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String chatError(String error);

  /// No description provided for @chatDummy1.
  ///
  /// In en, this message translates to:
  /// **'Hello! I\'m MyScanAI. How can I help you? 😊'**
  String get chatDummy1;

  /// No description provided for @chatDummy2.
  ///
  /// In en, this message translates to:
  /// **'Yes, passive smoking increases the risk of pneumonia. Inhaled toxic substances damage the airway lining and weaken local immunity, making it easier for pathogens to enter.'**
  String get chatDummy2;

  /// No description provided for @diagNormalName.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get diagNormalName;

  /// No description provided for @diagPneumoniaName.
  ///
  /// In en, this message translates to:
  /// **'Pneumonia'**
  String get diagPneumoniaName;

  /// No description provided for @diagCNVName.
  ///
  /// In en, this message translates to:
  /// **'Choroidal neovascularization (CNV)'**
  String get diagCNVName;

  /// No description provided for @diagDMEName.
  ///
  /// In en, this message translates to:
  /// **'Diabetic macular edema (DME)'**
  String get diagDMEName;

  /// No description provided for @diagDrusenName.
  ///
  /// In en, this message translates to:
  /// **'Drusen'**
  String get diagDrusenName;

  /// No description provided for @diagGliomaName.
  ///
  /// In en, this message translates to:
  /// **'Glioma'**
  String get diagGliomaName;

  /// No description provided for @diagMeningiomaName.
  ///
  /// In en, this message translates to:
  /// **'Meningioma'**
  String get diagMeningiomaName;

  /// No description provided for @diagPituitaryName.
  ///
  /// In en, this message translates to:
  /// **'Pituitary adenoma'**
  String get diagPituitaryName;

  /// No description provided for @diagNoTumorName.
  ///
  /// In en, this message translates to:
  /// **'No tumor'**
  String get diagNoTumorName;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
