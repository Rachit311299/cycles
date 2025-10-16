import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/subtitle_cue.dart';
import '../services/srt_parser.dart';

enum BottomCardTab { pronunciation, explanation }
enum Language { en, es }

class PronunciationData {
  final String englishWord;
  final String spanishWord;
  final bool hasEnglishAudio;
  final bool hasSpanishAudio;

  const PronunciationData({
    required this.englishWord,
    required this.spanishWord,
    required this.hasEnglishAudio,
    required this.hasSpanishAudio,
  });
}

class ExplanationData {
  final String englishText;
  final String spanishText;
  final Language selectedLanguage;
  final AudioPlayer? audioPlayer;
  final String? subtitlesPath;

  const ExplanationData({
    required this.englishText,
    required this.spanishText,
    this.selectedLanguage = Language.en,
    this.audioPlayer,
    this.subtitlesPath,
  });
}

class BottomSwitchCard extends StatefulWidget {
  final Color? surfaceColor;
  final Color accentColor;
  final BottomCardTab tab; // initial tab
  final double widthFactor;

  // Pronunciation
  final PronunciationData pronunciation;
  final VoidCallback? onPlayEnglishPronunciation;
  final VoidCallback? onPlaySpanishPronunciation;

  // Explanation
  final ExplanationData explanation;
  final ValueChanged<Language>? onExplanationLanguageChanged;
  final bool isExplanationPlaying;
  final VoidCallback? onToggleExplanationPlay;

  const BottomSwitchCard({
    super.key,
    this.surfaceColor,
    required this.accentColor,
    required this.tab,
    this.widthFactor = 0.86,
    required this.pronunciation,
    required this.explanation,
    this.onPlayEnglishPronunciation,
    this.onPlaySpanishPronunciation,
    this.onExplanationLanguageChanged,
    this.isExplanationPlaying = false,
    this.onToggleExplanationPlay,
  });

  @override
  State<BottomSwitchCard> createState() => _BottomSwitchCardState();
}

class _BottomSwitchCardState extends State<BottomSwitchCard> {
  late final PageController _controller;
  late BottomCardTab _currentTab;

  Color get _cardColor => widget.surfaceColor ?? Color.lerp(Colors.white, widget.accentColor, 0.6)!;

