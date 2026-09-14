import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'practice.dart';

// ─── SavedSession model ───────────────────────────────────────────────────────

class SavedSession {
  final String name;
  final DateTime savedAt;
  final List<CustomBoxInfo> boxes;
  final int bpm;

  SavedSession({
    required this.name,
    required this.savedAt,
    required this.boxes,
    required this.bpm,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'savedAt': savedAt.toIso8601String(),
    'bpm': bpm,
    'boxes': boxes.map((b) => {
      'id': b.id,
      'leftValue': b.leftValue,
      'rightValue': b.rightValue
    }).toList(),
  };

  factory SavedSession.fromJson(Map<String, dynamic> json) => SavedSession(
    name: json['name'] as String,
    savedAt: DateTime.parse(json['savedAt'] as String),
    bpm: json['bpm'] as int,
    boxes: (json['boxes'] as List)
        .map((b) => CustomBoxInfo(
      id: b['id'] as String,
      leftValue: b['leftValue'] as int,
      rightValue: b['rightValue'] as int,
    ))
        .toList(),
  );
}

// ─── Custom Box Data Model ────────────────────────────────────────────────────

class CustomBoxInfo {
  final String id;
  int leftValue;
  int rightValue;

  CustomBoxInfo({
    required this.id,
    required this.leftValue,
    required this.rightValue,
  });
}

// ─── Storage helpers ──────────────────────────────────────────────────────────

const _kStorageKey = 'advanced_sessions';

Future<List<SavedSession>> _loadSessions() async {
  final prefs = await SharedPreferences.getInstance();
  final raw = prefs.getString(_kStorageKey);
  if (raw == null) return [];
  try {
    final list = jsonDecode(raw) as List;
    return list.map((e) => SavedSession.fromJson(e as Map<String, dynamic>)).toList();
  } catch (_) {
    return [];
  }
}

Future<void> _persistSessions(List<SavedSession> sessions) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kStorageKey, jsonEncode(sessions.map((s) => s.toJson()).toList()));
}

// ─── Advanced App ─────────────────────────────────────────────────────────────

class Advanced extends StatelessWidget {
  const Advanced({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
    title: 'Advanced Timing',
    debugShowCheckedModeBanner: false,
    home: PracticeScreen(),
  );
}

// ─── CUSTOM BOX WIDGET ─────────────────────────────────────────────────────────

class CustomBox extends StatelessWidget {
  final int leftValue;
  final int rightValue;
  final bool isSelected;
  final bool leftSelected;
  final VoidCallback onTapLeft;
  final VoidCallback onTapRight;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final VoidCallback onRemove;
  final double itemWidth;

