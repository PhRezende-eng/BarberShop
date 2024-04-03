import 'package:barber_shop/src/core/exceptions/repository_exception.dart';
import 'package:barber_shop/src/core/fp/either.dart';
import 'package:barber_shop/src/core/rest_client/rest_client.dart';
import 'package:barber_shop/src/models/api_response_model.dart';
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
  Future<Either<RepositoryException, BarbershopModel>> createMyBarbershop(
      ({
        String name,
        String email,
        List<String> weekDays,
        List<int> hours,
      }) barbershopData) async {
    try {
      final Response(data: Map<String, dynamic> apiResponse) =
          await restClient.auth.post(
        '/barbershop',
        //TODO: remove below line
        queryParameters: {'barbershop_id': '5'},
        //
        data: {
          'name': barbershopData.name,
          'email': barbershopData.email,
          'opening_days': barbershopData.weekDays,
          'opening_hours': barbershopData.hours,
        },
      );

      final response = ApiResponseModel.fromJson(apiResponse);

      if (response.statusMessage == 'Success') {
        //TODO: remove below clause
        final barbershopModel = BarbershopModel.fromJson(
            (response.data as List).first as Map<String, dynamic>);
        return Success(barbershopModel);

        // final barbershopModel =
        //     BarbershopModel.fromJson(response.data as Map<String, dynamic>);
        // return Success(barbershopModel);
      } else {
        final apiMessage = response.data as String?;
        return Failure(
          RepositoryException(message: apiMessage ?? "Error ao realizar login"),
        );
      }
    } on ArgumentError catch (e) {
      return Failure(RepositoryException(message: e.message));
    } on DioException catch (e) {
      if (e.response != null) {
        final Response(data: Map<String, dynamic> apiResponse) = e.response!;
        final response = ApiResponseModel.fromJson(apiResponse);

        final apiMessage = response.data as String?;
        return Failure(
          RepositoryException(message: apiMessage ?? "Erro ao buscar usuário"),
        );
      }
      return Failure(
          RepositoryException(message: e.message ?? 'Erro ao buscar loja'));
    } catch (e) {
      return Failure(RepositoryException(message: e.toString()));
    }
  }

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
          final barbershopModel = BarbershopModel.fromJson(data["data"]);

          if (data['status_message'] == 'Success') {
            return Success(barbershopModel);
          } else {
            final apiMessage = data["data"];
            return Failure(
              RepositoryException(
                  message: apiMessage ?? "Error ao realizar login"),
            );
          }
        case UserModelEmployee():
          final Response(:data) =
              await restClient.auth.get('/barbershop', queryParameters: {
            'barbershop_id': userModel.barbershopId,
          });

          if (data["status_message"] == "Success") {
            final barbershopModel = BarbershopModel.fromJson(data["data"]);
            return Success(barbershopModel);
          } else {
            final apiMessage = data["data"];
            return Failure(RepositoryException(message: apiMessage));
          }
      }
    } on ArgumentError catch (e) {
      return Failure(RepositoryException(message: e.message));
    } on DioException catch (e) {
      if (e.response != null) {
        final Response(:data) = e.response!;
        final apiMessage = data["data"];
        return Failure(
          RepositoryException(message: apiMessage ?? "Erro ao buscar usuário"),
        );
      }
      return Failure(
          RepositoryException(message: e.message ?? 'Erro ao buscar loja'));
    } catch (e) {
      return Failure(RepositoryException(message: e.toString()));
    }
  }
}
