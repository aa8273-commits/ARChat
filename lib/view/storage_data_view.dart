import 'package:chatt/widgets/_switchTile_Storage.dart';
import 'package:chatt/widgets/sectionTitle_storage.dart';
import 'package:chatt/widgets/storageCard.dart';
import 'package:flutter/material.dart';

class StorageDataView extends StatefulWidget {
  const StorageDataView({super.key});

  static const String id = "/storageData";

  @override
  State<StorageDataView> createState() => _StorageDataViewState();
}

class _StorageDataViewState extends State<StorageDataView> {
  bool autoDownloadImages = true;
  bool autoDownloadVideos = false;
  bool autoDownloadFiles = true;

  double cacheSize = 126.4;
  double mediaSize = 358.7;
  double documentsSize = 42.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08131F),
      appBar: AppBar(
        backgroundColor: const Color(0xff0F2742),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "التخزين والبيانات",
          style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          sectionTitle("استخدام التخزين"),

          const SizedBox(height: 12),

          storageCard(
            Icons.photo,
            "الصور",
            "${mediaSize.toStringAsFixed(1)} MB",
          ),

          storageCard(
            Icons.description,
            "الملفات",
            "${documentsSize.toStringAsFixed(1)} MB",
          ),

          storageCard(
            Icons.cached,
            "الكاش",
            "${cacheSize.toStringAsFixed(1)} MB",
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                setState(() {
                  cacheSize = 0;
                });

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("تم مسح الكاش")));
              },
              icon: const Icon(Icons.delete_outline),
              label: const Text("مسح الكاش", style: TextStyle(fontSize: 17)),
            ),
          ),

          const SizedBox(height: 35),

          sectionTitle("التحميل التلقائي"),

          const SizedBox(height: 10),

          switchTile("تنزيل الصور تلقائياً", Icons.image, autoDownloadImages, (
            v,
          ) {
            setState(() {
              autoDownloadImages = v;
            });
          }),

          switchTile(
            "تنزيل الفيديوهات تلقائياً",
            Icons.video_collection,
            autoDownloadVideos,
            (v) {
              setState(() {
                autoDownloadVideos = v;
              });
            },
          ),

          switchTile(
            "تنزيل الملفات تلقائياً",
            Icons.insert_drive_file,
            autoDownloadFiles,
            (v) {
              setState(() {
                autoDownloadFiles = v;
              });
            },
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xff0F2742),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orangeAccent),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "إيقاف التحميل التلقائي يوفر استهلاك الإنترنت والمساحة.",
                    style: TextStyle(color: Colors.white70),
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
