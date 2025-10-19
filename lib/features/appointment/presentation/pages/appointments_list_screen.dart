import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/config/dependency_injection.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/features/appointment/domain/usecases/get_appointments_usecase.dart';
import 'package:neurocare_app/features/appointment/domain/usecases/get_upcoming_appointments_usecase.dart';
import 'package:neurocare_app/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:neurocare_app/features/appointment/presentation/bloc/appointment_event.dart';
import 'package:neurocare_app/features/appointment/presentation/bloc/appointment_state.dart';
import 'package:neurocare_app/features/appointment/presentation/widgets/appointment_card.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class AppointmentsListScreen extends StatefulWidget {
  const AppointmentsListScreen({super.key});

  @override
  State<AppointmentsListScreen> createState() => _AppointmentsListScreenState();
}

class _AppointmentsListScreenState extends State<AppointmentsListScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _loadAppointmentsForTab(_tabController.index);
      }
    });
    _loadAppointmentsForTab(0); // Load all appointments initially
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadAppointmentsForTab(int tabIndex) {
    switch (tabIndex) {
      case 0: // All
        context.read<AppointmentBloc>().add(const LoadAppointments());
        break;
      case 1: // Upcoming
        context.read<AppointmentBloc>().add(const LoadUpcomingAppointments());
        break;
      case 2: // Past
        // For now, we'll load all and filter in UI, but ideally we'd have a separate use case
        context.read<AppointmentBloc>().add(const LoadAppointments());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentBloc(
        getAppointments: GetAppointmentsUseCase(getIt()),
        getUpcomingAppointments: GetUpcomingAppointmentsUseCase(getIt()),
        bookAppointment: getIt(),
        getAvailableTimeSlots: getIt(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.onboardingBackground,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'المواعيد',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset(
              AppAssets.arrowIcon,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => context.pop(),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'الكل'),
              Tab(text: 'القادمة'),
              Tab(text: 'السابقة'),
            ],
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.homeSecondaryText,
            indicatorColor: AppColors.primary,
            labelStyle: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildAppointmentsList(),
            _buildUpcomingAppointmentsList(),
            _buildPastAppointmentsList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(RouteNames.bookAppointment),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        bottomNavigationBar:
            const BottomNavBar(currentIndex: 1), // Appointments tab
      ),
    );
  }

  Widget _buildAppointmentsList() {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AppointmentsLoaded) {
          if (state.appointments.isEmpty) {
            return _buildEmptyState('لا توجد مواعيد');
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.appointments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppointmentCard(
                  appointment: state.appointments[index],
                  onTap: () => context.push(
                    RouteNames.appointmentDetails,
                    extra: state.appointments[index],
                  ),
                ),
              );
            },
          );
        }

        if (state is AppointmentError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.error,
                ),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.homeSecondaryText,
                      ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      _loadAppointmentsForTab(_tabController.index),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildUpcomingAppointmentsList() {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AppointmentsLoaded) {
          final upcomingAppointments = state.appointments
              .where((appointment) => appointment.isUpcoming)
              .toList();

          if (upcomingAppointments.isEmpty) {
            return _buildEmptyState('لا توجد مواعيد قادمة');
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: upcomingAppointments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppointmentCard(
                  appointment: upcomingAppointments[index],
                  onTap: () => context.push(
                    RouteNames.appointmentDetails,
                    extra: upcomingAppointments[index],
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPastAppointmentsList() {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AppointmentsLoaded) {
          final pastAppointments = state.appointments
              .where((appointment) => !appointment.isUpcoming)
              .toList();

          if (pastAppointments.isEmpty) {
            return _buildEmptyState('لا توجد مواعيد سابقة');
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: pastAppointments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppointmentCard(
                  appointment: pastAppointments[index],
                  onTap: () => context.push(
                    RouteNames.appointmentDetails,
                    extra: pastAppointments[index],
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: 64,
            color: AppColors.homeSecondaryText.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.homeSecondaryText,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'يمكنك حجز موعد جديد من خلال الزر أدناه',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.homeSecondaryText.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }
}
