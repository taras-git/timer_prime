import 'package:timer_prime/data/api_client.dart';
import 'package:timer_prime/model/random_number_model.dart';

class ApiProvider {
  final client = DioClient();

  Future<RandomNumberModel?> fetchRandomNumber() async {
    try {
      final response = await client.dio.get("api/v1.0/random");
      final int randomNumber = (response.data as List)[0];

      return RandomNumberModel(randomNumber: randomNumber);
    } catch (e) {
      return RandomNumberModel(
        errorMessage: e.toString(),
      );
    }
  }
}
