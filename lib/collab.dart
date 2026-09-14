import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:web/web.dart' as web;
import 'dart:async';
import 'dart:typed_data';
import 'dart:js_interop';

class CollabMusic extends StatelessWidget {
  const CollabMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return SongListScreen();
  }
}

class Song {
  final String title;
  final String artist;
  final String duration;
  final List<String> lyricsLines;
  final List<int> lyricTimestamps;
  final String audioPath;
  String? userRecordingBlobUrl;
  Uint8List? userRecordingData;

  Song({
    required this.title,
    required this.artist,
    required this.duration,
    required this.lyricsLines,
    required this.lyricTimestamps,
    required this.audioPath,
    this.userRecordingBlobUrl,
    this.userRecordingData,
  });
}

List<Song> songs = [
  Song(
    title: 'Dandelions',
    artist: 'Ruth B',
    duration: '3:53',
    lyricsLines: '''
Maybe it's the way you say my name
Maybe it's the way you play your game
But it's so good, I've never known anybody like you
But it's so good, I've never dreamed of nobody like you

And I've heard of a love that comes once in a lifetime
And I'm pretty sure that you are that love of mine

'Cause I'm in a field of dandelions
Wishing on every one that you'd be mine, mine
And I see forever in your eyes
I feel okay when I see you smile, smile

Wishing on dandelions all of the time
Praying to God that one day you'll be mine
Wishing on dandelions all of the time, all of the time

I think that you are the one for me
'Cause it gets so hard to breathe
When you're looking at me, I've never felt so alive and free
When you're looking at me, I've never felt so happy

And I've heard of a love that comes once in a lifetime
And I'm pretty sure that you are, that love of mine

'Cause I'm in a field of dandelions
Wishing on every one that you'd be mine, mine
And I see forever in your eyes
I feel okay when I see you smile, smile

Wishing on dandelions all of the time
Praying to God that one day you'll be mine
Wishing on dandelions all of the time
All of the time

Dandelion, into the wind you go
Won't you let my darling know?
Dandelion, into the wind you go
Won't you let my darling know that?

I'm in a field of dandelions
Wishing on every one that you'd be mine, mine
Oh, and I see forever in your eyes
I feel okay when I see you smile, smile

Wishing on dandelions all of the time
Praying to God that one day you'll be mine
Wishing on dandelions all of the time, all of the time

I'm in a field of dandelions
Wishing on every one that you'd be mine, mine
'''.split('\n'),
    lyricTimestamps: [
      11,18,23,30,35,
      36,43,47,
      48,52,61,64,72,
      73,76,79,84,
      85,91,96,103,108,
      110,117,120,
      122,126,134,138,146,
      147,150,153,156,159,
      160,163,166,169,172,
      174,176,185,189,196,
      197,201,204,209,
      211,214,218,
    ],
    audioPath: 'audio/dandelions.mp3',
  ),
  Song(
    title: 'Espresso',
    artist: 'Sabrina Carpenter',
    duration: '2:55',
    lyricsLines: '''
Now he's thinkin' 'bout me every night, oh
Is it that sweet? I guess so
Say you can't sleep, baby, I know
That's that me espresso
Move it up, down, left, right, oh
Switch it up like Nintendo
Say you can't sleep, baby, I know
That's that me espresso

I can't relate To desperation
My 'give a fucks' are on vacation
And I got this one boy And he won't stop calling
When they act this way I know I got em'

Too bad your ex don't do it for ya
Walked in and dream came trued it for ya
Soft skin and I perfumed it for ya
I know I Mountain Dew it for ya
That morning coffee brewed it for ya
One touch and I brand newed it for ya

Now he's thinkin' 'bout me every night, oh
Is it that sweet? I guess so
Say you can't sleep, baby, I know
That's that me espresso
Move it up, down, left, right, oh
Switch it up like Nintendo
Say you can't sleep, baby, I know
That's that me espresso

Holy shit
Is it that sweet? I guess so

I'm working late 'cause I'm a singer
Oh, he looks so cute wrapped around my finger
My twisted humor make him laugh so often
My honey bee, come and get this pollen

Too bad your ex don't do it for ya
Walked in and dream came trued it for ya
Soft skin and I perfumed it for ya
I know I Mountain Dew it for ya
That morning coffee brewed it for ya
One touch and I brand newed it for ya

Now he's thinkin' 'bout me every night, oh
Is it that sweet? I guess so
Say you can't sleep, baby, I know
That's that me espresso
Move it up, down, left, right, oh
Switch it up like Nintendo
Say you can't sleep, baby, I know
That's that me espresso

Thinkin' 'bout me every night, oh
Is it that sweet? I guess so
Say you can't sleep, baby, I know
That's that me espresso
Move it up, down, left, right, oh
Switch it up like Nintendo
Say you can't sleep, baby, I know
That's that me espresso

Is it that sweet? I guess so
Mmm, that's that me espresso
'''.split('\n'),
    lyricTimestamps: [
      9,12,14,17,19,21,24,26,28,
      29,33,38,42,45,
      46,48,51,55,58,60,62,
      64,67,70,73,74,77,79,82,83,
      84,86,87,
      89,93,98,103,105,
      106,109,111,115,118,120,122,
      124,127,130,132,134,137,139,141,142,
      143,146,148,151,153,155,158,160,163,
      165,169,171
    ],
    audioPath: 'audio/espresso.mp3',
  ),
  Song(
    title: 'Night Changes',
    artist: 'One Direction',
    duration: '3:47',
    lyricsLines: '''
Going out tonight, changes into something red
Her mother doesn't like that kind of dress
Everything she never had, she's showing off
Driving too fast, moon is breaking through her hair
She's headin' for something that she won't forget
Having no regrets is all that she really wants

We're only getting older, baby
And I've been thinking about it lately
Does it ever drive you crazy
Just how fast the night changes?
Everything that you've ever dreamed of
Disappearing when you wake up
But there's nothing to be afraid of
Even when the night changes
It will never change me and you

Chasing her tonight, doubts are running 'round her head
He's waiting, hides behind a cigarette
Heart is beating loud, and she doesn't want it to stop
Moving too fast, moon is lighting up her skin
She's falling, doesn't even know it yet
Having no regrets is all that she really wants

We're only getting older, baby
And I've been thinking about it lately
Does it ever drive you crazy
Just how fast the night changes?

Everything that you've ever dreamed of
Disappearing when you wake up
But there's nothing to be afraid of
Even when the night changes
It will never change me and you

Going out tonight, changes into something red
Her mother doesn't like that kind of dress
Reminds her of the missing piece of innocence she lost
We're only getting older, baby
And I've been thinking about it lately
Does it ever drive you crazy
Just how fast the night changes?

Everything that you've ever dreamed of
Disappearing when you wake up
But there's nothing to be afraid of
Even when the night changes

Everything that you've ever dreamed of
disappearing when you wake up
But there's nothinng to be afraid of
Even when the night changes

It will never change, baby
It will never change, baby
It will never change me and you
'''.split('\n'),
    lyricTimestamps: [
      8,12,16,24,29,32,39,
      41,44,48,52,57,61,65,68,72,78,
      80,85,88,96,100,104,110,
      112,116,120,124,128,
      129,133,136,140,144,150,
      160,165,168,174,178,182,186,190,
      191,194,198,202,205,
      206,211,215,219,222,
      223,227,231,236
    ],
    audioPath: 'audio/nightchanges.mp3',
  ),
  Song(
    title: 'Perfect',
    artist: 'Ed Sheeran',
    duration: '4:23',
    lyricsLines: '''
    I found a love for me
    Darling, just dive right in and follow my lead
Well, I found a girl, beautiful and sweet
Oh, I never knew you were the someone waiting for me

'Cause we were just kids when we fell in love
Not knowing what it was
I will not give you up this time
But darling, just kiss me slow
Your heart is all I own
And in your eyes you're holding mine

Baby, I'm dancing in the dark With you between my arms
Barefoot on the grass Listening to our favourite song
When you said you looked a mess-I whispered underneath my breath
But you heard it,Darling, you look perfect tonight

Well, I found a woman, stronger than anyone I know
She shares my dreams, I hope that someday I'll share her home
I found a lover to carry more than just my secrets
To carry love, to carry children of our own

We are still kids but we're so in love
Fighting against all odds
I know we'll be alright this time
Darling, just hold my hand
Be my girl, I'll be your man
I see my future in your eyes

Baby, I'm dancing in the dark With you between my arms
Barefoot on the grass Listening to our favourite song
When I saw you in that dress Looking so beautiful
I don't deserve this Darling, you look perfect tonight

No, no, no
mm

Baby, I'm dancing in the dark With you between my arms
Barefoot on the grass Listening to our favourite song
I have faith in what I see Now I know I have met 
an angel in person And she looks perfect
I don't deserve this
You look perfect tonight
'''.split('\n'),
    lyricTimestamps: [
      3,10,18,25,31,
      32,37,40,47,52,55,60,
      62,73,80,87,95,
      99,108,116,124,129,
      130,134,138,146,150,153,159,
      160,171,179,184,191,
      198,203,205,
      206,217,224,230,238,241,246,
    ],
    audioPath: 'audio/perfect.mp3',
  ),
  Song(
    title: 'Bad Blood',
    artist: 'Taylor Swift',
    duration: '3:31',
    lyricsLines: '''
Cause baby, now we got bad blood
You know it used to be mad love
So take a look what you've done
'Cause baby, now we got bad blood, hey
Now we got problems
And I don't think we can solve 'em
You made a really deep cut
And baby, now we got bad blood, hey

Did you have to do this?
I was thinking that you could be trusted
Did you have to ruin
What was shiny? Now it's all rusted

Did you have to hit me
Where I'm weak? Baby, I couldn't breathe and
Rub it in so deep
Salt in the wound like you're laughing right at me

Oh, it's so sad to Think about the good times
You and I

'Cause baby, now we got bad blood
You know it used to be mad love
So take a look what you've done
'Cause baby, now we got bad blood, hey
Now we got problems
And I don't think we can solve 'em
You made a really deep cut
And baby, now we got bad blood, hey

Did you think we'd be fine?
Still got scars on my back from your knife
So, don't think it's in the past
These kinds of wounds they last, and they last

Now, did you think it all through?
All these things will catch up to you
And time can heal but this won't
So if you're coming my way
Just don't

Oh, it's so sad to Think about the good times
You and I

'Cause baby, now we got bad blood
You know it used to be mad love
So take a look what you've done
'Cause baby, now we got bad blood, hey
Now we got problems
And I don't think we can solve 'em
You made a really deep cut
And baby, now we got bad blood, hey

Band-Aids don't fix bullet holes
You say sorry just for show
If you live like that, you live with ghosts (Ghosts)
Band-Aids don't fix bullet holes
You say sorry just for show
If you live like that, you live with ghosts, mmm
Hmm,If you love like that Blood runs cold

'Cause baby, now we got bad blood
You know it used to be mad love
So take a look what you've done
'Cause baby, now we got bad blood, [hey]
Now we got problems
And I don't think we can solve 'em (Think we can solve 'em)
You made a really deep cut
And baby, now we got bad blood

'Cause baby now we got bad blood
You know it used to be mad love
So take a look what you've done (Look what you've done)
'Cause baby, now we got bad blood, hey
Now we got problems
And I don't think we can solve 'em
You made a really deep cut
And baby, now we got bad blood, hey
'''.split('\n'),
    lyricTimestamps: [
      1,3,6,9,12,14,17,19,22,
      23,26,29,31,34,
      35,37,40,43,46,
      47,53,54,
      57,60,62,65,68,71,74,76,79,
      80,82,85,88,90,
      91,94,97,99,100,101,
      103,109,111,
      113,116,119,122,125,128,130,132,135,
      136,139,142,147,150,153,156,160,
      161,164,167,170,173,175,178,180,182,
      184,187,189,192,196,198,201,204,207
    ],
    audioPath: 'audio/badblood.mp3',
  ),
];

