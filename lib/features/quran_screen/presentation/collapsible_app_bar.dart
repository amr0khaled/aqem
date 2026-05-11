import 'package:flutter/material.dart';

/// A collapsible green AppBar that shrinks when scrolling down
/// and expands when scrolling up, using SliverAppBar.
///
/// This component displays:
/// - Leading icon (bookmark) on the left
/// - Centered Arabic title and subtitle
/// - Right side: speaker icon and back arrow
///
/// Usage: Place inside a CustomScrollView's slivers list.
class CollapsibleAppBar extends StatelessWidget {
  /// The primary title text displayed in the center of the app bar.
  final String title;

  /// The secondary subtitle text displayed below the title.
  final String subtitle;

  /// Callback when the bookmark icon is pressed.
  final VoidCallback? onBookmarkPressed;

  /// Callback when the speaker/volume icon is pressed.
  final VoidCallback? onSpeakerPressed;

  /// Callback when the back arrow is pressed.
  final VoidCallback? onBackPressed;

  /// The expanded height of the app bar when fully expanded.
  final double expandedHeight;

  /// The background color of the app bar. Defaults to a rich forest green.
  final Color backgroundColor;

  const CollapsibleAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBookmarkPressed,
    this.onSpeakerPressed,
    this.onBackPressed,
    this.expandedHeight = 200.0,
    this.backgroundColor = const Color(0xFF2E7D32),
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: false,
      pinned: true,
      elevation: 4.0,
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: const Icon(Icons.bookmark_outline, color: Colors.white),
        onPressed: onBookmarkPressed,
        tooltip: 'Bookmark',
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.volume_up_outlined, color: Colors.white),
          onPressed: onSpeakerPressed,
          tooltip: 'Audio',
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward, color: Colors.white),
          onPressed: onBackPressed ?? () => Navigator.maybePop(context),
          tooltip: 'Back',
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate the current expansion percentage (0.0 = collapsed, 1.0 = fully expanded)
          final double currentHeight = constraints.biggest.height;
          final double collapsePercent = ((currentHeight - kToolbarHeight) /
                  (expandedHeight - kToolbarHeight))
              .clamp(0.0, 1.0);

          return FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsetsDirectional.only(
              start: 56.0,
              bottom: 16.0 + (1.0 - collapsePercent) * 4.0,
              end: 56.0,
            ),
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: collapsePercent > 0.3 ? 1.0 : 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0 + collapsePercent * 4.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (collapsePercent > 0.5)
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 150),
                      opacity: ((collapsePercent - 0.5) * 2).clamp(0.0, 1.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 12.0 + collapsePercent * 2.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            background: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      backgroundColor.withValues(alpha: 0.8),
                      backgroundColor,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
