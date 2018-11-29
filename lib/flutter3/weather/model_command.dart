import 'package:rx_command/rx_command.dart';
import 'weather_model.dart';
import 'weather_repo.dart';

class ModelCommand {
  factory ModelCommand(WeatherRepo repo) {
    final _getGpsCommand = RxCommand.createAsyncNoParam<bool>(repo.getGps);

    final _radioCheckedCommand = RxCommand.createSync<bool, bool>((b) => b);

    final _updateLocationCommand =
        RxCommand.createAsyncNoParam<Map<String, dynamic>>(repo.updateLocation);

    final _updateWeatherCommand =
        RxCommand.createAsync<Map<String, dynamic>, List<WeatherModel>>(repo.updateWeather);

    _updateLocationCommand.results.listen((data) => _updateWeatherCommand(data.data));

    final _addCitiesCommand = RxCommand.createSyncNoResult<int>(repo.addCities);

    _updateWeatherCommand(null);

    return ModelCommand._(
      repo,
      _updateLocationCommand,
      _updateWeatherCommand,
      _getGpsCommand,
      _addCitiesCommand,
      _radioCheckedCommand,
    );
  }

  ModelCommand._(
    this.weatherRepo,
    this.updateLocationCommand,
    this.updateWeatherCommand,
    this.getGpsCommand,
    this.addCitiesCommand,
    this.radioCheckedCommand,
  );

  final RxCommand<void, bool> getGpsCommand;
  final RxCommand<bool, bool> radioCheckedCommand;
  final RxCommand<void, Map<String, dynamic>> updateLocationCommand;
  final RxCommand<Map<String, dynamic>, List<WeatherModel>> updateWeatherCommand;
  final RxCommand<int, void> addCitiesCommand;
  final WeatherRepo weatherRepo;
}
