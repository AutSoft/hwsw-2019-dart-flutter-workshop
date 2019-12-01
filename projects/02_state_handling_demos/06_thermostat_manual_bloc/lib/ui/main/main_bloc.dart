import 'dart:async';

import 'main_page_events.dart';

enum ActionInProgress { IDLE, COOLING, WARMING }

const int MAX_TEMP = 30;
const int MIN_TEMP = 16;

class MainBloc {
  var _currentTemperature = 22;
  var _targetTemperature = 22;
  var _actionInProgress = ActionInProgress.IDLE;

  Timer _worldTimer;

  //region Event controller
  StreamController<MainPageEvent> _eventController;

  Sink<MainPageEvent> get eventSink => _eventController.sink;

  StreamSubscription<MainPageEvent> _eventSubscription;

  //endregion

  //region Current temperature controller
  StreamController<int> _currentTempController;

  Sink<int> get _currentTemperatureSink => _currentTempController.sink;

  Stream<int> get currentTemperature => _currentTempController.stream;

  //endregion

  //region Target temperature controller
  StreamController<int> _targetTempController;

  Sink<int> get _targetTemperatureSink => _targetTempController.sink;

  Stream<int> get targetTemperature => _targetTempController.stream;

  //endregion

  //region Action in progress controller
  StreamController<ActionInProgress> _actionController;

  Sink<ActionInProgress> get _actionInProgressSink => _actionController.sink;

  Stream<ActionInProgress> get actionInProgress => _actionController.stream;

  //endregion

  MainBloc() {
    _eventController = StreamController<MainPageEvent>();
    _currentTempController = StreamController<int>();
    _targetTempController = StreamController<int>();
    _actionController = StreamController<ActionInProgress>();

    _eventSubscription = _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(MainPageEvent event) {
    switch (event.runtimeType) {
      case ColderEvent:
        if (_targetTemperature > MIN_TEMP) {
          _targetTemperature -= 1;
          _targetTemperatureSink.add(_targetTemperature);
          _startWorldTimer();
        }
        break;
      case WarmerEvent:
        if (_targetTemperature < MAX_TEMP) {
          _targetTemperature += 1;
          _targetTemperatureSink.add(_targetTemperature);
          _startWorldTimer();
        }
        break;
    }
  }

  void _cancelWorldTimer() {
    if (_worldTimer != null) {
      _worldTimer.cancel();
      _worldTimer = null;
    }
  }

  void _startWorldTimer() {
    if (_worldTimer == null) {
      _worldTimer =
          Timer.periodic(Duration(seconds: 1), _handleWorldTimerEvent);
    }
  }

  void _handleWorldTimerEvent(Timer timer) {
    if (_currentTemperature > _targetTemperature) {
      _currentTemperature -= 1;
      _actionInProgress = ActionInProgress.COOLING;
      _currentTemperatureSink.add(_currentTemperature);
      _actionInProgressSink.add(_actionInProgress);
    } else if (_currentTemperature < _targetTemperature) {
      _currentTemperature += 1;
      _actionInProgress = ActionInProgress.WARMING;
      _currentTemperatureSink.add(_currentTemperature);
      _actionInProgressSink.add(_actionInProgress);
    } else {
      timer.cancel();
      _worldTimer = null;
      _actionInProgress = ActionInProgress.IDLE;
      _actionInProgressSink.add(_actionInProgress);
    }
  }

  void dispose() {
    _cancelWorldTimer();
    _eventController.close();
    _eventSubscription.cancel();
    _currentTempController.close();
    _targetTempController.close();
    _actionController.close();
  }
}
