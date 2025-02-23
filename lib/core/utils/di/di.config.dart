// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../data/data_sources/auth_dataSource_impl.dart' as _i349;
import '../../../data/data_sources/home_dataSource_impl.dart' as _i5;
import '../../../data/data_sources/product_dataSource_impl.dart' as _i508;
import '../../../data/Repository/auth_repository_impl.dart' as _i312;
import '../../../data/Repository/home_repository_impl.dart' as _i606;
import '../../../data/Repository/product_repository_impl.dart' as _i403;
import '../../../domain/Repository/auth/auth_remote_dataSource.dart' as _i693;
import '../../../domain/Repository/auth/auth_repository.dart' as _i441;
import '../../../domain/Repository/home/home_dataSource.dart' as _i917;
import '../../../domain/Repository/home/home_repository.dart' as _i1033;
import '../../../domain/Repository/product/product_dataSource.dart' as _i365;
import '../../../domain/Repository/product/product_repository.dart' as _i725;
import '../../../domain/usecases/auth_use_case.dart' as _i90;
import '../../../domain/usecases/get_brands_useCase.dart' as _i435;
import '../../../domain/usecases/get_category_useCase.dart' as _i630;
import '../../../domain/usecases/get_product_useCase.dart' as _i753;
import '../../../feature/auth/login/cubit/login_view_model.dart' as _i327;
import '../../../feature/auth/register/cubit/register_view_model.dart' as _i726;
import '../../../feature/home/tabs/home_tab/cubit/home_tab_viewModel.dart'
    as _i386;
import '../../../feature/home/tabs/product_tab.dart/cubit/product_tab_viewModel.dart'
    as _i849;
import '../apis/api_manager.dart' as _i669;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i669.ApiManager>(() => _i669.ApiManager());
    gh.factory<_i917.HomeDatasource>(
        () => _i5.HomeDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i365.ProductDatasource>(
        () => _i508.ProductDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i693.AuthRemoteDatasource>(
        () => _i349.AuthDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i1033.HomeRepository>(() =>
        _i606.HomeRepositoryImpl(homeDatasource: gh<_i917.HomeDatasource>()));
    gh.factory<_i441.AuthRepository>(() => _i312.AuthRepositoryImpl(
        authRemoteDatasource: gh<_i693.AuthRemoteDatasource>()));
    gh.factory<_i725.ProductRepository>(() => _i403.ProductRepositoryImpl(
        productDatasource: gh<_i365.ProductDatasource>()));
    gh.factory<_i753.GetProductUsecase>(() => _i753.GetProductUsecase(
        productRepository: gh<_i725.ProductRepository>()));
    gh.factory<_i90.RegisterUseCase>(
        () => _i90.RegisterUseCase(authRepository: gh<_i441.AuthRepository>()));
    gh.factory<_i90.LoginUseCase>(
        () => _i90.LoginUseCase(authRepository: gh<_i441.AuthRepository>()));
    gh.factory<_i630.GetCategoryUsecase>(() =>
        _i630.GetCategoryUsecase(homeRepository: gh<_i1033.HomeRepository>()));
    gh.factory<_i435.GetBrandsUsecase>(() =>
        _i435.GetBrandsUsecase(homeRepository: gh<_i1033.HomeRepository>()));
    gh.factory<_i327.LoginViewModel>(
        () => _i327.LoginViewModel(loginUseCase: gh<_i90.LoginUseCase>()));
    gh.factory<_i386.HomeTabViewmodel>(() => _i386.HomeTabViewmodel(
          categoryUsecase: gh<_i630.GetCategoryUsecase>(),
          brandsUsecase: gh<_i435.GetBrandsUsecase>(),
        ));
    gh.factory<_i726.RegisterViewModel>(() =>
        _i726.RegisterViewModel(registerUseCase: gh<_i90.RegisterUseCase>()));
    gh.factory<_i849.ProductTabViewmodel>(() => _i849.ProductTabViewmodel(
        getProductUsecase: gh<_i753.GetProductUsecase>()));
    return this;
  }
}
