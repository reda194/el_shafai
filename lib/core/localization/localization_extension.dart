import 'package:flutter/material.dart';
import 'package:neurocare_app/core/localization/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations? get loc => AppLocalizations.of(this);

  String get appName => loc?.appName ?? 'شفائي';
  String get welcome => loc?.welcome ?? 'مرحباً بك';
  String get home => loc?.home ?? 'الرئيسية';
  String get appointments => loc?.appointments ?? 'المواعيد';
  String get doctors => loc?.doctors ?? 'الأطباء';
  String get chat => loc?.chat ?? 'المحادثة';
  String get profile => loc?.profile ?? 'الملف الشخصي';
  String get settings => loc?.settings ?? 'الإعدادات';
  String get notifications => loc?.notifications ?? 'الإشعارات';
  String get search => loc?.search ?? 'البحث';
  String get filter => loc?.filter ?? 'تصفية';
  String get bookAppointment => loc?.bookAppointment ?? 'حجز موعد';
  String get login => loc?.login ?? 'تسجيل الدخول';
  String get register => loc?.register ?? 'إنشاء حساب';
  String get logout => loc?.logout ?? 'تسجيل الخروج';
  String get save => loc?.save ?? 'حفظ';
  String get cancel => loc?.cancel ?? 'إلغاء';
  String get confirm => loc?.confirm ?? 'تأكيد';
  String get skip => loc?.skip ?? 'تخطي';
  String get next => loc?.next ?? 'التالي';
  String get previous => loc?.previous ?? 'السابق';
  String get done => loc?.done ?? 'تم';
  String get loading => loc?.loading ?? 'جاري التحميل...';
  String get error => loc?.error ?? 'خطأ';
  String get success => loc?.success ?? 'نجح';
  String get retry => loc?.retry ?? 'إعادة المحاولة';
  String get welcomeMessage =>
      loc?.get('welcome_message') ?? 'مرحباً بك في شفائي';
  String get welcomeSubtitle =>
      loc?.get('welcome_subtitle') ?? 'تطبيق الرعاية الصحية الشامل';
  String get getStarted => loc?.get('get_started') ?? 'ابدأ الآن';
  String get learnSomethingNew =>
      loc?.get('learn_something_new') ?? 'تعلم شيئاً جديداً';
  String get searchDoctor => loc?.get('search_doctor') ?? 'ابحث عن طبيب...';
  String get seeAll => loc?.get('see_all') ?? 'عرض الكل';
  String get quickServices => loc?.get('quick_services') ?? 'الخدمات السريعة';
  String get bookAppointmentService =>
      loc?.get('book_appointment_service') ?? 'حجز موعد';
  String get findDoctorNearby =>
      loc?.get('find_doctor_nearby') ?? 'العثور على طبيب قريب';
  String get medicalRecords => loc?.get('medical_records') ?? 'السجلات الطبية';
  String get chatService => loc?.get('chat_service') ?? 'المحادثة';
  String get featuredDoctors =>
      loc?.get('featured_doctors') ?? 'الأطباء المميزين';
  String get medicalSpecialties =>
      loc?.get('medical_specialties') ?? 'التخصصات الطبية';
  String get nearbyDoctors => loc?.get('nearby_doctors') ?? 'الأطباء القريبين';
  String get healthTips => loc?.get('health_tips') ?? 'نصائح صحية';
  String get teeth => loc?.get('teeth') ?? 'الأسنان';
  String get brain => loc?.get('brain') ?? 'الدماغ';
  String get lungs => loc?.get('lungs') ?? 'الرئتين';
  String get stomach => loc?.get('stomach') ?? 'المعدة';
  String get heart => loc?.get('heart') ?? 'القلب';
  String get checkStats => loc?.get('check_stats') ?? 'تحقق من إحصائياتك';
  String get welcomeUser => loc?.get('welcome_user') ?? 'مرحباً';
  String get personalInfo => loc?.get('personal_info') ?? 'المعلومات الشخصية';
  String get accountSettings =>
      loc?.get('account_settings') ?? 'إعدادات الحساب';
  String get notificationsSettings =>
      loc?.get('notifications_settings') ?? 'إعدادات الإشعارات';
  String get language => loc?.get('language') ?? 'اللغة';
  String get privacyPolicy => loc?.get('privacy_policy') ?? 'سياسة الخصوصية';
  String get helpSupport => loc?.get('help_support') ?? 'المساعدة والدعم';
  String get signOut => loc?.get('sign_out') ?? 'تسجيل الخروج';
  String get arabic => loc?.get('arabic') ?? 'العربية';
  String get english => loc?.get('english') ?? 'English';
  String get french => loc?.get('french') ?? 'Français';
  String get doctorDetails => loc?.get('doctor_details') ?? 'تفاصيل الطبيب';
  String get bookAppointmentTitle =>
      loc?.get('book_appointment_title') ?? 'حجز موعد';
  String get chooseDoctor => loc?.get('choose_doctor') ?? 'اختر الطبيب';
  String get chooseDateTime =>
      loc?.get('choose_date_time') ?? 'اختر التاريخ والوقت';
  String get appointmentConfirmation =>
      loc?.get('appointment_confirmation') ?? 'تأكيد الموعد';
  String get appointmentType => loc?.get('appointment_type') ?? 'نوع الموعد';
  String get videoCall => loc?.get('video_call') ?? 'مكالمة فيديو';
  String get audioCall => loc?.get('audio_call') ?? 'مكالمة صوتية';
  String get clinicVisit => loc?.get('clinic_visit') ?? 'زيارة في العيادة';
  String get appointmentNotes =>
      loc?.get('appointment_notes') ?? 'ملاحظات إضافية (اختياري)';
  String get notesPlaceholder =>
      loc?.get('notes_placeholder') ??
      'اكتب أي ملاحظات تريد إخبار الطبيب بها...';
  String get availableTime => loc?.get('available_time') ?? 'الوقت المتاح';
  String get price => loc?.get('price') ?? 'السعر';
  String get bookNow => loc?.get('book_now') ?? 'احجز الآن';
  String get appointmentBooked =>
      loc?.get('appointment_booked') ?? 'تم الحجز بنجاح!';
  String get appointmentSuccessMessage =>
      loc?.get('appointment_success_message') ?? 'تم حجز موعدك بنجاح';
  String get reschedule => loc?.get('reschedule') ?? 'إعادة جدولة';
  String get cancelAppointment =>
      loc?.get('cancel_appointment') ?? 'إلغاء الموعد';
  String get editAppointment => loc?.get('edit_appointment') ?? 'تعديل الموعد';
  String get allAppointments => loc?.get('all_appointments') ?? 'جميع المواعيد';
  String get upcomingAppointments =>
      loc?.get('upcoming_appointments') ?? 'المواعيد القادمة';
  String get pastAppointments =>
      loc?.get('past_appointments') ?? 'المواعيد السابقة';
  String get noAppointments => loc?.get('no_appointments') ?? 'لا توجد مواعيد';
  String get noUpcomingAppointments =>
      loc?.get('no_upcoming_appointments') ?? 'لا توجد مواعيد قادمة';
  String get noPastAppointments =>
      loc?.get('no_past_appointments') ?? 'لا توجد مواعيد سابقة';
  String get startConversation =>
      loc?.get('start_conversation') ?? 'ابدأ المحادثة';
  String get typeMessage => loc?.get('type_message') ?? 'اكتب رسالتك هنا...';
  String get online => loc?.get('online') ?? 'متصل الآن';
  String get lastSeen => loc?.get('last_seen') ?? 'آخر ظهور';
  String get send => loc?.get('send') ?? 'إرسال';
  String get attachFile => loc?.get('attach_file') ?? 'إرفاق ملف';
  String get noMessages => loc?.get('no_messages') ?? 'لا توجد رسائل';
  String get startChatMessage =>
      loc?.get('start_chat_message') ?? 'ابدأ محادثة مع الطبيب';
  String get cardDetails => loc?.get('card_details') ?? 'تفاصيل البطاقة';
  String get cardNumber => loc?.get('card_number') ?? 'رقم البطاقة';
  String get expiryDate => loc?.get('expiry_date') ?? 'تاريخ الانتهاء';
  String get cvv => loc?.get('cvv') ?? 'رمز الأمان';
  String get cardholderName =>
      loc?.get('cardholder_name') ?? 'اسم صاحب البطاقة';
  String get saveCard => loc?.get('save_card') ?? 'حفظ البطاقة';
  String get paymentMethods => loc?.get('payment_methods') ?? 'طرق الدفع';
  String get addPaymentMethod =>
      loc?.get('add_payment_method') ?? 'إضافة طريقة دفع';
  String get creditCard => loc?.get('credit_card') ?? 'بطاقة ائتمان';
  String get debitCard => loc?.get('debit_card') ?? 'بطاقة خصم';
  String get applePay => loc?.get('apple_pay') ?? 'Apple Pay';
  String get googlePay => loc?.get('google_pay') ?? 'Google Pay';
  String get cashOnDelivery =>
      loc?.get('cash_on_delivery') ?? 'الدفع عند الاستلام';
  String get paymentSuccessful =>
      loc?.get('payment_successful') ?? 'تم الدفع بنجاح';
  String get paymentFailed => loc?.get('payment_failed') ?? 'فشل في الدفع';
  String get enterLocation => loc?.get('enter_location') ?? 'أدخل موقعك';
  String get currentLocation => loc?.get('current_location') ?? 'الموقع الحالي';
  String get nearbyMap => loc?.get('nearby_map') ?? 'الخريطة القريبة';
  String get getLocation => loc?.get('get_location') ?? 'الحصول على الموقع';
  String get locationPermissionRequired =>
      loc?.get('location_permission_required') ?? 'مطلوب إذن الموقع';
  String get locationPermissionMessage =>
      loc?.get('location_permission_message') ??
      'نحتاج إلى إذن الوصول إلى موقعك';
  String get allowLocation => loc?.get('allow_location') ?? 'السماح بالموقع';
  String get denyLocation => loc?.get('deny_location') ?? 'رفض';
  String get reviewDoctor => loc?.get('review_doctor') ?? 'تقييم الطبيب';
  String get writeReview => loc?.get('write_review') ?? 'اكتب تقييماً';
  String get yourRating => loc?.get('your_rating') ?? 'تقييمك';
  String get yourReview => loc?.get('your_review') ?? 'تقييمك';
  String get submitReview => loc?.get('submit_review') ?? 'إرسال التقييم';
  String get reviewPlaceholder =>
      loc?.get('review_placeholder') ?? 'شارك تجربتك مع الطبيب...';
  String get healthTracking => loc?.get('health_tracking') ?? 'تتبع الصحة';
  String get healthMetrics => loc?.get('health_metrics') ?? 'المؤشرات الصحية';
  String get congratulations => loc?.get('congratulations') ?? 'مبروك!';
  String get appointmentConfirmed =>
      loc?.get('appointment_confirmed') ?? 'تم تأكيد موعدك';
}
