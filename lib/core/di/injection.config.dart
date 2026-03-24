// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:client/data/remote/services/auth_service.dart' as _i787;
import 'package:client/data/remote/services/user_service.dart' as _i906;
import 'package:client/data/repositories/auth_repository.dart' as _i11;
import 'package:client/data/repositories/user_repository.dart' as _i181;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i787.AuthService>(() => _i787.AuthService());
    gh.factory<_i906.UserService>(() => _i906.UserService());
    gh.factory<_i181.UserRepository>(
      () => _i181.UserRepositoryImpl(userService: gh<_i906.UserService>()),
    );
    gh.factory<_i11.AuthRepository>(
      () => _i11.AuthRepositoryImpl(authService: gh<_i787.AuthService>()),
    );
    return this;
  }
}
