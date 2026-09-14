import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:web/web.dart' as webLib;

// ─── DTOs ────────────────────────────────────────────────────────────────────

class BoxInfoDto {
  int lineNumber;
  int minorBeats;
  BoxInfoDto({required this.lineNumber, required this.minorBeats});
}

class PracticeTimingDto {
  int bpm;
  List<BoxInfoDto> boxes;
  PracticeTimingDto({required this.bpm, required this.boxes});
}

class PracticeTimingService {
  PracticeTimingDto getOutputDto() => PracticeTimingDto(
    bpm: 60,
    boxes: List.generate(12, (i) => BoxInfoDto(lineNumber: i + 1, minorBeats: 4)),
  );
}

// ─── PUBLIC shared widgets ────────────────────────────────────────────────────

Widget practiceHeader(String title) => Container(
  width: double.infinity,
  padding: const EdgeInsets.symmetric(vertical: 18),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text(
    title,
    textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
  ),
);

Widget practiceBpmBadge(int bpm) => Container(
  width: 100,
  height: 50,
  decoration: BoxDecoration(
    border: Border.all(color: Colors.black, width: 2),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Center(
    child: Text("BPM: $bpm", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  ),
);

Widget practiceAdjBtn(String label, Color color, VoidCallback onTap) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ),
      ),
    );

Widget practiceBox({
  required BoxInfoDto box,
  required VoidCallback onDecrement,
  required VoidCallback onIncrement,
  bool leftHighlight = false,
  bool rightHighlight = false,
  VoidCallback? onTapLeft,
  VoidCallback? onTapRight,
  Widget? overlayBadge,
}) {
  Widget cell = Container(
    height: 50,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 1.5),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTapLeft,
            child: Container(
              decoration: BoxDecoration(
                color: leftHighlight ? Colors.orange.withOpacity(0.2) : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6), bottomLeft: Radius.circular(6),
                ),
              ),
              child: Center(
                child: Text("${box.lineNumber}",
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        Container(width: 1.5, height: double.infinity, color: Colors.black),
        Expanded(
          child: GestureDetector(
            onTap: onTapRight,
            child: Container(
              decoration: BoxDecoration(
                color: rightHighlight ? Colors.orange.withOpacity(0.2) : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6), bottomRight: Radius.circular(6),
                ),
              ),
              child: Center(
                child: Text("${box.minorBeats}",
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget topPart = overlayBadge != null
      ? Stack(
    clipBehavior: Clip.none,
    children: [
      cell,
      Positioned(top: -7, right: -7, child: overlayBadge),
    ],
  )
      : cell;

  return Container(
    width: 80,
    margin: const EdgeInsets.all(4),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        topPart,
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            practiceAdjBtn("-", Colors.red, onDecrement),
            const SizedBox(width: 4),
            practiceAdjBtn("+", Colors.green, onIncrement),
          ],
        ),
      ],
    ),
  );
}

// ─── PracticeTiming ───────────────────────────────────────────────────────────

