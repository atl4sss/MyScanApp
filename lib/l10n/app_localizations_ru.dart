// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'MyScan';

  @override
  String get homeSelectModality => 'Выберите вид\nтомографии:';

  @override
  String get homeDescriptionPrefix => 'Наша программа определит большинство заболеваний с точностью до 97%. Подробнее о спектре заболеваний можно узнать ';

  @override
  String get homeDescriptionLink => 'здесь';

  @override
  String get homeDescriptionSuffix => '.';

  @override
  String get homeLungs => 'КТ лёгких';

  @override
  String get homeOct => 'ОКТ глаза';

  @override
  String get homeBrain => 'МРТ мозга';

  @override
  String get modalityLungsTitle => 'Компьютерная томография лёгких';

  @override
  String get modalityLungsHintPrefix => 'Как правильно фотографировать — смотрите ';

  @override
  String get modalityLungsHintLink => 'здесь';

  @override
  String get modalityLungsHintSuffix => '.';

  @override
  String get modalityOctTitle => 'ОКТ глаза';

  @override
  String get modalityOctHintPrefix => 'Рекомендации по съёмке доступны ';

  @override
  String get modalityOctHintLink => 'здесь';

  @override
  String get modalityOctHintSuffix => '.';

  @override
  String get modalityBrainTitle => 'МРТ мозга';

  @override
  String get modalityBrainHintPrefix => 'Инструкции по качественному снимку — ';

  @override
  String get modalityBrainHintLink => 'здесь';

  @override
  String get modalityBrainHintSuffix => '.';

  @override
  String get attachPhotoTitle => 'Прикрепите фотографию:';

  @override
  String get analyzeButton => 'Анализ';

  @override
  String analysisError(String error) {
    return 'Ошибка анализа: $error';
  }

  @override
  String get resultTitle => 'Результат анализа';

  @override
  String get backButton => 'Вернуться назад';

  @override
  String get pillRisks => 'Риски';

  @override
  String get pillPrevention => 'Профилактика';

  @override
  String get pillContact => 'Связаться с врачом';

  @override
  String get pillCauses => 'Причины';

  @override
  String get infoUnavailable => 'Информация пока недоступна.';

  @override
  String diagnosisProbability(String diagnosis, String percent) {
    return '$diagnosis ($percent%)';
  }

  @override
  String get diagPneumoniaBrief => 'Пневмония — острое воспаление лёгочной ткани, чаще всего вызванное бактериями или вирусами. Тяжесть течения зависит от вида возбудителя, возраста пациента и сопутствующих заболеваний.';

  @override
  String get diagPneumoniaRisks => '• Острые осложнения: плеврит, абсцесс лёгкого, сепсис.\n• Возможны хронические последствия: снижение функции лёгких, формирование бронхоэктазов.\n• Особенно опасна для детей младше 5 лет, пожилых и лиц с иммунодефицитом.';

  @override
  String get diagPneumoniaPrevention => '• Вакцинация (пневмококковая, против гриппа, COVID‑19).\n• Отказ от курения, регулярная физическая активность.\n• Своевременное лечение простудных и ЛОР‑инфекций.';

  @override
  String get diagPneumoniaContact => 'Температура > 38 °C дольше 3 дней, одышка или боль в груди — обратитесь к терапевту/пульмонологу.\n\n📞 103 — единый номер скорой помощи\n📞 Горячая линия Минздрава РК: 8 800 080 88 87';

  @override
  String get diagPneumoniaCauses => '• Бактерии (чаще Streptococcus pneumoniae, Haemophilus influenzae).\n• Вирусы (грипп, SARS‑CoV‑2 и др.).\n• Атипичные агенты (Mycoplasma, Chlamydophila).\n• Аспирация желудочного содержимого.';

  @override
  String get diagMeningiomaBrief => 'Менингиома — доброкачественная опухоль мозговых оболочек, растёт медленно и нередко выявляется случайно. Может вызывать головные боли, судороги и очаговые неврологические симптомы за счёт сдавления тканей.';

  @override
  String get diagMeningiomaRisks => '• Сдавление структур мозга → слабость конечностей, нарушение речи, зрения.\n• Отёк мозга и повышение внутричерепного давления (головная боль, тошнота, судороги).\n• Поражение черепных нервов при базальной локализации.\n• Редкая (< 2%) малигнизация до атипичной/анапластической формы.';

  @override
  String get diagMeningiomaPrevention => 'Специфических мер нет, однако:\n• Минимизируйте ненужное рентген-/γ-излучение.\n• Контролируйте гормонотерапию с врачом.\n• Поддерживайте сосудистое и метаболическое здоровье.\n• Регулярные МР-скрининги при NF2 или облучении головы в анамнезе.';

  @override
  String get diagMeningiomaContact => 'Обратитесь к нейрохирургу/неврологу, если появились:\n• Стойкие прогрессирующие головные боли.\n• Новые судорожные приступы.\n• Нарушения зрения, слуха, парезы.\n\n📞 Республиканский нейрохирургический центр: +7 7172 62‑18‑27\n📞 Экстренная помощь: 103';

  @override
  String get diagMeningiomaCauses => '• Ионизирующее излучение — доказанный фактор риска.\n• Генетические синдромы (NF2).\n• Гормональное влияние: у женщин в 2–3 раза чаще.\n• Травмы и хроническое воспаление обсуждаются, но доказательств мало.\n\n⚠️ В большинстве случаев менингиома доброкачественна (Grade I) и растёт медленно; тактика — наблюдение, хирургия или радиохирургия.';

  @override
  String get infoTitle => 'Информационная доска';

  @override
  String get infoPrivacyTitle => 'Конф.';

  @override
  String get infoPrivacyBody => 'Конфиденциальность\n\nМы строго соблюдаем принципы конфиденциальности и защиты персональных данных. Все данные, передаваемые через нашу платформу, включая медицинские сканы, отчёты, жалобы, пароли и иную пользовательскую информацию, хранятся в зашифрованном виде и подлежат надёжной защите.\nНаша система соответствует действующим стандартам информационной безопасности и нормам законодательства Республики Казахстан.';

  @override
  String get infoPhotoTitle => 'Фото';

  @override
  String get infoPhotoBody => 'Для корректной обработки изображения и точной диагностики крайне важно соблюдать требования к качеству загружаемых снимков. Пожалуйста, ознакомьтесь с рекомендациями перед отправкой файлов.\n\n• Полный охват изображения: снимок должен полностью помещаться в кадре, без обрезанных участков.\n• Освещение: фотографируйте при хорошем, равномерном освещении. Избегайте бликов, теней и пересветов.\n• Формат файлов: поддерживаются PNG и JPEG (JPG).';

  @override
  String get infoDiseasesTitle => 'Болезни';

  @override
  String get infoDiseasesBody => 'Наша система поддерживает автоматическое распознавание широкого спектра патологий и состояний на основе различных медицинских изображений. Алгоритмы проходят валидацию по международным стандартам и адаптированы под клиническую практику.\n\n1. МРТ головного мозга:\n- Аденома гипофиза\n- Глиома\n- Менингиома\n- Норма\n\n2. ОСТ (оптическая когерентная томография) сетчатки глаза:\n- Хориоидальная неоваскуляризация (ХНВ)\n- Диабетический макулярный отёк (ДМО)\n- Друзенозная дистрофия (друзены)\n- Норма\n\n3. КТ органов грудной клетки (лёгкие):\n- Пневмония\n- Туберкулёз\n- COVID‑19\n- Норма\n\nМы регулярно обновляем и расширяем перечень поддерживаемых состояний с учётом новых клинических данных и рекомендаций мировых медицинских сообществ.';

  @override
  String get infoLimitationsTitle => 'Ограничения';

  @override
  String get infoLimitationsBody => 'Несмотря на высокую точность, наша система имеет ряд технических и клинических ограничений. Мы стремимся к максимально корректной интерпретации данных, однако:\n- Результаты носят справочный характер и не заменяют очную консультацию врача.\n- Система не распознаёт редкие или нетипичные патологии, не входящие в перечень поддерживаемых.\n- Фотографии низкого качества, с артефактами или обрезанные могут быть распознаны с ошибками или не обработаны вовсе.\n- Распечатанные снимки, скриншоты или изображения с искажениями (блики, наложения) могут привести к некорректным результатам.\n\nПользователь несёт ответственность за корректность загружаемого изображения.';

  @override
  String get infoFaqTitle => 'FAQ';

  @override
  String get infoFaqBody => 'Часто задаваемые вопросы (FAQ)\n\n- Можно ли загружать фото с телефона?\nДа, при условии соблюдения требований к качеству снимка (см. раздел «Фото»).\n\n- Обязателен ли оригинальный файл с томографа?\nНет. Пригодна и фотография экрана, если она чёткая, без обрезаний и бликов.\n\n- Сколько времени занимает анализ?\nКак правило, от нескольких секунд до минуты в зависимости от загрузки сервера.\n\n- Можно ли использовать старые снимки?\nДа, если они хорошего качества и соответствуют техническим требованиям.\n\n- Что делать, если результат вызывает сомнения?\nОбратитесь к профильному специалисту. Система предназначена для поддержки принятия решений, а не постановки диагноза.';

  @override
  String get infoValidationTitle => 'Точность и валидация';

  @override
  String get infoValidationBody => 'Точность работы системы подтверждена серией валидационных испытаний на репрезентативных датасетах. Используются передовые методы глубинного обучения и компьютерного зрения, прошедшие многократную проверку на клинических данных.\n\nДля каждой патологии разрабатываются индивидуальные модели, обученные на тысячах размеченных изображений с участием сертифицированных врачей. Средняя чувствительность и специфичность по основным классам превышает 90%.\n\nПостоянное дообучение моделей и строгий контроль качества гарантируют стабильность и надёжность результатов.';

  @override
  String get infoAboutTitle => 'О системе';

  @override
  String get infoAboutBody => 'Наша платформа — это интеллектуальная система поддержки медицинских решений, разработанная для анализа диагностических изображений с применением искусственного интеллекта.\n\nЦель проекта — предоставить врачам и пациентам инструмент предварительного анализа изображений, способный ускорить выявление патологий и повысить точность диагностики.\n\nСистема адаптирована под различные типы исследований (МРТ, КТ, ОСТ) и может использоваться как в клинической практике, так и для личного пользования.';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get profilePersonalDataTitle => 'Персональные данные';

  @override
  String get profileMedicalInfoTitle => 'Медицинская информация';

  @override
  String get profileStatsTitle => 'Статистика MyScan';

  @override
  String get profileInsuranceTitle => 'Страхование';

  @override
  String get profileEmergencyContactsTitle => 'Экстренные контакты';

  @override
  String get profileHistoryButton => 'История сканов';

  @override
  String get profileDOBLabel => 'Дата рождения';

  @override
  String get profileAgeLabel => 'Возраст';

  @override
  String get profileGenderLabel => 'Пол';

  @override
  String get profileAddressLabel => 'Адрес';

  @override
  String get profileClinicLabel => 'Приписанная поликлиника';

  @override
  String get profileDoctorLabel => 'Участковый врач';

  @override
  String get profileBloodGroupLabel => 'Группа крови';

  @override
  String get profileAllergiesLabel => 'Аллергии';

  @override
  String get profileChronicDiseasesLabel => 'Хронические заболевания';

  @override
  String get profileLastCheckupLabel => 'Последняя диспансеризация';

  @override
  String get profilePolicyLabel => 'Полис';

  @override
  String get profileValidUntilLabel => 'Действителен до';

  @override
  String get profileMotherLabel => 'Мать';

  @override
  String get profileFatherLabel => 'Отец';

  @override
  String get profileNameValue => 'Омаров Алишер Нурланович';

  @override
  String get profilePhoneValue => '+7 747 193 6733';

  @override
  String get profileEmailValue => 'alisher.omarov@example.kz';

  @override
  String get profileDOBValue => '14 марта 2006 г.';

  @override
  String get profileAgeValue => '18 лет';

  @override
  String get profileGenderValue => 'мужской';

  @override
  String get profileAddressValue => 'г. Алматы, пр. Сейфуллина 215, кв. 48';

  @override
  String get profileClinicValue => 'Городская поликлиника № 12';

  @override
  String get profileDoctorValue => 'Туребаева Ж. К. (терапевт)';

  @override
  String get profileBloodGroupValue => 'O (I) Rh +';

  @override
  String get profileAllergiesValue => 'нет данных';

  @override
  String get profileChronicDiseasesValue => 'бронхиальная астма (лёгкая, под контролем)';

  @override
  String get profileLastCheckupValue => '12 октября 2024 г.';

  @override
  String get profilePolicyValue => 'АО «MedLife» № B‑374‑221‑99';

  @override
  String get profilePolicyValidUntilValue => '31 декабря 2025 г.';

  @override
  String get profileMotherValue => 'Омарова Айжан • +7 701 555 2244';

  @override
  String get profileFatherValue => 'Омаров Нурлан • +7 701 888 1321';

  @override
  String get profileStatBrainMRI => 'МРТ головного мозга';

  @override
  String get profileStatLungCT => 'КТ лёгких';

  @override
  String get profileStatRetinaOCT => 'ОСТ сетчатки';

  @override
  String get reportsTitle => 'Оформить отчёт';

  @override
  String get reportsSubtitle => 'ИИ оформит ваши жалобы, симптомы и\nснимки в понятном, удобном для\nтерапевта PDF‑формате';

  @override
  String get reportsPickImageTitle => 'Выберите снимок:';

  @override
  String get reportsComplaintsTitle => 'Выпишите ваши жалобы:';

  @override
  String get reportsComplaintHint => 'Опишите симптомы…';

  @override
  String get reportsSubmitButton => 'Оформить';

  @override
  String get reportsEmptyError => 'Пожалуйста, опишите ваши симптомы';

  @override
  String reportsOpenError(String error) {
    return 'Не удалось открыть отчёт: $error';
  }

  @override
  String get chatTitle => 'MyScanAI';

  @override
  String get chatCloseTooltip => 'Закрыть';

  @override
  String get chatHint => 'Ваш вопрос…';

  @override
  String chatError(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get chatDummy1 => 'Привет! Я MyScanAI. Чем могу помочь? 😊';

  @override
  String get chatDummy2 => 'Да, пассивное курение повышает риск развития пневмонии. Вдыхаемые токсичные вещества повреждают слизистую оболочку дыхательных путей и ослабляют местный иммунитет, что облегчает проникновение патогенов.';

  @override
  String get diagNormalName => 'Норма';

  @override
  String get diagPneumoniaName => 'Пневмония';

  @override
  String get diagCNVName => 'Хориоидальная неоваскуляризация (ХНВ)';

  @override
  String get diagDMEName => 'Диабетический макулярный отёк (ДМО)';

  @override
  String get diagDrusenName => 'Друзенозная дистрофия (друзены)';

  @override
  String get diagGliomaName => 'Глиома';

  @override
  String get diagMeningiomaName => 'Менингиома';

  @override
  String get diagPituitaryName => 'Аденома гипофиза';

  @override
  String get diagNoTumorName => 'Без опухоли';
}
