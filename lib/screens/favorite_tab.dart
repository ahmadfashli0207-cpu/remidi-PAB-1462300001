import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/article.dart';
import 'detail_screen.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text('Favorit Saya', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0D1117),
      ),
      body: user == null
          ? const Center(child: Text('Silakan login terlebih dahulu', style: TextStyle(color: Color(0xFF8D9BAB))))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('favorites')
                  .doc(user.uid)
                  .collection('articles')
                  .orderBy('savedAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5))));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: 72, color: const Color(0xFF8D9BAB).withOpacity(0.5)),
                        const SizedBox(height: 16),
                        const Text('Belum ada artikel favorit', style: TextStyle(color: Color(0xFF8D9BAB), fontSize: 16)),
                        const SizedBox(height: 8),
                        const Text('Tekan ikon hati saat membaca artikel', style: TextStyle(color: Color(0xFF8D9BAB), fontSize: 13)),
                      ],
                    ),
                  );
                }
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    final article = Article(
                      id: data['id'] ?? 0,
                      title: data['title'] ?? '',
                      url: data['url'] ?? '',
                      imageUrl: data['imageUrl'] ?? '',
                      newsSite: data['newsSite'] ?? '',
                      summary: data['summary'] ?? '',
                      publishedAt: data['publishedAt'] ?? '',
                      updatedAt: '',
                    );
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => DetailScreen(article: article)),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF161B27),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF2A3040)),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: article.imageUrl.isNotEmpty
                                  ? Image.network(article.imageUrl, width: 80, height: 72, fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(width: 80, height: 72, color: const Color(0xFF252D3D), child: const Icon(Icons.image_not_supported, color: Color(0xFF8D9BAB))))
                                  : Container(width: 80, height: 72, color: const Color(0xFF252D3D)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(article.title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600), maxLines: 3, overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 6),
                                  Text(article.newsSite, style: const TextStyle(color: Color(0xFF1E88E5), fontSize: 11)),
                                ],
                              ),
                            ),
                            const Icon(Icons.favorite, color: Colors.red, size: 20),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
