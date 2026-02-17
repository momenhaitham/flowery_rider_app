import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_rider_app/app/config/local_storage_processes/domain/use_case/get_token_use_case.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/app_tab.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/home_events.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/home_states.dart';
import 'package:flowery_rider_app/app/feature/home/presentation/view_model/home_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'home_view_model_test.mocks.dart';

@GenerateMocks([GetTokenUseCase])
void main() {
  late MockGetTokenUseCase mockGetTokenUseCase;
  late HomeViewModel homeViewModel;
  setUp(() {
    mockGetTokenUseCase=MockGetTokenUseCase();
    homeViewModel=HomeViewModel(mockGetTokenUseCase);
  },);
  group('test cases of home view model', () {
    test('checking that initial state is home tab)',(){
      expect(homeViewModel.state.currAppTab, AppTab.home);
      expect(homeViewModel.state.currAppTab.index, isZero);
    });
    test('checking switching to any tab', () {
      homeViewModel.doIntent(ChangeCurrentTabEvent(AppTab.profile));
      expect(homeViewModel.state.currAppTab, AppTab.profile);
      expect(homeViewModel.state.currAppTab.index, equals(2));
    },);
    test('checking switching between multiple tabs', () {
      homeViewModel.doIntent(ChangeCurrentTabEvent(AppTab.orders));
      expect(homeViewModel.state.currAppTab, AppTab.orders);
      expect(homeViewModel.state.currAppTab.index, equals(1));
      homeViewModel.doIntent(ChangeCurrentTabEvent(AppTab.profile));
      expect(homeViewModel.state.currAppTab, AppTab.profile);
      expect(homeViewModel.state.currAppTab.index, equals(2));
    },);
    test('checking that pressing the same tab twice is handled properly', () {
      homeViewModel.doIntent(ChangeCurrentTabEvent(AppTab.orders));
      homeViewModel.doIntent(ChangeCurrentTabEvent(AppTab.orders));
      expect(homeViewModel.state.currAppTab, AppTab.orders);
      expect(homeViewModel.state.currAppTab.index, equals(1));
    },);
  },);
  blocTest(
    'when calling do intent with get token action it must emit correct state',
    setUp: () {
      provideDummy<String?>('token');
      when(mockGetTokenUseCase.invoke()).thenAnswer((realInvocation) =>
          Future.value('token'));
    },
    build: () => homeViewModel,
    act: (bloc) => bloc.doIntent(GetTokenEvent()),
    expect: () {
      var state = HomeStates(isLoggedIn: false, currAppTab: AppTab.home);
      return [
        state.copyWith(isLoggedIn: true),
      ];
    },);
    blocTest(
    'when calling do intent with get token action and token is null it must emit correct state',
    setUp: () {
      provideDummy<String?>(null);
      when(mockGetTokenUseCase.invoke()).thenAnswer((realInvocation) =>
          Future.value(null));
    },
    build: () => homeViewModel,
    act: (bloc) => bloc.doIntent(GetTokenEvent()),
    expect: () {
      var state = HomeStates(isLoggedIn: false, currAppTab: AppTab.home);
      return [
        state.copyWith(isLoggedIn: false),
      ];
    },);
}