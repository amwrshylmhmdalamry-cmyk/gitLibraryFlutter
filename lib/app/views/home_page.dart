import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:libraryflutter1/app/views/login_page.dart';

// ✅ الصفحة الرئيسية لعرض الكتب

class BookStoreHomePage extends StatelessWidget {
  final List<Map<String, dynamic>> books = [
    {
      'id': 1,
      'title': 'الأب الغني والأب الفقير',
      'author': 'روبرت كيوساكي',
      'description': 'كتاب مالي يساعدك على فهم أساسيات الاستثمار',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/51wOXgjs+YL._SX331_BO1,204,203,200_.jpg',
      'category': 'مال وأعمال',
      'rating': 4.5,
      'price': 45.99,
      'rentPrice': 8.50,
      'rentDuration': 14,
      'isAvailable': true,
      'pages': 336,
    },
    {
      'id': 2,
      'title': 'قوة التفكير الإيجابي',
      'author': 'نورمان فينسنت بيل',
      'description': 'كيفية استخدام قوة التفكير الإيجابي لتحقيق النجاح',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/41d6N3k-8+L._SX331_BO1,204,203,200_.jpg',
      'category': 'تنمية بشرية',
      'rating': 4.3,
      'price': 32.50,
      'rentPrice': 5.99,
      'rentDuration': 10,
      'isAvailable': true,
      'pages': 280,
    },
    {
      'id': 3,
      'title': 'العادات السبع للناس الأكثر فعالية',
      'author': 'ستيفن كوفي',
      'description': '7 عادات تغير حياتك للأفضل',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/51WS36aA2BL._SX331_BO1,204,203,200_.jpg',
      'category': 'تنمية بشرية',
      'rating': 4.7,
      'price': 55.00,
      'rentPrice': 12.00,
      'rentDuration': 21,
      'isAvailable': true,
      'pages': 381,
    },
    {
      'id': 4,
      'title': 'قواعد العشق الأربعون',
      'author': 'إلف شفق',
      'description': 'رواية عن العشق والحب الإلهي',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/51LXk6cHHkL._SX331_BO1,204,203,200_.jpg',
      'category': 'روايات',
      'rating': 4.6,
      'price': 28.75,
      'rentPrice': 6.50,
      'rentDuration': 14,
      'isAvailable': true,
      'pages': 480,
    },
    {
      'id': 5,
      'title': 'التفكير السريع والبطيء',
      'author': 'دانيال كانيمان',
      'description': 'كيف يفكر العقل البشري ويتخذ القرارات',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/41J48GExMqL._SX331_BO1,204,203,200_.jpg',
      'category': 'علم النفس',
      'rating': 4.4,
      'price': 60.25,
      'rentPrice': 15.00,
      'rentDuration': 30,
      'isAvailable': true,
      'pages': 512,
    },
    {
      'id': 6,
      'title': 'القراءة الذكية',
      'author': 'ساجد العبدلي',
      'description': 'كيف تقرأ بذكاء وتستفيد أكثر',
      'image': 'https://www.neelwafurat.com/images/lb/abookstore/covers/normal/187/187775.gif',
      'category': 'تعليم',
      'rating': 4.2,
      'price': 25.00,
      'rentPrice': 4.99,
      'rentDuration': 7,
      'isAvailable': true,
      'pages': 220,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('📚 مكتبة الكتب'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // بحث
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // عربة الشراء
            },
          ),
          // ✅ أضف زر تسجيل الخروج
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.To(LoginPage());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // فلاتر سريعة
          Container(
            height: 60,
            color: Colors.grey[100],
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [
                _buildFilterChip('الكل', true),
                _buildFilterChip('البيع', false),
                _buildFilterChip('الإعارة', false),
                _buildFilterChip('الأكثر مبيعاً', false),
                _buildFilterChip('عروض خاصة', false),
              ],
            ),
          ),

          // عرض الكتب
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return _buildBookCard(book, context);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/login'); // الانتقال لتسجيل الدخول
        },
        child: Icon(Icons.person),
        backgroundColor: Colors.blue[800],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: Colors.blue[800],
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black,
        ),
        onSelected: (value) {
          // تغيير التصفية
        },
      ),
    );
  }

  Widget _buildBookCard(Map<String, dynamic> book, BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          _showBookDetails(context, book);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة الكتاب
              Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: book['image'],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.book,
                      size: 50,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 15),

              // معلومات الكتاب
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان
                    Text(
                      book['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // المؤلف
                    Text(
                      book['author'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),

                    SizedBox(height: 8),

                    // التقييم
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 5),
                        Text(
                          '${book['rating']}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            book['category'],
                            style: TextStyle(fontSize: 12, color: Colors.blue[800]),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // الأسعار
                    Row(
                      children: [
                        // سعر الشراء
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'شراء',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                '${book['price']} ريال',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // سعر الإعارة
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'إعارة',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                '${book['rentPrice']} ريال',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[700],
                                ),
                              ),
                              Text(
                                '${book['rentDuration']} يوم',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // أزرار الشراء والإعارة
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showPaymentOptions(context, book, 'شراء');
                            },
                            icon: Icon(Icons.shopping_cart, size: 18),
                            label: Text('شراء'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),

                        SizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.toNamed('/rent', arguments: book);
                            },
                            icon: Icon(Icons.library_books, size: 18),
                            label: Text('إعارة'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[600],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBookDetails(BuildContext context, Map<String, dynamic> book) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // صورة كبيرة
                Center(
                  child: Container(
                    width: 200,
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: book['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  book['title'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'تأليف: ${book['author']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  book['description'],
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 15),

                Divider(),

                Row(
                  children: [
                    Icon(Icons.menu_book, color: Colors.blue),
                    SizedBox(width: 10),
                    Text('${book['pages']} صفحة'),

                    Spacer(),

                    Icon(Icons.category, color: Colors.blue),
                    SizedBox(width: 10),
                    Text(book['category']),
                  ],
                ),

                SizedBox(height: 20),

                // زر إغلاق
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('إغلاق'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPaymentOptions(BuildContext context, Map<String, dynamic> book, String type) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$type الكتاب'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('الكتاب: ${book['title']}'),
              SizedBox(height: 10),
              Text('المبلغ: ${type == 'شراء' ? book['price'] : book['rentPrice']} ريال'),
              SizedBox(height: 20),
              Text('اختر طريقة الدفع:', style: TextStyle(fontWeight: FontWeight.bold)),

              SizedBox(height: 10),

              // طرق الدفع
              _paymentMethod('بطاقة ائتمان', Icons.credit_card),
              _paymentMethod('حوالة بنكية', Icons.account_balance),
              _paymentMethod('الدفع عند الاستلام', Icons.delivery_dining),
              _paymentMethod('محفظة إلكترونية', Icons.wallet),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Get.snackbar(
                  'تم بنجاح',
                  'تم تأكيد عملية ال$type',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              child: Text('تأكيد الدفع'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _paymentMethod(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Radio(
        value: title,
        groupValue: 'credit_card',
        onChanged: (value) {},
      ),
    );
  }
}

extension on GetInterface {
  void To(LoginPage loginPage) {}
}