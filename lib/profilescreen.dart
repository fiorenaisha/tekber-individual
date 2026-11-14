import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =============================================================
// 1. PALET WARNA
// =============================================================
const Color kBackground = Color(0xFFFBFAF6);
const Color kInk = Color(0xFF1C1C1E);
const Color kInkSoft = Color(0xFF6B6B70);
const Color kBlue = Color(0xFF5B7FFF);
const Color kLavender = Color(0xFFB9A7FF);
const Color kBlueSoft = Color(0xFFD9E3FF);
const Color kPeach = Color(0xFFFFD8C8);
const Color kMint = Color(0xFFD7EFD0);
const Color kSun = Color(0xFFFBEFA8);

const double kBorderWidth = 1.8;

// =============================================================
// 2. DATA PROFIL
// =============================================================
const String kName = 'Fiorena Aisha M';
const String kNrp = '5026241089';
const String kUniversity = 'Institut Teknologi Sepuluh Nopember';
const String kMajor = 'Information Systems';
const String kEmail = 'fiorena070307@gmail.com';
const String kGithub = 'github.com/fiorenaisha';

// Diambil dari bagian Skills di CV.
const List<String> kSkills = [
  'Java',
  'Python',
  'SQL',
  'HTML/CSS',
  'BPMN',
  'ProcessMaker',
  'Odoo',
  'SAP',
  'ESB',
  'Power BI',
];

const List<IconData> kNavIcons = [
  Icons.home_outlined,
  Icons.school_outlined,
  Icons.work_outline_rounded,
  Icons.bolt_outlined,
  Icons.mail_outline_rounded,
];

// =============================================================
// 3. PROFILE SCREEN
// =============================================================
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _controller = ScrollController();
  final List<GlobalKey> _keys = List.generate(5, (_) => GlobalKey());

  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;

    int current = 0;

    for (int i = 0; i < _keys.length; i++) {
      final ctx = _keys[i].currentContext;
      if (ctx == null) continue;

      final object = ctx.findRenderObject();
      if (object is! RenderBox) continue;

      final top = object.localToGlobal(Offset.zero).dy;
      if (top <= 220) current = i;
    }

    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 8) {
      current = _keys.length - 1;
    }

    if (current != _selected) {
      setState(() => _selected = current);
    }
  }

  void _goTo(int index) {
    setState(() => _selected = index);

    final ctx = _keys[index].currentContext;
    if (ctx == null) return;

    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      alignment: 0.02,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: kBackground,
      body: Stack(
        children: [
          const _GradientBackground(),

          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              controller: _controller,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KeyedSubtree(key: _keys[0], child: const _HeroSection()),
                  const SizedBox(height: 32),

                  KeyedSubtree(key: _keys[1], child: const _EducationSection()),
                  const SizedBox(height: 32),

                  KeyedSubtree(
                    key: _keys[2],
                    child: const _ExperienceSection(),
                  ),
                  const SizedBox(height: 32),

                  KeyedSubtree(key: _keys[3], child: const _SkillsSection()),
                  const SizedBox(height: 32),

                  KeyedSubtree(key: _keys[4], child: const _ContactSection()),
                ],
              ),
            ),
          ),

          Positioned(
            left: 28,
            right: 28,
            bottom: bottomInset + 16,
            child: _FloatingNavBar(
              icons: kNavIcons,
              selected: _selected,
              onTap: _goTo,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// 4. BACKGROUND
//    _Blob dihilangkan dan digabung di sini.
// =============================================================
class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: SizedBox.expand(
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: -140,
              left: -120,
              child: SizedBox(
                width: 420,
                height: 420,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0x805B7FFF), Color(0x005B7FFF)],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 380,
              right: -220,
              child: SizedBox(
                width: 440,
                height: 440,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0x59B9A7FF), Color(0x00B9A7FF)],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: -180,
              left: -120,
              child: SizedBox(
                width: 460,
                height: 460,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0x595B7FFF), Color(0x005B7FFF)],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// 5. HERO SECTION
