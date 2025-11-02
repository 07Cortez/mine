import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skincare_shop/models/product.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedCategory = 'All'; // Default category filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skincare & Cosmetics'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                _selectedCategory = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'All',
                child: Text('All Products'),
              ),
              const PopupMenuItem<String>(
                value: 'Skincare',
                child: Text('Skincare'),
              ),
              const PopupMenuItem<String>(
                value: 'Cosmetics',
                child: Text('Cosmetics'),
              ),
              const PopupMenuItem<String>(
                value: 'Fragrance',
                child: Text('Fragrance'),
              ),
              // Add more categories as needed
            ],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.filter_list),
                  Text(_selectedCategory),
                ],
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _selectedCategory == 'All'
            ? _firestore.collection('products').snapshots()
            : _firestore
                .collection('products')
                .where('category', isEqualTo: _selectedCategory)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!.docs.map((doc) => Product.fromFirestore(doc)).toList();

          if (products.isEmpty) {
            return const Center(child: Text('No products found in this category.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.75, // Adjust as needed
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement adding new product functionality (e.g., navigate to AddProductScreen)
          _addProductDummyData(); // For testing: add some dummy data
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Dummy product added (check Firestore)!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // --- Dummy Data Function (for testing) ---
  void _addProductDummyData() {
    _firestore.collection('products').add(
      Product(
        id: '', // Firestore will assign an ID
        name: 'Rose & Vanilla Eau de Parfum',
        description: 'A captivating blend of delicate rose and warm vanilla notes.',
        price: 59.99,
        imageUrl: 'https://images.unsplash.com/photo-1594247514104-586b663b6d21?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Example image URL
        category: 'Fragrance',
      ).toFirestore(),
    );
     _firestore.collection('products').add(
      Product(
        id: '', // Firestore will assign an ID
        name: 'Hydrating Facial Serum',
        description: 'Deeply moisturizes and rejuvenates your skin for a radiant glow.',
        price: 34.50,
        imageUrl: 'https://images.unsplash.com/photo-1629198688000-71f23e794411?q=80&w=1999&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        category: 'Skincare',
      ).toFirestore(),
    );
     _firestore.collection('products').add(
      Product(
        id: '', // Firestore will assign an ID
        name: 'Velvet Matte Lipstick - Ruby Red',
        description: 'Achieve a bold, long-lasting matte finish with intense color.',
        price: 19.00,
        imageUrl: 'https://images.unsplash.com/photo-1622037326815-5c1a7b4f53f9?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        category: 'Cosmetics',
      ).toFirestore(),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: product.imageUrl.isNotEmpty
                  ? Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.broken_image)),
                    )
                  : Center(
                      child: Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  product.description,
                  style: TextStyle(color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  // TODO: Implement add to cart functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} added to cart! (dummy)')),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