  const CustomBox({
    super.key,
    required this.leftValue,
    required this.rightValue,
    required this.isSelected,
    required this.leftSelected,
    required this.onTapLeft,
    required this.onTapRight,
    required this.onDecrement,
    required this.onIncrement,
    required this.onRemove,
    required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    final removeSize = (itemWidth * 0.26).clamp(18.0, 22.0);
    final gap = (itemWidth * 0.05).clamp(2.0, 4.0);
    final boxWidth = itemWidth - removeSize - gap;
    final boxHeight = (boxWidth * 0.6).clamp(36.0, 45.0);
    final fontSize = (boxWidth / 80 * 13).clamp(10.0, 12.0);
    final btnGap = (boxWidth * 0.08).clamp(2.0, 4.0);
    final btnSize = ((boxWidth - btnGap) / 2).clamp(18.0, 24.0);
    final iconSize = removeSize * 0.5;

    return SizedBox(
      width: itemWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: boxWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: boxWidth,
                  height: boxHeight,
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
                              color: isSelected && leftSelected
                                  ? Colors.orange.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "$leftValue",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1.5,
                        height: double.infinity,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: onTapRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected && !leftSelected
                                  ? Colors.orange.withOpacity(0.2)
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "$rightValue",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: gap),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _smallBtn("-", Colors.red, onDecrement, btnSize, fontSize + 1),
                    SizedBox(width: btnGap),
                    _smallBtn("+", Colors.green, onIncrement, btnSize, fontSize + 1),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: gap),
          Padding(
            padding: EdgeInsets.only(top: (boxHeight - removeSize) / 2),
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: removeSize,
                height: removeSize,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.red, width: 0.5),
                ),
                child: Icon(Icons.close, color: Colors.red, size: iconSize),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallBtn(String label, Color color, VoidCallback onTap, double size, double fontSize) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── PracticeScreen (Main Screen of Advanced) ─────────────────────────────────

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});
  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late List<CustomBoxInfo> _boxes;
  int? _selectedBoxIndex;
  bool _selectedLeft = true;
  int _idCounter = 0;

  final ScrollController _scrollController = ScrollController();



  String _newId() => '${DateTime.now().microsecondsSinceEpoch}_${_idCounter++}';

  @override
  void initState() {
    super.initState();
    _boxes = [
      CustomBoxInfo(id: _newId(), leftValue: 4, rightValue: 4),
    ];
  }

  // ── Simplest possible scroll — jumpTo after one frame, always works ──
  void _autoScrollToNewBox() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  void _addBox() {
    setState(() {
      _boxes.add(CustomBoxInfo(id: _newId(), leftValue: 4, rightValue: 4));
    });
    _autoScrollToNewBox();
  }

  void _removeBox(int index) => setState(() {
    if (index < 0 || index >= _boxes.length) return;
    _boxes.removeAt(index);
    if (_selectedBoxIndex == index) {
      _selectedBoxIndex = null;
    } else if (_selectedBoxIndex != null && _selectedBoxIndex! > index) {
      _selectedBoxIndex = _selectedBoxIndex! - 1;
    }
  });

  void _updateBoxValue(int index, bool isLeft, int delta) {
    setState(() {
      if (isLeft) {
        _boxes[index].leftValue += delta;
        if (_boxes[index].leftValue < 0) _boxes[index].leftValue = 0;
      } else {
        _boxes[index].rightValue += delta;
        if (_boxes[index].rightValue < 0) _boxes[index].rightValue = 0;
      }
    });
  }

  Future<void> _saveSession() async {
    final nameCtrl = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Save Session'),
        content: TextField(
          controller: nameCtrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Session name (e.g. Day 1)'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
        ],
      ),
    );
    if (confirmed != true) return;

    final now = DateTime.now();
    final name = nameCtrl.text.trim().isEmpty
        ? 'Session ${now.day}/${now.month} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}'
        : nameCtrl.text.trim();

    final sessions = await _loadSessions();
    final boxesToSave = _boxes.map((b) => CustomBoxInfo(
      id: b.id,
      leftValue: b.leftValue,
      rightValue: b.rightValue,
    )).toList();

    sessions.add(SavedSession(
      name: name,
      savedAt: DateTime.now(),
      bpm: 60,
      boxes: boxesToSave,
    ));
    await _persistSessions(sessions);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved "$name"'), backgroundColor: Colors.green),
    );
  }

  Future<void> _viewSaved() async {
    final sessions = await _loadSessions();
    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => _SavedSessionsSheet(
        sessions: sessions,
        onLoad: (session) {
          Navigator.pop(ctx);
          setState(() {
            _boxes = session.boxes
                .map((b) => CustomBoxInfo(
              id: b.id,
              leftValue: b.leftValue,
              rightValue: b.rightValue,
            ))
                .toList();
            _selectedBoxIndex = null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Loaded "${session.name}"'), backgroundColor: Colors.blue),
          );
        },
        onDelete: (index) async {
          sessions.removeAt(index);
          await _persistSessions(sessions);
          Navigator.pop(ctx);
          if (mounted) _viewSaved();
        },
      ),
    );
  }

  PracticeTimingDto _convertToDto() {
    final boxes = _boxes.map((b) => BoxInfoDto(
      lineNumber: b.leftValue,
      minorBeats: b.rightValue,
    )).toList();
    return PracticeTimingDto(bpm: 60, boxes: boxes);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Advanced Timing'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _addBox),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'save') _saveSession();
              if (value == 'view') _viewSaved();
            },
            itemBuilder: (ctx) => const [
              PopupMenuItem(value: 'save', child: Text('Save Session')),
              PopupMenuItem(value: 'view', child: Text('View Saved')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: practiceBpmBadge(60),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int r = 0; r < (_boxes.length / 4).ceil(); r++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int c = 0; c < 4; c++)
                              if (r * 4 + c < _boxes.length)
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    width: 85,
                                    child: CustomBox(
                                      leftValue: _boxes[r * 4 + c].leftValue,
                                      rightValue: _boxes[r * 4 + c].rightValue,
                                      isSelected: _selectedBoxIndex == r * 4 + c,
                                      leftSelected: _selectedLeft,
                                      itemWidth: 85,
                                      onTapLeft: () => setState(() {
                                        _selectedBoxIndex = r * 4 + c;
                                        _selectedLeft = true;
                                      }),
                                      onTapRight: () => setState(() {
                                        _selectedBoxIndex = r * 4 + c;
                                        _selectedLeft = false;
                                      }),
                                      onDecrement: () => _updateBoxValue(r * 4 + c, _selectedLeft, -1),
                                      onIncrement: () => _updateBoxValue(r * 4 + c, _selectedLeft, 1),
                                      onRemove: () => _removeBox(r * 4 + c),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BeatPlayPage(dto: _convertToDto())),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Text(
                    "NEXT",
                    style: TextStyle(fontSize: 20, color: Colors.white),
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

// ─── Saved Sessions Bottom Sheet ──────────────────────────────────────────────

class _SavedSessionsSheet extends StatelessWidget {
  final List<SavedSession> sessions;
  final void Function(SavedSession) onLoad;
  final void Function(int) onDelete;

  const _SavedSessionsSheet({
    required this.sessions,
    required this.onLoad,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (ctx, scrollCtrl) => Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 40, height: 4,
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                const Text('Saved Sessions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text('${sessions.length} saved', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          const Divider(),
          if (sessions.isEmpty)
            const Expanded(
              child: Center(
                child: Text('No saved sessions yet.\nTap Save to save one.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                controller: scrollCtrl,
                itemCount: sessions.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (ctx, i) {
                  final s = sessions[i];
                  final dateStr = '${s.savedAt.day}/${s.savedAt.month}/${s.savedAt.year}  '
                      '${s.savedAt.hour.toString().padLeft(2, '0')}:${s.savedAt.minute.toString().padLeft(2, '0')}';
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    title: Text(s.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('$dateStr · ${s.boxes.length} boxes · BPM ${s.bpm}',
                        style: const TextStyle(fontSize: 12)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () => onLoad(s),
                          child: const Text('Load', style: TextStyle(color: Colors.blue)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => onDelete(i),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
