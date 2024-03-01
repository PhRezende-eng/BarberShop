import 'package:barber_shop/src/core/exceptions/repository_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/core/rest_client/rest_client.dart';
import 'package:barber_shop/src/models/barbershop_model.dart';
import 'package:barber_shop/src/models/user_model.dart';
import 'package:barber_shop/src/repositories/barbershop/barbershop_repositoy.dart';
import 'package:dio/dio.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;
  BarbershopRepositoryImpl({
    required this.restClient,
  });
  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel) async {
    try {
      switch (userModel) {
        case UserModelADM():
          final Response(data: List(first: data)) =
              await restClient.auth.get('/barbershop', queryParameters: {
            'user_id': userModel.id,
          });
          final barbershopModel = BarbershopModel.fromJson(data);
          return Success(barbershopModel);
        case UserModelEmployee():
          final Response(:data) =
              await restClient.auth.get('/barbershop', queryParameters: {
            'barbershop_id': userModel.barbershopId,
          });
          final barbershopModel = BarbershopModel.fromJson(data);
          return Success(barbershopModel);
      }
    } on ArgumentError catch (e) {
      return Failure(RepositoryException(message: e.message));
    } on DioException catch (e) {
      return Failure(RepositoryException(
          message: e.response?.data ?? 'Erro ao buscar loja'));
    }
  }
}