// ==================== SCREEN 1 ====================
class SongListScreen extends StatefulWidget {
  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyPlayingIndex;
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSong(int index) async {
    try {
      if (_currentlyPlayingIndex == index) {
        if (_isPlaying) {
          await _audioPlayer.pause();
          setState(() => _isPlaying = false);
        } else {
          await _audioPlayer.resume();
          setState(() => _isPlaying = true);
        }
        return;
      }
      if (_currentlyPlayingIndex != null) await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(songs[index].audioPath));
      setState(() {
        _currentlyPlayingIndex = index;
        _isPlaying = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot play audio: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Collaborative Music', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text('SONG LIST',
                style: TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            SizedBox(height: 9),
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SongDetailScreen(song: songs[index]))),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => _playSong(index),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (_currentlyPlayingIndex == index && _isPlaying)
                                          ? Colors.deepPurple
                                          : Colors.deepPurple.withOpacity(0.2),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      (_currentlyPlayingIndex == index && _isPlaying)
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 15,
                                      color: (_currentlyPlayingIndex == index && _isPlaying)
                                          ? Colors.white
                                          : Colors.deepPurple,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Row(children: [
                                    Text('•',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple)),
                                    SizedBox(width: 9),
                                    Expanded(
                                        child: Text(songs[index].title,
                                            style: TextStyle(
                                                fontSize: 17, fontWeight: FontWeight.w600))),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8, bottom: 3),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(songs[index].duration,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SCREEN 2 ====================
class SongDetailScreen extends StatefulWidget {
  final Song song;
  const SongDetailScreen({required this.song});

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  final AudioPlayer _recPlayer = AudioPlayer();
  bool _isRecPlaying = false;
  Duration _recPosition = Duration.zero;
  Duration _recDuration = Duration.zero;
  bool _recReady = false;

  @override
  void initState() {
    super.initState();

    _audioPlayer.onPositionChanged.listen((p) {
      if (mounted) setState(() => _currentPosition = p);
    });
    _audioPlayer.onDurationChanged.listen((d) {
      if (mounted) setState(() => _totalDuration = d);
    });
    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) setState(() => _isPlaying = false);
    });

    _recPlayer.onPositionChanged.listen((p) {
      if (mounted) setState(() => _recPosition = p);
    });
    _recPlayer.onDurationChanged.listen((d) {
      if (mounted) setState(() => _recDuration = d);
    });
    _recPlayer.onPlayerComplete.listen((_) {
      if (mounted) setState(() {
        _isRecPlaying = false;
        _recPosition = Duration.zero;
      });
    });

    if (widget.song.userRecordingData != null) {
      _buildBlobUrl();
    }
  }

