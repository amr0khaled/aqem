import 'package:aqem/features/home_screen/nav_card.dart';
import 'package:flutter/material.dart';

class NavCards extends StatelessWidget {
  const NavCards({super.key});

  Color _secondaryIconColor(BuildContext context) {
    return Theme.of(context).colorScheme.onTertiaryFixedVariant;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: .rtl,
      child: ListView(
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: NavCard(
                  iconData: Icons.book,
                  title: 'المصحف',
                  subtitle: 'قراءة القرآن الكريم',
                  onCardTap: () {},
                ),
              ),
              Expanded(
                child: NavCard(
                  iconData: Icons.access_time_outlined,
                  title: 'الآذان',
                  subtitle: 'مواقيت الصلاة',
                  iconBackgroundColor: _secondaryIconColor(
                    context,
                  ), //onInverseSurface
                  onCardTap: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: NavCard(
                  iconData: Icons.front_hand_outlined,
                  title: 'الأدعية والأذكار',
                  subtitle: 'حصن المسلم',
                  onCardTap: () {},
                ),
              ),
              Expanded(
                child: NavCard(
                  iconData: Icons.notifications_none_outlined,
                  title: 'تذكيرات',
                  subtitle: 'تنبيهات يومية',
                  iconBackgroundColor: _secondaryIconColor(
                    context,
                  ), //onInverseSurface
                  onCardTap: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: NavCard(
                  iconData: Icons.headset_outlined,
                  title: 'تعليم القرآن',
                  subtitle: 'دروس وتلاوات',
                  onCardTap: () {},
                ),
              ),
              Expanded(
                child: NavCard(
                  iconData: Icons.location_on_outlined,
                  title: 'المساجد',
                  subtitle: 'أقرب المساجد',
                  iconBackgroundColor: _secondaryIconColor(
                    context,
                  ), //onInverseSurface
                  onCardTap: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          NavCard(
            iconData: Icons.circle_outlined,
            title: 'المسبحة',
            subtitle: 'عداد التسبيح',
            onCardTap: () {},
          ),
          SizedBox(height: 12),
          NavCard(
            iconData: Icons.assistant_navigation,
            title: 'اتجاه القبلة',
            subtitle: 'تحديد اتجاه القبلة',
            iconBackgroundColor: _secondaryIconColor(
              context,
            ), //onInverseSurface
            onCardTap: () {},
          ),
        ],
      ),
    );
  }
}
