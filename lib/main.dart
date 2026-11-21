import 'package:flutter/material.dart';

void main() => runApp(const TcDarkApp());

class TcDarkApp extends StatefulWidget {
  const TcDarkApp({super.key});
  @override
  State<TcDarkApp> createState() => _TcDarkAppState();
}

class _TcDarkAppState extends State<TcDarkApp> {
  bool french = true;
  int page = 0;
  String search = '';
  static const bg = Color(0xFF090A0F);
  static const panel = Color(0xFF151720);
  static const red = Color(0xFFE53945);
  String tr(String fr, String en) => french ? fr : en;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TC DARK',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: red, brightness: Brightness.dark),
        cardTheme: const CardTheme(color: panel, elevation: 0),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: bg,
          title: const Row(children: [Icon(Icons.bolt, color: red), SizedBox(width: 8), Text('TC DARK', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5))]),
          actions: [IconButton(onPressed: () => setState(() => french = !french), icon: const Icon(Icons.language)), const Padding(padding: EdgeInsets.only(right: 16), child: Icon(Icons.circle, color: Colors.greenAccent, size: 10))],
        ),
        body: IndexedStack(index: page, children: [_dashboard(), _modules(), _studio(), _settings()]),
        bottomNavigationBar: NavigationBar(
          backgroundColor: panel, indicatorColor: red.withOpacity(.18), selectedIndex: page,
          onDestinationSelected: (v) => setState(() => page = v),
          destinations: [
            NavigationDestination(icon: const Icon(Icons.dashboard_outlined), selectedIcon: const Icon(Icons.dashboard), label: tr('Accueil', 'Home')),
            NavigationDestination(icon: const Icon(Icons.grid_view), label: tr('Modules', 'Modules')),
            NavigationDestination(icon: const Icon(Icons.auto_awesome), label: tr('Studio', 'Studio')),
            NavigationDestination(icon: const Icon(Icons.settings_outlined), label: tr('Réglages', 'Settings')),
          ],
        ),
      ),
    );
  }

  Widget _dashboard() => ListView(padding: const EdgeInsets.all(18), children: [
    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(22), gradient: const LinearGradient(colors: [Color(0xFF35141B), Color(0xFF171923)], begin: Alignment.topLeft, end: Alignment.bottomRight), border: Border.all(color: red.withOpacity(.35))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('ONE STATE • COMPANION', style: TextStyle(color: Colors.white60, letterSpacing: 1.4, fontSize: 11)),
        const SizedBox(height: 10), const Text('TC DARK PANEL', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
        const SizedBox(height: 8), Text(tr('Ton espace de contrôle et tes outils de jeu, réunis au même endroit.', 'Your gaming companion and useful tools in one place.'), style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 18), Wrap(spacing: 8, children: [_tag(tr('Mode compagnon', 'Companion mode')), _tag('v1.0.0')]),
      ]),
    ),
    const SizedBox(height: 22), Text(tr('Accès rapide', 'Quick access'), style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
    const SizedBox(height: 12),
    GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.45, children: [
      _quick(Icons.tune, tr('Configuration', 'Configuration'), tr('Préférences locales', 'Local preferences'), () => setState(() => page = 1)),
      _quick(Icons.groups, tr('Factions', 'Factions'), tr('Catalogue et notes', 'Catalog and notes'), () => setState(() => page = 2)),
      _quick(Icons.menu_book, tr('Guide', 'Guide'), tr('Conseils de jeu', 'Game tips'), () => setState(() => page = 1)),
      _quick(Icons.info_outline, tr('À propos', 'About'), 'TC DARK', () => setState(() => page = 3)),
    ]),
    const SizedBox(height: 18),
    _notice(tr('Information', 'Notice'), tr('Cette application est un compagnon indépendant. Elle ne modifie pas One State et ne fournit pas de triche, de visée automatique ou de contournement anti-triche.', 'This is an independent companion app. It does not modify One State or provide cheats, auto-aim, or anti-cheat bypasses.')),
  ]);

  Widget _modules() {
    final items = [
      (Icons.speed, tr('Optimisation', 'Optimization'), tr('Conseils pour les performances du téléphone.', 'Tips for phone performance.')),
      (Icons.sports_esports, tr('Guide de jeu', 'Game guide'), tr('Notes et stratégies personnelles.', 'Personal notes and strategies.')),
      (Icons.groups, tr('Factions', 'Factions'), tr('Organise les informations de ton groupe.', 'Organize your group information.')),
      (Icons.checklist, tr('Liste de tâches', 'Task list'), tr('Garde une trace de tes objectifs.', 'Track your goals.')),
      (Icons.palette, tr('Thèmes', 'Themes'), tr('Interface sombre et accent rouge.', 'Dark interface with red accent.')),
    ];
    final filtered = items.where((e) => e.$2.toLowerCase().contains(search.toLowerCase())).toList();
    return ListView(padding: const EdgeInsets.all(18), children: [
      Text(tr('Modules', 'Modules'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 14),
      TextField(onChanged: (v) => setState(() => search = v), decoration: InputDecoration(hintText: tr('Rechercher un module...', 'Search modules...'), prefixIcon: const Icon(Icons.search), filled: true, fillColor: panel, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
      const SizedBox(height: 12),
      ...filtered.map((e) => Card(child: ListTile(leading: CircleAvatar(backgroundColor: red.withOpacity(.15), child: Icon(e.$1, color: red)), title: Text(e.$2, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(e.$3), trailing: const Icon(Icons.chevron_right), onTap: () => _message(e.$2, e.$3)))),
    ]);
  }

  Widget _studio() => ListView(padding: const EdgeInsets.all(18), children: [
    Text(tr('Studio personnel', 'Personal studio'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 8), Text(tr('Prépare tes notes, tes objectifs et les informations de ton équipe.', 'Prepare notes, goals, and team information.')),
    const SizedBox(height: 18), _notice(tr('Factions et équipe', 'Factions and team'), tr('Utilise cet espace pour noter les rôles, les règles et les contacts de ton groupe.', 'Use this space to note your group roles, rules, and contacts.')),
    const SizedBox(height: 12),
    _quick(Icons.edit_note, tr('Notes', 'Notes'), tr('Créer des notes de session', 'Create session notes'), () => _message(tr('Notes', 'Notes'), tr('Le bloc-notes sera ajouté dans une prochaine version.', 'A notes editor can be added in a future version.'))),
    const SizedBox(height: 12),
    _quick(Icons.flag, tr('Objectifs', 'Goals'), tr('Planifier ta prochaine session', 'Plan your next session'), () => _message(tr('Objectifs', 'Goals'), tr('Le suivi des objectifs sera ajouté dans une prochaine version.', 'Goal tracking can be added in a future version.'))),
  ]);

  Widget _settings() => ListView(padding: const EdgeInsets.all(18), children: [
    Text(tr('Réglages', 'Settings'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    const SizedBox(height: 12),
    Card(child: SwitchListTile(value: french, onChanged: (v) => setState(() => french = v), title: Text(tr('Langue française', 'French language')), subtitle: Text(french ? 'Français' : 'English'), secondary: const Icon(Icons.language, color: red))),
    Card(child: const ListTile(leading: Icon(Icons.info_outline, color: red), title: Text('TC DARK'), subtitle: Text('Version 1.0.0 • One State Companion'))),
    const SizedBox(height: 12),
    _notice(tr('Compatibilité', 'Compatibility'), tr('Application compagnon indépendante. Les fonctions affichées sont locales et ne se connectent pas aux serveurs du jeu.', 'Independent companion app. Displayed features are local and do not connect to game servers.')),
  ]);

  Widget _tag(String label) => Container(padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7), decoration: BoxDecoration(color: Colors.white.withOpacity(.08), borderRadius: BorderRadius.circular(30)), child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)));

  Widget _quick(IconData icon, String title, String subtitle, VoidCallback onTap) => Card(
    child: InkWell(borderRadius: BorderRadius.circular(16), onTap: onTap, child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: red, size: 25), const SizedBox(height: 9), Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 3),
      Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 11), maxLines: 2, overflow: TextOverflow.ellipsis),
    ]))),
  );

  Widget _notice(String title, String body) => Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [const Icon(Icons.info_outline, color: red, size: 18), const SizedBox(width: 8), Text(title, style: const TextStyle(fontWeight: FontWeight.bold))]),
    const SizedBox(height: 7), Text(body, style: const TextStyle(color: Colors.white70, height: 1.4)),
  ]));

  void _message(String title, String body) => showDialog(context: context, builder: (_) => AlertDialog(backgroundColor: panel, title: Text(title), content: Text(body), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))]));
}
