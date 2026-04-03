import 'dart:async';

/// A utility class that provides debouncing functionality for async operations.
///
/// Debouncing ensures that a function is only executed after a specified delay
/// has passed since the last invocation. This is useful for reducing excessive
/// disk writes by batching rapid updates.
class Debouncer {
  final Duration delay;
  Timer? _timer;
  Future<void> Function()? _pendingAction;
  Completer<void>? _completer;

  /// Creates a debouncer with the specified delay.
  ///
  /// [delay] - The debounce delay duration (recommended: 300-500ms for disk writes)
  Debouncer({required this.delay});

  /// Schedules an action to be executed after the debounce delay.
  ///
  /// If this method is called again before the delay expires, the previous
  /// action is cancelled and the new action is scheduled.
  ///
  /// [action] - The async function to execute after the delay
  /// Returns a Future that completes when the action is executed
  Future<void> run(Future<void> Function() action) {
    // Cancel any existing timer
    _timer?.cancel();

    // Complete any pending completer to avoid hanging futures
    _completer?.complete();

    // Create a new completer for this action
    _completer = Completer<void>();

    // Store the pending action
    _pendingAction = action;

    // Schedule the action after the delay
    _timer = Timer(delay, () async {
      if (_pendingAction != null) {
        try {
          await _pendingAction!();
          _completer?.complete();
        } catch (e) {
          _completer?.completeError(e);
        }
        _pendingAction = null;
      }
    });

    return _completer!.future;
  }

  /// Immediately executes any pending action without waiting for the delay.
  ///
  /// This is useful for ensuring data is saved before the app is closed
  /// or when immediate persistence is required.
  Future<void> flush() async {
    _timer?.cancel();
    _timer = null;

    if (_pendingAction != null) {
      try {
        await _pendingAction!();
        _completer?.complete();
      } catch (e) {
        _completer?.completeError(e);
      }
      _pendingAction = null;
    }
  }

  /// Cancels any pending action without executing it.
  void cancel() {
    _timer?.cancel();
    _timer = null;
    _pendingAction = null;
    _completer?.complete();
    _completer = null;
  }

  /// Returns true if there is a pending action waiting to be executed.
  bool get hasPendingAction => _pendingAction != null;

  /// Disposes the debouncer, cancelling any pending actions.
  void dispose() {
    cancel();
  }
}

/// A specialized debouncer for key-value save operations.
///
/// This debouncer batches multiple save operations for the same key,
/// ensuring only the final value is persisted.
class SaveDebouncer {
  final Duration delay;
  final Map<String, Debouncer> _debouncers = {};
  final Map<String, Future<void> Function()> _pendingSaves = {};

  /// Creates a save debouncer with the specified delay.
  ///
  /// [delay] - The debounce delay duration (recommended: 300-500ms)
  SaveDebouncer({required this.delay});

  /// Schedules a save operation for the given key.
  ///
  /// If multiple saves are requested for the same key before the delay expires,
  /// only the last save operation will be executed.
  ///
  /// [key] - A unique identifier for this save operation
  /// [saveAction] - The async function that performs the save
  Future<void> save(String key, Future<void> Function() saveAction) {
    // Store the latest save action for this key
    _pendingSaves[key] = saveAction;

    // Get or create a debouncer for this key
    _debouncers[key] ??= Debouncer(delay: delay);

    // Schedule the save with the debouncer
    return _debouncers[key]!.run(() async {
      final action = _pendingSaves[key];
      if (action != null) {
        await action();
        _pendingSaves.remove(key);
      }
    });
  }

  /// Immediately executes any pending save for the given key.
  ///
  /// [key] - The key to flush
  Future<void> flush(String key) async {
    final debouncer = _debouncers[key];
    if (debouncer != null) {
      await debouncer.flush();
    }
  }

  /// Immediately executes all pending saves.
  Future<void> flushAll() async {
    for (final debouncer in _debouncers.values) {
      await debouncer.flush();
    }
  }

  /// Cancels any pending save for the given key.
  void cancel(String key) {
    _debouncers[key]?.cancel();
    _pendingSaves.remove(key);
  }

  /// Cancels all pending saves.
  void cancelAll() {
    for (final debouncer in _debouncers.values) {
      debouncer.cancel();
    }
    _pendingSaves.clear();
  }

  /// Disposes all debouncers.
  void dispose() {
    for (final debouncer in _debouncers.values) {
      debouncer.dispose();
    }
    _debouncers.clear();
    _pendingSaves.clear();
  }
}
