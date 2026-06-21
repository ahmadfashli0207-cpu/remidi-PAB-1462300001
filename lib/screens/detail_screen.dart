import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/article.dart';
import 'detail_screen.dart';

class DetailScreen extends StatefulWidget {
  final Article article;
  const DetailScreen({super.key, required this.article});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;
  bool _loadingFav = false;
  final _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    if (_user == null) return;
    final doc = await FirebaseFirestore.instance
        .collection('favorites')
        .doc(_user!.uid)
        .collection('articles')
        .doc(widget.article.id.toString())
        .get();
    if (mounted) setState(() => _isFavorite = doc.exists);
  }

  Future<void> _toggleFavorite() async {
    if (_user == null) return;
    setState(() => _loadingFav = true);
    final docRef = FirebaseFirestore.instance
        .collection('favorites')
        .doc(_user!.uid)
        .collection('articles')
        .doc(widget.article.id.toString());

    if (_isFavorite) {
      await docRef.delete();
      if (mounted) setState(() { _isFavorite = false; _loadingFav = false; });
    } else {
      await docRef.set({
        'id': widget.article.id,
        'title': widget.article.title,
        'imageUrl': widget.article.imageUrl,
        'newsSite': widget.article.newsSite,
        'summary': widget.article.summary,
        'url': widget.article.url,
        'publishedAt': widget.article.publishedAt,
        'savedAt': FieldValue.serverTimestamp(),
      });
      if (mounted) setState(() { _isFavorite = true; _loadingFav = false; });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ditambahkan ke Favorit ❤️'), backgroundColor: Color(0xFF1E88E5)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFF0D1117),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              _loadingFav
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
                    )
                  : IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: _toggleFavorite,
                    ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: article.imageUrl.isNotEmpty
                  ? Image.network(
                      article.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFF161B27),
                        child: const Icon(Icons.broken_image, color: Color(0xFF8D9BAB), size: 80),
                      ),
                    )
                  : Container(color: const Color(0xFF161B27)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E88E5).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF1E88E5).withOpacity(0.4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.public, size: 12, color: Color(0xFF1E88E5)),
                            const SizedBox(width: 4),
                            Text(article.newsSite, style: const TextStyle(color: Color(0xFF1E88E5), fontSize: 12, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    article.title,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFF2A3040)),
                  const SizedBox(height: 16),
                  const Text('Ringkasan', style: TextStyle(color: Color(0xFF8D9BAB), fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Text(
                    article.summary.isEmpty ? 'Tidak ada ringkasan tersedia.' : article.summary,
                    style: const TextStyle(color: Color(0xFFCDD4E0), fontSize: 15, height: 1.65),
                  ),
                  const SizedBox(height: 28),
                  if (article.url.isNotEmpty)
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Baca Artikel Lengkap'),
                    ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