  // ✅ package:web replacement for dart:html Blob + createObjectUrl
  void _buildBlobUrl() {
    if (widget.song.userRecordingBlobUrl == null) {
      final bytes = widget.song.userRecordingData!;
      // Correct way: wrap Uint8List as JSUint8Array, put it in a JSArray<JSAny>
      final jsUint8 = bytes.toJS; // JSUint8Array
      final blobParts = <JSAny>[jsUint8].toJS; // JSArray<JSAny>
      final options = web.BlobPropertyBag(type: 'audio/webm');
      final blob = web.Blob(blobParts, options);
      widget.song.userRecordingBlobUrl = web.URL.createObjectURL(blob);
    }
    setState(() => _recReady = true);
  }

  Future<void> _toggleRecording() async {
    if (!_recReady || widget.song.userRecordingBlobUrl == null) return;

    if (_isRecPlaying) {
      await _recPlayer.pause();
      if (mounted) setState(() => _isRecPlaying = false);
    } else {
      try {
        await _recPlayer.play(UrlSource(widget.song.userRecordingBlobUrl!));
        if (mounted) setState(() => _isRecPlaying = true);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cannot play recording: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  Future<void> _playAudio() async {
    try {
      setState(() => _isLoading = true);
      await _audioPlayer.play(AssetSource(widget.song.audioPath));
      if (mounted) setState(() {
        _isPlaying = true;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cannot play: $e'), backgroundColor: Colors.red));
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    if (mounted) setState(() => _isPlaying = false);
  }

  String _fmt(Duration d) {
    if (d.inSeconds < 0) return "00:00";
    return "${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _recPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.song.title),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple, width: 2.5),
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[50],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Text(
                    widget.song.lyricsLines.join('\n'),
                    style: TextStyle(fontSize: 16, height: 1.6, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(widget.song.title,
                style: TextStyle(
                    fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            SizedBox(height: 8),
            Text(widget.song.artist, style: TextStyle(fontSize: 18, color: Colors.grey[600])),
            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
              ),
              child: Row(children: [
                GestureDetector(
                  onTap: _isPlaying ? _pauseAudio : _playAudio,
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.deepPurple),
                    padding: EdgeInsets.all(8),
                    child: _isLoading
                        ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 30, color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(children: [
                    if (_totalDuration.inSeconds > 0)
                      Slider(
                        value: _currentPosition.inSeconds
                            .toDouble()
                            .clamp(0, _totalDuration.inSeconds.toDouble()),
                        max: _totalDuration.inSeconds.toDouble(),
                        onChanged: (v) => _audioPlayer.seek(Duration(seconds: v.toInt())),
                        activeColor: Colors.deepPurple,
                      ),
                    if (_totalDuration.inSeconds > 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_fmt(_currentPosition),
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                              Text(_fmt(_totalDuration),
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                            ]),
                      ),
                  ]),
                ),
              ]),
            ),

            if (widget.song.userRecordingData != null) ...[
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.withOpacity(0.5), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(Icons.mic, color: Colors.green, size: 18),
                      SizedBox(width: 6),
                      Text('Your Recording',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700])),
                      SizedBox(width: 6),
                      Icon(Icons.check_circle, size: 16, color: Colors.green),
                    ]),
                    SizedBox(height: 12),
                    Row(children: [
                      GestureDetector(
                        onTap: _toggleRecording,
                        child: Container(
                          decoration:
                          BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            _isRecPlaying ? Icons.pause : Icons.play_arrow,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(children: [
                          if (_recDuration.inSeconds > 0) ...[
                            Slider(
                              value: _recPosition.inSeconds
                                  .toDouble()
                                  .clamp(0, _recDuration.inSeconds.toDouble()),
                              max: _recDuration.inSeconds.toDouble(),
                              onChanged: (v) {
                                _recPlayer.seek(Duration(seconds: v.toInt()));
                                setState(() => _recPosition = Duration(seconds: v.toInt()));
                              },
                              activeColor: Colors.green,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_fmt(_recPosition),
                                        style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                    Text(_fmt(_recDuration),
                                        style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                  ]),
                            ),
                          ] else ...[
                            SizedBox(height: 8),
                            Text(
                              _isRecPlaying ? 'Playing...' : 'Tap play to listen',
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ]),
                      ),
                    ]),
                  ],
                ),
              ),
            ],

            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () async {
                await _audioPlayer.stop();
                await _recPlayer.stop();
                setState(() {
                  _isPlaying = false;
                  _isRecPlaying = false;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RecorderScreen(song: widget.song)));
              },
              icon: Icon(Icons.person_add, size: 28),
              label: Text('Include Me',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                minimumSize: Size(200, 55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SCREEN 3 ====================
class RecorderScreen extends StatefulWidget {
  final Song song;
  const RecorderScreen({required this.song});

  @override
  State<RecorderScreen> createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen> {
  final AudioPlayer _bgmPlayer = AudioPlayer();
  final ScrollController _scrollController = ScrollController();

  late List<GlobalKey> _lyricKeys;

  // ✅ package:web types instead of dart:html
  web.MediaRecorder? _mediaRecorder;
  web.MediaStream? _mediaStream;
  List<web.Blob> _recordedChunks = [];

  bool _isBgmPlaying = false;
  bool _isRecording = false;
  bool _isLoading = false;
  bool _hasPermission = false;
  bool _hasStarted = false;

  // ✅ NEW: true once user presses the red STOP button (finalises recording)
  bool _isStopped = false;

  int _currentLyricIndex = -1;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  bool _userScrolling = false;
  Timer? _userScrollTimer;

  @override
  void initState() {
    super.initState();
    _lyricKeys = List.generate(widget.song.lyricsLines.length, (_) => GlobalKey());
    _requestMicPermission();
    _setupBgmListeners();
    _scrollController.addListener(_onUserScroll);
  }

  void _onUserScroll() {
    _userScrolling = true;
    _userScrollTimer?.cancel();
    _userScrollTimer = Timer(Duration(seconds: 3), () => _userScrolling = false);
  }

  // ✅ package:web: getUserMedia
  Future<void> _requestMicPermission() async {
    try {
      final constraints = web.MediaStreamConstraints(audio: true.toJS, video: false.toJS);
      final stream =
      await web.window.navigator.mediaDevices.getUserMedia(constraints).toDart;
      _mediaStream = stream;
      setState(() => _hasPermission = true);
    } catch (e) {
      setState(() => _hasPermission = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Microphone blocked — click 🔒 in address bar and allow mic.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 6),
          ),
        );
      }
    }
  }

  void _setupBgmListeners() {
    _bgmPlayer.onPositionChanged.listen((position) {
      if (!mounted) return;
      setState(() => _currentPosition = position);

      final secs = position.inSeconds;
      final timestamps = widget.song.lyricTimestamps;

      int idx = -1;
      for (int i = 0; i < timestamps.length; i++) {
        if (secs >= timestamps[i]) {
          idx = i;
        } else {
          break;
        }
      }

      if (idx != _currentLyricIndex) {
        setState(() => _currentLyricIndex = idx);
        if (idx >= 0) _scrollToLyric(idx);
      }
    });

    _bgmPlayer.onDurationChanged.listen((d) {
      if (mounted) setState(() => _totalDuration = d);
    });

    _bgmPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _isBgmPlaying = false;
          _currentLyricIndex = -1;
        });
        if (_isRecording) _hardStop();
      }
    });
  }

  void _scrollToLyric(int index) {
    if (_userScrolling) return;
    if (index < 0 || index >= _lyricKeys.length) return;
    final ctx = _lyricKeys[index].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0.35,
    );
  }

  // ✅ package:web: isTypeSupported
  String _getSupportedMimeType() {
    const candidates = [
      'audio/webm;codecs=opus',
      'audio/webm',
      'audio/ogg;codecs=opus',
      'audio/ogg',
    ];
    for (final t in candidates) {
      if (web.MediaRecorder.isTypeSupported(t)) return t;
    }
    return '';
  }

  /// START — kicks off song + recording together
  Future<void> _startSession() async {
    if (!_hasPermission || _mediaStream == null) {
      await _requestMicPermission();
      if (!_hasPermission) return;
    }
    try {
      await _bgmPlayer.play(AssetSource(widget.song.audioPath));

      _recordedChunks = [];
      final mimeType = _getSupportedMimeType();

      // ✅ package:web: MediaRecorder with optional mimeType
      final options = mimeType.isNotEmpty
          ? web.MediaRecorderOptions(mimeType: mimeType)
          : web.MediaRecorderOptions();
      _mediaRecorder = web.MediaRecorder(_mediaStream!, options);

      // ✅ package:web: addEventListener with JSFunction
      _mediaRecorder!.addEventListener(
        'dataavailable',
            (web.Event event) {
          final blobEvent = event as web.BlobEvent;
          final blob = blobEvent.data;
          if (blob != null && blob.size > 0) _recordedChunks.add(blob);
        }.toJS,
      );

      _mediaRecorder!.start(1000);

      setState(() {
        _isBgmPlaying = true;
        _isRecording = true;
        _hasStarted = true;
        _isStopped = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error starting: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  /// PAUSE — pauses both song + recorder (can resume)
  Future<void> _pauseSession() async {
    await _bgmPlayer.pause();
    if (_mediaRecorder != null && _mediaRecorder!.state == 'recording') {
      _mediaRecorder!.pause();
    }
    setState(() {
      _isBgmPlaying = false;
      _isRecording = false;
    });
  }

  /// RESUME — resumes both
  Future<void> _resumeSession() async {
    await _bgmPlayer.resume();
    if (_mediaRecorder != null && _mediaRecorder!.state == 'paused') {
      _mediaRecorder!.resume();
    }
    setState(() {
      _isBgmPlaying = true;
      _isRecording = true;
    });
  }

  /// ✅ NEW STOP — fully stops both song + recording, saves data, enables SUBMIT
  Future<void> _hardStop() async {
    await _bgmPlayer.stop();
    await _stopRecording(); // finalises and saves audio data
    if (mounted) {
      setState(() {
        _isBgmPlaying = false;
        _isRecording = false;
        _isStopped = true; // unlocks SUBMIT
      });
    }
  }

  /// Finalises MediaRecorder and stores audio bytes
  Future<void> _stopRecording() async {
    if (_mediaRecorder == null || _mediaRecorder!.state == 'inactive') return;

    final completer = Completer<Uint8List?>();

    // ✅ Callback must be synchronous (no async) for .toJS
    // Use a nested completer for the FileReader to bridge async work
    _mediaRecorder!.addEventListener(
      'stop',
          (web.Event _) {
        if (_recordedChunks.isNotEmpty) {
          // Merge all blob chunks into one Blob
          final blobParts = <JSAny>[..._recordedChunks].toJS;
          final options = web.BlobPropertyBag(type: 'audio/webm');
          final blob = web.Blob(blobParts, options);

          // ✅ FileReader: loadend callback must also be synchronous
          final reader = web.FileReader();
          reader.addEventListener(
            'loadend',
                (web.Event _) {
              final result = reader.result;
              if (result != null) {
                // result is JSArrayBuffer — convert to Dart Uint8List
                final jsBuffer = result as JSArrayBuffer;
                final dartBytes = jsBuffer.toDart.asUint8List();
                completer.complete(dartBytes);
              } else {
                completer.complete(null);
              }
            }.toJS,
          );
          reader.readAsArrayBuffer(blob);
        } else {
          completer.complete(null);
        }
      }.toJS,
    );

    _mediaRecorder!.stop();
    final audioData = await completer.future;

    if (mounted && audioData != null && audioData.isNotEmpty) {
      widget.song.userRecordingBlobUrl = null;
      widget.song.userRecordingData = audioData;
    }
  }

  /// SUBMIT — only works after STOP has been pressed
  Future<void> _submitRecording() async {
    if (!_hasStarted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please record something first!'),
            backgroundColor: Colors.orange),
      );
      return;
    }
    if (!_isStopped) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Press STOP first before submitting!'),
            backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Guard: stop anything still running
    await _bgmPlayer.stop();
    if (_isRecording) await _stopRecording();

    setState(() {
      _isBgmPlaying = false;
      _isRecording = false;
      _isLoading = false;
    });

    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => SongDetailScreen(song: widget.song)),
    );
  }

  String _fmt(Duration d) {
    if (d.inSeconds < 0) return "00:00";
    return "${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _bgmPlayer.dispose();
    _scrollController.dispose();
    _userScrollTimer?.cancel();
    // ✅ package:web: stop all mic tracks
    _mediaStream?.getTracks().toDart.forEach((t) => t.stop());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('🎤 Sing: ${widget.song.title}',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Mic permission banner
          if (!_hasPermission)
            Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red),
              ),
              child: Row(children: [
                Icon(Icons.mic_off, color: Colors.red),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Allow microphone in browser (click 🔒 in address bar).',
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),
                TextButton(
                  onPressed: _requestMicPermission,
                  child: Text('Retry',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ]),
            ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── LEFT: Lyrics Box ──
                  Expanded(
                    flex: 55,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.deepPurple, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                          child: Column(
                            children: List.generate(widget.song.lyricsLines.length, (index) {
                              final isCurrent = index == _currentLyricIndex;
                              final isPast = index < _currentLyricIndex;

                              return AnimatedContainer(
                                key: _lyricKeys[index],
                                duration: Duration(milliseconds: 350),
                                curve: Curves.easeInOut,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                padding: isCurrent
                                    ? EdgeInsets.symmetric(vertical: 8, horizontal: 10)
                                    : EdgeInsets.zero,
                                decoration: isCurrent
                                    ? BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.deepPurple.withOpacity(0.7),
                                      width: 1.5),
                                )
                                    : null,
                                child: AnimatedDefaultTextStyle(
                                  duration: Duration(milliseconds: 350),
                                  curve: Curves.easeInOut,
                                  style: TextStyle(
                                    fontSize: isCurrent ? 18 : 14,
                                    fontWeight:
                                    isCurrent ? FontWeight.bold : FontWeight.normal,
                                    color: isCurrent
                                        ? Colors.white
                                        : isPast
                                        ? Colors.grey[700]!
                                        : Colors.grey[400]!,
                                    letterSpacing: isCurrent ? 0.4 : 0,
                                  ),
                                  child: Text(
                                    widget.song.lyricsLines[index],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12),

                  // ── RIGHT: Controls ──
                  Expanded(
                    flex: 45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── START / PAUSE / RESUME button ──
                        // Hidden once STOP has been pressed
                        if (!_isStopped)
                          GestureDetector(
                            onTap: !_hasPermission
                                ? _requestMicPermission
                                : !_hasStarted
                                ? _startSession
                                : (_isRecording ? _pauseSession : _resumeSession),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              decoration: BoxDecoration(
                                color: !_hasPermission
                                    ? Colors.grey
                                    : !_hasStarted
                                    ? Colors.deepPurple
                                    : _isRecording
                                    ? Colors.orange
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: (!_hasStarted
                                        ? Colors.deepPurple
                                        : _isRecording
                                        ? Colors.orange
                                        : Colors.green)
                                        .withOpacity(0.45),
                                    blurRadius: 18,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    !_hasPermission
                                        ? Icons.mic_off
                                        : !_hasStarted
                                        ? Icons.play_circle_fill
                                        : _isRecording
                                        ? Icons.pause_circle_filled
                                        : Icons.play_circle_fill,
                                    color: Colors.white,
                                    size: 44,
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    !_hasPermission
                                        ? 'Allow Mic'
                                        : !_hasStarted
                                        ? 'START'
                                        : _isRecording
                                        ? 'PAUSE'
                                        : 'RESUME',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        if (!_isStopped) SizedBox(height: 12),

                        // ── Song Player Card ──
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.deepPurple.withOpacity(0.5)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(Icons.music_note,
                                    color: Colors.deepPurple[200], size: 16),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text('Song',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600)),
                                ),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _isBgmPlaying ? Colors.greenAccent : Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  _isBgmPlaying ? 'Playing' : (_isStopped ? 'Stopped' : 'Paused'),
                                  style: TextStyle(
                                      color: _isBgmPlaying ? Colors.greenAccent : Colors.grey,
                                      fontSize: 11),
                                ),
                              ]),
                              SizedBox(height: 10),
                              Text(
                                widget.song.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(widget.song.artist,
                                  style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                              if (_totalDuration.inSeconds > 0) ...[
                                SizedBox(height: 8),
                                SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 3,
                                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                                    overlayShape:
                                    RoundSliderOverlayShape(overlayRadius: 10),
                                  ),
                                  child: Slider(
                                    value: _currentPosition.inSeconds
                                        .toDouble()
                                        .clamp(0, _totalDuration.inSeconds.toDouble()),
                                    max: _totalDuration.inSeconds.toDouble(),
                                    onChanged: _isStopped
                                        ? null
                                        : (v) => _bgmPlayer.seek(Duration(seconds: v.toInt())),
                                    activeColor: Colors.deepPurple[300],
                                    inactiveColor: Colors.grey[700],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(_fmt(_currentPosition),
                                          style: TextStyle(
                                              color: Colors.grey[500], fontSize: 11)),
                                      Text(_fmt(_totalDuration),
                                          style: TextStyle(
                                              color: Colors.grey[500], fontSize: 11)),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        SizedBox(height: 12),

                        // ── Recording Status Card ──
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: _isRecording
                                ? Colors.red.withOpacity(0.15)
                                : _isStopped
                                ? Colors.green.withOpacity(0.1)
                                : Colors.grey[850],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _isRecording
                                  ? Colors.red.withOpacity(0.6)
                                  : _isStopped
                                  ? Colors.green.withOpacity(0.6)
                                  : Colors.grey[700]!,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(
                                  Icons.mic,
                                  color: _isRecording
                                      ? Colors.red
                                      : _isStopped
                                      ? Colors.green
                                      : Colors.grey,
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                Text('Your Recording',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                                Spacer(),
                                if (_isRecording) ...[
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.red),
                                  ),
                                  SizedBox(width: 4),
                                  Text('REC',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold)),
                                ],
                                if (_isStopped)
                                  Text('DONE',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold)),
                              ]),
                              SizedBox(height: 12),
                              Center(
                                child: Text(
                                  !_hasStarted
                                      ? 'Press START to begin'
                                      : _isRecording
                                      ? '🎤 Recording your voice...'
                                      : _isStopped
                                      ? '✅ Recording saved! Ready to submit.'
                                      : '⏸ Paused',
                                  style: TextStyle(
                                    color: !_hasStarted
                                        ? Colors.grey[600]!
                                        : _isRecording
                                        ? Colors.redAccent
                                        : _isStopped
                                        ? Colors.greenAccent
                                        : Colors.grey[400]!,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 12),

                        // ✅ NEW: STOP button — visible only after recording has started and not yet stopped
                        if (_hasStarted && !_isStopped)
                          GestureDetector(
                            onTap: _hardStop,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.red[700],
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.5),
                                    blurRadius: 14,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.stop_circle_outlined,
                                      color: Colors.white, size: 38),
                                  SizedBox(height: 4),
                                  Text(
                                    'STOP',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 1.4,
                                    ),
                                  ),
                                  Text(
                                    'Stops recording & song',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        if (_hasStarted && !_isStopped) SizedBox(height: 12),

                        Spacer(),

                        // ── SUBMIT button ── (enabled only after STOP)
                        ElevatedButton(
                          onPressed: (_isLoading || !_isStopped) ? null : _submitRecording,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isStopped ? Colors.green : Colors.grey[700],
                            disabledBackgroundColor: Colors.grey[800],
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          child: _isLoading
                              ? SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                              : Text(
                            _isStopped ? '✅ SUBMIT' : '⏹ Stop first to submit',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),

                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}