class PracticeTiming extends StatelessWidget {
  const PracticeTiming({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PracticePage(),
  );
}

// ─── PracticePage (Screen 1) ──────────────────────────────────────────────────

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});
  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final _service = PracticeTimingService();
  late PracticeTimingDto dto;

  @override
  void initState() {
    super.initState();
    dto = _service.getOutputDto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              practiceHeader("Practice Timing"),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: practiceBpmBadge(dto.bpm),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int r = 0; r < 3; r++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int c = 0; c < 4; c++)
                              practiceBox(
                                box: dto.boxes[r * 4 + c],
                                onDecrement: () => setState(() {
                                  if (dto.boxes[r * 4 + c].minorBeats > 0)
                                    dto.boxes[r * 4 + c].minorBeats--;
                                }),
                                onIncrement: () => setState(() {
                                  dto.boxes[r * 4 + c].minorBeats++;
                                }),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BeatPlayPage(dto: dto)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14),
                    child: Text("NEXT", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Beat event ───────────────────────────────────────────────────────────────

class _BeatEvent {
  final int col, row, beatIndex;
  final double audioTime, clipDuration;
  final bool isFirstTing, useSpecial;
  const _BeatEvent({
    required this.col, required this.row, required this.audioTime,
    required this.clipDuration, required this.isFirstTing,
    required this.useSpecial, required this.beatIndex,
  });
}

// ─── BeatPlayPage (Screen 2) ──────────────────────────────────────────────────
// Supports UNLIMITED boxes + SMOOTH AUTO-SCROLL (NO LAG)

class BeatPlayPage extends StatefulWidget {
  final PracticeTimingDto dto;
  const BeatPlayPage({super.key, required this.dto});
  @override
  State<BeatPlayPage> createState() => _BeatPlayPageState();
}

class _BeatPlayPageState extends State<BeatPlayPage> with TickerProviderStateMixin {
  int _activeCol = -1, _activeRow = -1, _activeBeat = -1;
  bool _isPlaying = false, _isLoading = false;
  List<int>? _masterBytes, _specialBytes;
  webLib.AudioContext? _ctx;
  webLib.AudioBuffer? _buf, _specialBuf;
  double _clipDur = 0.18, _specialClipDur = 0.18;
  int _sid = 0;
  Ticker? _ticker;
  final List<_BeatEvent> _ev = [];
  int _sCur = 0, _vCur = 0;
  double _nextLoop = 0.0;
  bool _pruning = false;

  // Scroll controller and timer for smooth auto-scroll
  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;

  static const double _ahead = 1.2, _maxClickSec = 0.055,
      _startDelaySec = 0.08, _normalAudioOffsetSec = 0.025,
      _specialAudioOffsetSec = 0.025;

  double get _beatSec => 60.0 / widget.dto.bpm;

  @override
  void initState() {
    super.initState();
    _loadBytes();
  }

  // Smooth auto-scroll with debounce to prevent lag
  void _autoScrollToCurrentBox() {
    if (!_isPlaying || _activeCol < 0) return;

    // Cancel previous timer to avoid multiple scrolls
    _scrollTimer?.cancel();

    // Short delay to batch multiple beat updates
    _scrollTimer = Timer(const Duration(milliseconds: 80), () {
      if (!mounted || !_isPlaying) return;

      // Calculate which row (4 boxes per row)
      final int row = _activeCol ~/ 4;
      // Each row height approx 180 pixels (box + margin)
      final double scrollOffset = row * 180.0;

      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          scrollOffset,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _loadBytes() async {
    try {
      final data = await rootBundle.load('assets/audio/noutcut.mp3');
      _masterBytes = data.buffer.asUint8List().toList();
      final sd = await rootBundle.load('assets/audio/beim.mp3');
      _specialBytes = sd.buffer.asUint8List().toList();
    } catch (e) { debugPrint('_loadBytes error: $e'); }
  }

  Future<bool> _ensureContext() async {
    if (_ctx != null && _buf != null && _specialBuf != null) {
      if (_ctx!.state == 'suspended') await _ctx!.resume().toDart;
      return true;
    }
    if (_masterBytes == null || _specialBytes == null) return false;
    try {
      if (_ctx != null) { try { await _ctx!.close().toDart; } catch (_) {} _ctx = null; _buf = null; _specialBuf = null; }
      _ctx = webLib.AudioContext();
      if (_ctx!.state == 'suspended') await _ctx!.resume().toDart;
      final fresh = Uint8List.fromList(_masterBytes!);
      _buf = await _ctx!.decodeAudioData(fresh.buffer.toJS).toDart;
      _clipDur = _buf!.duration;
      final fs = Uint8List.fromList(_specialBytes!);
      _specialBuf = await _ctx!.decodeAudioData(fs.buffer.toJS).toDart;
      _specialClipDur = _specialBuf!.duration;
      return true;
    } catch (e) {
      debugPrint('_ensureContext error: $e');
      _buf = null; _specialBuf = null;
      if (_ctx != null) { try { await _ctx!.close().toDart; } catch (_) {} _ctx = null; }
      return false;
    }
  }

  void _fire(double when, double duration, {bool useSpecial = false}) {
    if (_ctx == null || _buf == null) return;
    final buffer = useSpecial ? _specialBuf : _buf;
    if (buffer == null) return;
    try {
      final src = _ctx!.createBufferSource();
      src.buffer = buffer;
      src.connect(_ctx!.destination);
      final t = when < _ctx!.currentTime ? _ctx!.currentTime : when;
      final offset = useSpecial ? _specialAudioOffsetSec : _normalAudioOffsetSec;
      final safeOffset = offset < buffer.duration ? offset : 0.0;
      final remaining = buffer.duration - safeOffset;
      final safeDuration = duration < remaining ? duration : remaining;
      src.start(t, safeOffset, safeDuration);
    } catch (e) { debugPrint('_fire error: $e'); }
  }

  double _appendLoop(double t) {
    for (int col = 0; col < widget.dto.boxes.length; col++) {
      final n = widget.dto.boxes[col].lineNumber;
      final reps = widget.dto.boxes[col].minorBeats;
      for (int row = 0; row < reps; row++) {
        final patternStart = t;
        final intervalSec = _beatSec / n;
        final hitDuration = _maxClickSec < intervalSec * 0.7 ? _maxClickSec : intervalSec * 0.7;
        for (int i = 0; i < n; i++) {
          final useSpecial = i == 0;
          _ev.add(_BeatEvent(col: col, row: row, audioTime: patternStart + intervalSec * i,
              clipDuration: useSpecial ? _specialClipDur : hitDuration,
              isFirstTing: i == 0, useSpecial: useSpecial, beatIndex: i));
        }
        t = patternStart + _beatSec;
      }
    }
    return t;
  }

  void _scheduleUntil(double horizon) {
    while (_sCur < _ev.length && _ev[_sCur].audioTime < horizon) {
      _fire(_ev[_sCur].audioTime, _ev[_sCur].clipDuration, useSpecial: _ev[_sCur].useSpecial);
      _sCur++;
    }
  }

  void _onTick(Duration _) {
    if (!_isPlaying || _ctx == null) return;
    final now = _ctx!.currentTime;
    final horizon = now + _ahead;
    while (_ev.isEmpty || _ev.last.audioTime < horizon + _beatSec * 4) _nextLoop = _appendLoop(_nextLoop);
    _scheduleUntil(horizon);
    bool dirty = false;
    while (_vCur < _ev.length && _ev[_vCur].audioTime <= now) {
      _activeCol = _ev[_vCur].col;
      _activeRow = _ev[_vCur].row;
      _activeBeat = _ev[_vCur].beatIndex;
      dirty = true;
      _vCur++;

      // Smooth auto-scroll when box changes
      _autoScrollToCurrentBox();
    }
    if (dirty) setState(() {});
    if (_pruning) return;
    _pruning = true;
    const keep = 2.0;
    final safeCut = _sCur < _vCur ? _sCur : _vCur;
    if (safeCut > 64 && _ev.isNotEmpty && _ev[safeCut - 1].audioTime < now - keep) {
      int drop = 0;
      while (drop < safeCut && _ev[drop].audioTime < now - keep) drop++;
      if (drop > 0) {
        _ev.removeRange(0, drop); _sCur -= drop; _vCur -= drop;
        if (_sCur < 0) _sCur = 0; if (_vCur < 0) _vCur = 0;
      }
    }
    _pruning = false;
  }

  Future<void> _play() async {
    if (_isPlaying || _isLoading) return;
    setState(() => _isLoading = true);
    _sid++; final mySid = _sid;
    _stopTicker(); _ev.clear(); _sCur = 0; _vCur = 0;
    final ok = await _ensureContext();
    if (!mounted || _sid != mySid) { if (mounted) setState(() => _isLoading = false); return; }
    if (!ok) { setState(() => _isLoading = false); return; }
    _nextLoop = _ctx!.currentTime + _startDelaySec;
    _nextLoop = _appendLoop(_nextLoop); _nextLoop = _appendLoop(_nextLoop);
    _scheduleUntil(_ctx!.currentTime + _ahead);
    _ticker = createTicker(_onTick)..start();
    setState(() { _isPlaying = true; _isLoading = false; _activeCol = -1; _activeRow = -1; _activeBeat = -1; });
  }

  void _stop() {
    _sid++; _stopTicker();
    if (_ctx != null) { _ctx!.close(); _ctx = null; _buf = null; _specialBuf = null; }
    _ev.clear(); _sCur = 0; _vCur = 0;
    setState(() { _isPlaying = false; _isLoading = false; _activeCol = -1; _activeRow = -1; _activeBeat = -1; });
  }

  void _stopTicker() { _ticker?.stop(); _ticker?.dispose(); _ticker = null; }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    _sid++;
    _stopTicker();
    _ctx?.close();
    _ctx = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableWrapWidth = MediaQuery.of(context).size.width - 32 - 30 - 6 - 8 - 24;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.arrow_back, size: 28), onPressed: () { _stop(); Navigator.pop(context); }),
                  Expanded(child: practiceHeader("Beat Player")),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: (_isPlaying || _isLoading) ? null : _play,
                    icon: _isLoading ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.play_arrow, size: 28),
                    label: const Text("PLAY", style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14)),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: _isPlaying ? _stop : null,
                    icon: const Icon(Icons.stop, size: 28),
                    label: const Text("STOP", style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text("BPM: ${widget.dto.bpm}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // SCROLLABLE BEAT GRID WITH SMOOTH AUTO-SCROLL
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Wrap(
                    spacing: 12, runSpacing: 9,
                    children: [
                      for (int col = 0; col < widget.dto.boxes.length; col++)
                        if (widget.dto.boxes[col].minorBeats > 0)
                          _buildBeatBox(col, availableWrapWidth),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBeatBox(int col, double availableWrapWidth) {
    final box = widget.dto.boxes[col];
    final lnum = box.lineNumber;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 32),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: 2), borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text("${box.lineNumber}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            Container(width: 2, height: 52, color: Colors.blue, margin: const EdgeInsets.only(right: 4)),
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: availableWrapWidth),
                child: Wrap(
                  spacing: 4, runSpacing: 4,
                  children: List.generate(box.minorBeats, (row) => _buildBeatCell(col, row, lnum)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeatCell(int col, int row, int lnum) {
    final act = _activeCol == col && _activeRow == row;
    final fs = lnum <= 4 ? 14.0 : lnum <= 8 ? 10.0 : 7.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 80),
      width: 52, height: 52,
      decoration: BoxDecoration(
        color: act ? Colors.orange : Colors.white,
        border: Border.all(color: act ? Colors.deepOrange : Colors.black, width: act ? 3 : 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: act ? [BoxShadow(color: Colors.orange.withOpacity(0.6), blurRadius: 10, spreadRadius: 2)] : [],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(lnum, (charIdx) {
              final lineActive = act && charIdx == _activeBeat;
              return Container(
                width: 1.5,
                height: 28,
                margin: const EdgeInsets.symmetric(horizontal: 0.8),
                decoration: BoxDecoration(
                  color: lineActive
                      ? Colors.black
                      : act
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black,
                  borderRadius: BorderRadius.circular(1),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
