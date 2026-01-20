import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final book = Get.arguments as Map<String, dynamic>? ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text('إعارة الكتاب'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // تفاصيل الكتاب
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: book['image'] != null
                          ? Image.network(
                        book['image'],
                        fit: BoxFit.cover,
                      )
                          : Icon(Icons.book, size: 40),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book['title'] ?? 'غير معروف',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            book['author'] ?? 'غير معروف',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'سعر الإعارة: ${book['rentPrice'] ?? 0} ريال',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            // مدة الإعارة
            Text(
              'مدة الإعارة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                _buildDurationOption('7 أيام', '${(book['rentPrice'] ?? 0) * 0.5} ريال', 7),
                SizedBox(width: 10),
                _buildDurationOption(
                  '${book['rentDuration'] ?? 14} يوم',
                  '${book['rentPrice'] ?? 0} ريال',
                  book['rentDuration'] ?? 14,
                  selected: true,
                ),
                SizedBox(width: 10),
                _buildDurationOption('30 يوم', '${(book['rentPrice'] ?? 0) * 2} ريال', 30),
              ],
            ),

            SizedBox(height: 30),

            // تاريخ الاستلام
            Text(
              'تاريخ الاستلام',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // اختيار تاريخ
                    },
                    child: Text('تغيير التاريخ'),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // ملاحظات
            Text(
              'ملاحظات إضافية',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'أضف أي ملاحظات أو طلبات خاصة...',
                border: OutlineInputBorder(),
              ),
            ),

            Spacer(),

            // زر تأكيد الإعارة
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.offAllNamed('/home');
                  Get.snackbar(
                    'تمت الإعارة',
                    'تم تأكيد إعارة الكتاب بنجاح',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                icon: Icon(Icons.check_circle),
                label: Text(
                  'تأكيد إعارة الكتاب',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationOption(String days, String price, int duration, {bool selected = false}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.blue : Colors.grey[300]!,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
          color: selected ? Colors.blue[50] : Colors.white,
        ),
        child: Column(
          children: [
            Text(
              days,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.blue : Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              price,
              style: TextStyle(
                fontSize: 14,
                color: Colors.orange[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}