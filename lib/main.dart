import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TakashiMurah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
}
}

class TopBarButton extends StatelessWidget {
  final String label;
  const TopBarButton(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(label),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentProductIndex = 0;
  String? selectedPrinterBrand;
  String? selectedPrinterSeries;
  String? selectedPrinterModel;
  bool showSerialSearch = false;

  final List<ProductModel> products = [
    ProductModel(
      image: 'images/rideriama_pro.png',
      title: 'Rideriama Pro 2000',
      code: '(HP-C2P04AE)',
      price: '\$1100.49',
    ),
    ProductModel(
      image: 'images/piaggoi.png',
      title: 'Piaggoi 3000',
      code: '(C2P04AE)',
      price: '\$999.45',
    ),
    ProductModel(
      image: 'images/enfielding.png',
      title: 'Enfielding 4000',
      code: '(HP-C2P04AE)',
      price: '\$599.99',
    ),
  ];

  void _nextProduct() {
    if (_currentProductIndex < products.length - 3) {
      setState(() {
        _currentProductIndex++;
      });
    }
  }

  void _previousProduct() {
    if (_currentProductIndex > 0) {
      setState(() {
        _currentProductIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopInfoBar(),
            const LogoSearchSection(),
            const NavigationBar(),
            HeroSection(
              showSerialSearch: showSerialSearch,
              onSearchTypeChanged: (bool value) {
                setState(() {
                  showSerialSearch = value;
                });
              },
              selectedPrinterBrand: selectedPrinterBrand,
              selectedPrinterSeries: selectedPrinterSeries,
              selectedPrinterModel: selectedPrinterModel,
              onBrandChanged: (String? value) {
                setState(() {
                  selectedPrinterBrand = value;
                  selectedPrinterSeries = null;
                  selectedPrinterModel = null;
                });
              },
              onSeriesChanged: (String? value) {
                setState(() {
                  selectedPrinterSeries = value;
                  selectedPrinterModel = null;
                });
              },
              onModelChanged: (String? value) {
                setState(() {
                  selectedPrinterModel = value;
                });
              },
            ),
            FeaturedProducts(
              products: products,
              currentIndex: _currentProductIndex,
              onNext: _nextProduct,
              onPrevious: _previousProduct,
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

// Models remain the same
class ProductModel {
  final String image;
  final String title;
  final String code;
  final String price;

  ProductModel({
    required this.image,
    required this.title,
    required this.code,
    required this.price,
  });
}

class TopInfoBar extends StatelessWidget {
  const TopInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 240, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              TopBarButton('Franchise Opportunities'),
              SizedBox(width: 16),
              TopBarButton('Help'),
              SizedBox(width: 16),
              TopBarButton('Feedback'),
            ],
          ),
          Row(
            children: [
              Text('hello@email.com',
                  style: TextStyle(color: Colors.grey[700])),
              const SizedBox(width: 16),
              Text('0800 022 2 022',
                  style: TextStyle(color: Colors.grey[700])),
            ],
          ),
        ],
      ),
    );
  }
}

class LogoSearchSection extends StatelessWidget {
  const LogoSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 240, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('images/logo.png', height: 40),
              const SizedBox(width: 12),
              const Text(
                'CARTRIDGE KINGS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'SEARCH',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('CART (1)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
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

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 240),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              NavButton('HOME', isSelected: true),
              NavButton('MOTOR BRAND'),
              NavButton('MOTOR SERIES'),
              NavButton('CONTACT US'),
              NavButton('LOGIN / REGISTER'),
            ],
          ),
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String text;
  final bool isSelected;

  const NavButton(this.text, {super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          backgroundColor: isSelected ? Colors.blue[700] : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final bool showSerialSearch;
  final Function(bool) onSearchTypeChanged;
  final String? selectedPrinterBrand;
  final String? selectedPrinterSeries;
  final String? selectedPrinterModel;
  final Function(String?) onBrandChanged;
  final Function(String?) onSeriesChanged;
  final Function(String?) onModelChanged;

  const HeroSection({
    super.key,
    required this.showSerialSearch,
    required this.onSearchTypeChanged,
    required this.selectedPrinterBrand,
    required this.selectedPrinterSeries,
    required this.selectedPrinterModel,
    required this.onBrandChanged,
    required this.onSeriesChanged,
    required this.onModelChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/hero-background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'FIND THE RIGHT MOTOR FOR YOUR GARAGE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: 800,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SearchTab(
                          '3-Step Easy Search®',
                          isSelected: !showSerialSearch,
                          onTap: () => onSearchTypeChanged(false),
                        ),
                      ),
                      Expanded(
                        child: SearchTab(
                          'Search by Serial Number',
                          isSelected: showSerialSearch,
                          onTap: () => onSearchTypeChanged(true),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: !showSerialSearch
                        ? Row(
                            children: [
                              Expanded(
                                child: SearchDropdown(
                                  '1. Motor Brand',
                                  value: selectedPrinterBrand,
                                  onChanged: onBrandChanged,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SearchDropdown(
                                  '2. Motor Series',
                                  value: selectedPrinterSeries,
                                  enabled: selectedPrinterBrand != null,
                                  onChanged: onSeriesChanged,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SearchDropdown(
                                  '3. Motor Model',
                                  value: selectedPrinterModel,
                                  enabled: selectedPrinterSeries != null,
                                  onChanged: onModelChanged,
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                ),
                                child: const Text('FIND MOTOR'),
                              ),
                            ],
                          )
                        : TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter Serial Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SearchTab(
    this.text, {
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.blue : Colors.grey[300]!,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SearchDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final bool enabled;
  final Function(String?)? onChanged;

  const SearchDropdown(
    this.hint, {
    super.key,
    this.value,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(hint),
        ),
        isExpanded: true,
        underline: const SizedBox(),
        onChanged: enabled ? onChanged : null,
        items: const [
          DropdownMenuItem(value: 'hp', child: Text('HP')),
          DropdownMenuItem(value: 'canon', child: Text('Canon')),
          DropdownMenuItem(value: 'epson', child: Text('Epson')),
        ],
      ),
    );
  }
}

class FeaturedProducts extends StatelessWidget {
  final List<ProductModel> products;
  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const FeaturedProducts({
    super.key,
    required this.products,
    required this.currentIndex,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 240),
      child: Column(
        children: [
          const Text(
            'FEATURED PRODUCTS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = currentIndex;
                      i < currentIndex + 3 && i < products.length;
                      i++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ProductCard(product: products[i]),
                      ),
                    ),
                ],
              ),
              if (currentIndex > 0)
                Positioned(
                  left: -20,
                  child: NavigationArrow(
                    Icons.chevron_left,
                    onPressed: onPrevious,
                  ),
                ),
              if (currentIndex < products.length - 3)
                Positioned(
                  right: -20,
                  child: NavigationArrow(
                    Icons.chevron_right,
                    onPressed: onNext,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              product.image,
              height: 160,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              product.code,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (product.price != product.price)
                  Text(
                    '\$${product.price}',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                const SizedBox(width: 8),
                Text(
                  product.price,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('ADD TO CART'),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const NavigationArrow(
    this.icon, {
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: Colors.orange,
        iconSize: 24,
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(horizontal: 240, vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '© 2024 Cartridge Kings. All rights reserved.',
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              FooterLink('Privacy Policy'),
              const SizedBox(width: 24),
              FooterLink('Terms of Service'),
              const SizedBox(width: 24),
              FooterLink('Contact Us'),
            ],
          ),
        ],
      ),
    );
  }
}

class FooterLink extends StatelessWidget {
  final String text;

  const FooterLink(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[400],
        ),
      ),
    );
  }
}