//    _TopBar digabung di dalam _HeroSection.
// =============================================================
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TOP BAR
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, I'm $kName,",
                    style: TextStyle(
                      color: kInk,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Welcome to my portfolio',
                    style: TextStyle(color: kInkSoft, fontSize: 13),
                  ),
                ],
              ),
            ),

            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: kInk, width: kBorderWidth),
              ),
              child: const Icon(Icons.grid_view_rounded, color: kInk),
            ),
          ],
        ),

        const SizedBox(height: 24),

        const _ProfileCard(),

        const SizedBox(height: 28),

        const _SectionHeader('About Me', subtitle: 'A little about who I am'),

        const _OutlineBox(
          child: Text(
            'Penultimate Information Systems student with experience in '
            'partnership, sponsorship, and business development, alongside '
            'a strong interest in business process analysis and system '
            'improvement. I enjoy using data and technology to create '
            'effective solutions and meaningful impact.',
            style: TextStyle(color: kInkSoft, fontSize: 14, height: 1.6),
          ),
        ),

        const SizedBox(height: 28),

        const _SectionHeader('Overview', subtitle: 'My journey in numbers'),

        const _OverviewTiles(),
      ],
    );
  }
}

// =============================================================
// 6. PROFILE CARD
// =============================================================
class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return _OutlineBox(
      radius: 26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: kBlueSoft,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: kInk, width: kBorderWidth),
                ),
                child: Image.asset(
                  'assets/profile.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 44, color: kInk);
                  },
                ),
              ),

              const SizedBox(width: 16),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kName,
                      style: TextStyle(
                        color: kInk,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'NRP $kNrp',
                      style: TextStyle(
                        color: kInk,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Information Systems',
                      style: TextStyle(color: kInkSoft, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(height: 1, color: Color(0x33000000)),
          ),

          const Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _MetaItem(icon: Icons.school_outlined, text: 'ITS Surabaya'),
              _MetaItem(
                icon: Icons.menu_book_outlined,
                text: '3rd year student',
              ),
              _MetaItem(
                icon: Icons.location_on_outlined,
                text: 'Surabaya, Indonesia',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================
// 7. OVERVIEW
//    _StatTile digabung ke dalam _OverviewTiles.
//    Angka diambil dari CV: 3 medali perak internasional,
//    200+ siswa/mahasiswa yang diajar, 7 peran organisasi/kepanitiaan.
// =============================================================
class _OverviewTiles extends StatelessWidget {
  const _OverviewTiles();

  Widget _buildStatTile({
    required String value,
    required String label,
    required Color color,
    required IconData icon,
    bool big = false,
  }) {
    final valueText = Text(
      value,
      style: TextStyle(
        color: kInk,
        fontSize: big ? 48 : 24,
        fontWeight: FontWeight.w800,
        height: 1.1,
      ),
    );

    final labelText = Text(
      label,
      style: TextStyle(color: kInk, fontSize: big ? 14 : 12),
    );

    return _OutlineBox(
      color: color,
      padding: const EdgeInsets.all(16),
      child: big
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: _DashedIcon(icon, size: 44),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [valueText, labelText],
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [valueText, labelText],
                  ),
                ),
                _DashedIcon(icon, size: 30),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: _buildStatTile(
              value: '6', // baris 560
              label: 'Projects', // baris 561
              color: kBlueSoft, // baris 562
              icon: Icons.folder_outlined, // baris 563
              big: true,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  child: _buildStatTile(
                    value: '1', // baris 576
                    label: 'Internship', // baris 577
                    color: kSun, // baris 578
                    icon: Icons.work_outline_rounded, // baris 579
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: _buildStatTile(
                    value: '4', // baris 587
                    label: 'Teaching Roles', // baris 588
                    color: kMint, // baris 589
                    icon: Icons.menu_book_outlined, // baris 590
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// 8. EDUCATION SECTION
// =============================================================

class _EducationSection extends StatelessWidget {
  const _EducationSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader('Education', subtitle: 'My academic journey'),

        _OutlineBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _DashedIcon(Icons.account_balance_outlined, size: 50),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      kUniversity,
                      style: TextStyle(
                        color: kInk,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      kMajor,
                      style: TextStyle(color: kInkSoft, fontSize: 13),
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [_tag('2024 - Present', color: kBlueSoft)],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================
// 9. EXPERIENCE SECTION
//    3 pengalaman paling prestise dari CV.
// =============================================================
class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          'Experience',
          subtitle: 'Work, teaching, and leadership',
        ),

        _ExperienceCard(
          title: 'Business Analytics Intern',
          headerColor: kPeach,
          description:
              'Built an operational dashboard from ESB ERP data and turned '
              'its insights into training materials for Store Leaders.',
          metaIcon: Icons.local_cafe_outlined,
          metaText: 'Kancha Tea Hub • Jul - Aug 2026',
          tags: ['Internship', 'Power BI', 'ESB'],
        ),

        SizedBox(height: 14),

        _ExperienceCard(
          title: 'Teaching Assistant & Grader',
          headerColor: kBlueSoft,
          description:
              'Guided second-semester students in business process '
              'automation with ProcessMaker and assessed their practical '
              'work in the Business Process Management course.',
          metaIcon: Icons.school_outlined,
          metaText: 'ITS Information Systems • Feb - Jul 2026',
          tags: ['Teaching', 'BPM', 'ProcessMaker'],
        ),

        SizedBox(height: 14),

        _ExperienceCard(
          title: 'Business Development Staff',
          headerColor: kMint,
          description:
              'Identified partnership opportunities, managed sponsor '
              'relationships, and supported outreach and kits for '
              'GDGoC ITS 2025/2026.',
          metaIcon: Icons.groups_outlined,
          metaText: 'GDGoC ITS • Jan - Sep 2026',
          tags: ['Partnership', 'Sponsorship'],
        ),
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({
    required this.title,
    required this.headerColor,
    required this.description,
    required this.metaIcon,
    required this.metaText,
    required this.tags,
  });

  final String title;
  final Color headerColor;
  final String description;
  final IconData metaIcon;
  final String metaText;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: kInk, width: kBorderWidth),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: headerColor,
              border: const Border(
                bottom: BorderSide(color: kInk, width: kBorderWidth),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: kInk,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    color: kInkSoft,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 14),

                _MetaItem(icon: metaIcon, text: metaText),

                const SizedBox(height: 14),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [for (final tag in tags) _tag(tag)],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// 10. SKILLS SECTION
// =============================================================
class _SkillsSection extends StatelessWidget {
  const _SkillsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          'Skills & Expertise',
          subtitle: 'Tools and topics I work with',
        ),

        _OutlineBox(
          child: Wrap(
            spacing: 8,
            runSpacing: 10,
            children: [
              for (final skill in kSkills)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: kInk,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    skill,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================
// 11. CONTACT SECTION
// =============================================================
class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's Connect!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),

          SizedBox(height: 6),

          Text(
            'Tap a row to copy it.',
            style: TextStyle(color: Color(0xFFB8B8BE), fontSize: 13),
          ),

          SizedBox(height: 16),

          _ContactRow(icon: Icons.mail_outline_rounded, text: kEmail),

          SizedBox(height: 10),

          _ContactRow(icon: Icons.code_rounded, text: kGithub),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Copied: $text'),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(28, 0, 28, 110),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _copy(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: kInk),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),

              const Icon(Icons.copy_rounded, size: 18, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================
// 12. FLOATING NAVIGATION BAR
// =============================================================
class _FloatingNavBar extends StatelessWidget {
  const _FloatingNavBar({
    required this.icons,
    required this.selected,
    required this.onTap,
  });

  final List<IconData> icons;
  final int selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(34),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: 68,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: kInk.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(34),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < icons.length; i++)
                GestureDetector(
                  onTap: () => onTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == selected
                          ? kInk
                          : kInk.withValues(alpha: 0.50),
                    ),
                    child: Icon(icons[i], size: 22, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================
// 13. REUSABLE COMPONENTS
// =============================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: kInk,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),

          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                subtitle!,
                style: const TextStyle(color: kInkSoft, fontSize: 13),
              ),
            ),
        ],
      ),
    );
  }
}

class _OutlineBox extends StatelessWidget {
  const _OutlineBox({
    required this.child,
    this.color = Colors.white,
    this.radius = 22,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final Color color;
  final double radius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: kInk, width: kBorderWidth),
      ),
      child: child,
    );
  }
}

// _Tag diganti menjadi fungsi biasa, bukan class widget.
Widget _tag(String text, {Color color = const Color(0xFFEDEDED)}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kInk, width: 1.2),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: kInk,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _DashedIcon(icon, size: 30),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: kInkSoft, fontSize: 12)),
      ],
    );
  }
}

class _DashedIcon extends StatelessWidget {
  const _DashedIcon(this.icon, {this.size = 40});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DashedRRectPainter(radius: size * 0.3),
        child: Center(
          child: Icon(icon, size: size * 0.5, color: kInk),
        ),
      ),
    );
  }
}

// CustomPainter, bukan widget.
class _DashedRRectPainter extends CustomPainter {
  _DashedRRectPainter({required this.radius});

  final double radius;

  static const double _dash = 4;
  static const double _gap = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kInk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    for (final metric in path.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + _dash), paint);

        distance += _dash + _gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) {
    return oldDelegate.radius != radius;
  }
}