  @override
  void initState() {
    super.initState();
    _currentTab = widget.tab;
    _controller = PageController(initialPage: _currentTab == BottomCardTab.pronunciation ? 0 : 1);
    // Track user-driven scrolling to allow responsive taps mid-gesture
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      try {
        // Listener left intentionally for future use; currently no-op
        _controller.position.isScrollingNotifier.addListener(() {});
      } catch (_) {
        // no-op if position not yet attached; will attach after first build
      }
    });
  }

  void _goToPage(int page) {
    if (!_controller.hasClients) return;
    // Always allow jumping mid-animation; animateToPage queues cleanly
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
    );
  }

  // _goToTab removed usage; keep helper for future hooks if needed

  @override
  void didUpdateWidget(covariant BottomSwitchCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tab != widget.tab && widget.tab != _currentTab) {
      _currentTab = widget.tab;
      _controller.jumpToPage(_currentTab == BottomCardTab.pronunciation ? 0 : 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widget.widthFactor,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.20),
              blurRadius: 18,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
              Row(
            children: [
          Text(
            _currentTab == BottomCardTab.pronunciation
                ? 'Pronunciation'
                : 'Explanation',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'PoetsenOne',
              color: Colors.black87,
            ),
          ),
              const Spacer(),
                  _DotsIndicator(
                count: 2,
                index: _currentTab == BottomCardTab.pronunciation ? 0 : 1,
                activeColor: widget.accentColor,
                    onDotTap: (i) => _goToPage(i),
              ),
            ],
          ),
          const SizedBox(height: 8),
              SizedBox(
                height: 180,
                child: PageView(
                  controller: _controller,
                  onPageChanged: (i) {
                    setState(() {
                      _currentTab = i == 0
                          ? BottomCardTab.pronunciation
                          : BottomCardTab.explanation;
                    });
                  },
                  children: [
                    _buildPronunciation(context),
                    _buildExplanation(context),
                  ],
                ),
              ),
        ],
      ),
    ),
    );
  }

  // Tabs removed in favor of swipeable pages with dots indicator

  Widget _buildPronunciation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          _PronunciationRow(
            label: '🇬🇧 English',
            word: widget.pronunciation.englishWord,
            onPlay: widget.pronunciation.hasEnglishAudio ? widget.onPlayEnglishPronunciation : null,
            accentColor: widget.accentColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          _PronunciationRow(
            label: '🇪🇸 Spanish',
            word: widget.pronunciation.spanishWord,
            onPlay: widget.pronunciation.hasSpanishAudio ? widget.onPlaySpanishPronunciation : null,
            accentColor: widget.accentColor,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildExplanation(BuildContext context) {
    final isEnglish = widget.explanation.selectedLanguage == Language.en;
    final text = isEnglish ? widget.explanation.englishText : widget.explanation.spanishText;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main content area: Subtitles (takes most space)
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: widget.explanation.subtitlesPath != null && widget.explanation.audioPlayer != null
                    ? _buildLiveSubtitles()
                    : SingleChildScrollView(
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'PoetsenOne',
                            height: 1.3,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ),
          ),
          // Right side controls (top-aligned)
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _LanguageToggle(
                  language: widget.explanation.selectedLanguage,
                  onChanged: widget.onExplanationLanguageChanged,
                  accentColor: widget.accentColor,
                ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: widget.accentColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    widget.isExplanationPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    color: widget.accentColor,
                    size: 32,
                  ),
                  onPressed: widget.onToggleExplanationPlay,
                  tooltip: widget.isExplanationPlaying ? 'Pause explanation' : 'Play explanation',
                  splashColor: widget.accentColor.withOpacity(0.3),
                  highlightColor: widget.accentColor.withOpacity(0.2),
                ),
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveSubtitles() {
    return FutureBuilder<List<SubtitleCue>>(
      future: SrtParser.parseFromAsset(widget.explanation.subtitlesPath!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SingleChildScrollView(
            child: Text(
              widget.explanation.selectedLanguage == Language.en 
                  ? widget.explanation.englishText 
                  : widget.explanation.spanishText,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'PoetsenOne',
                height: 1.3,
                color: Colors.black87,
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final cues = snapshot.data!;
        return StreamBuilder<Duration>(
          stream: widget.explanation.audioPlayer!.positionStream,
          builder: (context, positionSnapshot) {
            final currentPosition = positionSnapshot.data ?? Duration.zero;
            final activeCueIndex = _findActiveCueIndex(cues, currentPosition);

            if (activeCueIndex == -1) {
              // No active cue, show first cue or empty state
              return Center(
                child: Text(
                  cues.isNotEmpty ? cues[0].text : 'Ready to play...',
                  style: const TextStyle(
                    fontSize: 24,
                    height: 1.3,
                    color: Colors.black54,
                    fontFamily: 'PoetsenOne',
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            final activeCue = cues[activeCueIndex];
            
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.2),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    )),
                    child: child,
                  ),
                );
              },
              child: Text(
                key: ValueKey(activeCueIndex),
                activeCue.text,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontFamily: 'PoetsenOne',
                  fontStyle: FontStyle.italic,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        );
      },
    );
  }

  int _findActiveCueIndex(List<SubtitleCue> cues, Duration position) {
    for (int i = 0; i < cues.length; i++) {
      if (cues[i].isActiveAt(position)) {
        return i;
      }
    }
    return -1; // No active cue
  }
}

class _PronunciationRow extends StatelessWidget {
  final String label;
  final String word;
  final VoidCallback? onPlay;
  final Color accentColor;

  const _PronunciationRow({
    required this.label,
    required this.word,
    this.onPlay,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'PoetsenOne',
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            word,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 36,
              fontFamily: 'PoetsenOne',
              color: Colors.black87,
              height: 1.1,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: onPlay != null ? Colors.black.withOpacity(0) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.volume_up,
              color: onPlay != null ? Colors.black87 : Colors.black26,
              size: 28,
            ),
            onPressed: onPlay,
            tooltip: 'Play $label pronunciation',
            splashColor: Colors.black.withOpacity(0.1),
            highlightColor: Colors.black.withOpacity(0.05),
          ),
        ),
      ],
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  final Language language;
  final ValueChanged<Language>? onChanged;
  final Color accentColor;

  const _LanguageToggle({
    required this.language,
    required this.onChanged,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: accentColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LangChip(
            label: 'EN',
            selected: language == Language.en,
            onTap: () => onChanged?.call(Language.en),
            accentColor: accentColor,
          ),
          const SizedBox(width: 2),
          _LangChip(
            label: 'ES',
            selected: language == Language.es,
            onTap: () => onChanged?.call(Language.es),
            accentColor: accentColor,
          ),
        ],
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color accentColor;

  const _LangChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? accentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: accentColor.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'PoetsenOne',
            color: selected ? Colors.white : Colors.black.withOpacity(0.6),
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int index;
  final Color activeColor;
  final ValueChanged<int>? onDotTap;

  const _DotsIndicator({
    required this.count,
    required this.index,
    required this.activeColor,
    this.onDotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (i) {
        final isActive = i == index;
        final dot = AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 10 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? activeColor : Colors.black26,
            borderRadius: BorderRadius.circular(4),
          ),
        );
        return onDotTap == null
            ? dot
            : GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onDotTap!(i),
                child: dot,
              );
      }),
    );
  }
}




