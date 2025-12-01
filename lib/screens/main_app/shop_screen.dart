import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../styles/app_colors.dart';
import '../../models/product_model.dart';
import '../../providers/products_provider.dart';
import '../../providers/favourites_provider.dart';
import '../../providers/cart_provider.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = productsProvider.products;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 16),
            child: Row(
              children: [
                const Text(
                  'Shop',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'Clothing',
                      style:
                          TextStyle(color: AppColors.textLight, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  _buildProductCard(products[index], context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product, BuildContext context) {
    final favouritesProvider = Provider.of<FavouritesProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final isFavourite = favouritesProvider.isFavourite(product.id);
// Цветные фоны из Figma (циклически для продуктов)
    final List<Color> backgroundColors = [
      Colors.pink[300]!,
      Colors.yellow[300]!,
      Colors.purple[300]!,
      Colors.red[300]!,
      Colors.orange[300]!,
      Colors.green[300]!,
    ];
    final bgColor =
        backgroundColors[int.parse(product.id) % backgroundColors.length];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(24)),
                      child: Image.asset(product.image, fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () => favouritesProvider.toggleFavourite(product),
                      child: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cartProvider.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} added')));
                  },
                  child: const Icon(Icons.shopping_bag_outlined,
                      color: AppColors.primary, size: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
