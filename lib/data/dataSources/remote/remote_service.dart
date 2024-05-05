import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/data/dataSources/remote/responses/current_weather_response.dart';

part 'remote_service.g.dart';


typedef FutureResponse<T> = Future<HttpResponse<T>>;


@RestApi()
abstract class RemoteService {

  factory RemoteService(Dio dio) = _RemoteService;

  @GET('current.json')
  FutureResponse<CurrentWeatherResponse> getCurrentWeather(@Query('q') String locationName,
      {@Query('key') String key = 'bc619f0b16ba41f4aa873533242904'});
}
