import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق الاستثمار العقاري',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Almarai',
      ),
      // استخدام المسارات المسماة
      initialRoute: '/',
      routes: {
        '/': (context) => const InvestmentHomeScreen(),
        '/explore': (context) => const ExploreOptionsPage(),
        '/market': (context) =>   ViewMarketTrendsScreen(),
        '/invest': (context) => const StartInvestingPage(),
      },
    );
  }
}

// الشاشة الرئيسية
class InvestmentHomeScreen extends StatefulWidget {
  const InvestmentHomeScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentHomeScreen> createState() => _InvestmentHomeScreenState();
}

class _InvestmentHomeScreenState extends State<InvestmentHomeScreen> {
  RangeValues _currentRangeValues = const RangeValues(150000, 250000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'invest in the future of real estate',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        ' Discover opportunities',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        ' tailored to your needs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'property price ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            RangeSlider(
              values: _currentRangeValues,
              min: 100000,
              max: 300000,
              divisions: 10,
              activeColor: Colors.brown,
              inactiveColor: Colors.brown.withOpacity(0.2),
              labels: RangeLabels(
                '${_currentRangeValues.start.round()}',
                '${_currentRangeValues.end.round()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriceBox(_currentRangeValues.start),
                _buildPriceBox(_currentRangeValues.end),
              ],
            ),
            const SizedBox(height: 30),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _buildOptionButton(
                  'explore options',
                  Icons.search_outlined,
                  Colors.blue.shade200,
                  () {
                    Navigator.pushNamed(context, '/explore');
                  },
                ),
                _buildOptionButton(
                  'view market trends',
                  Icons.trending_up,
                  Colors.grey.shade200,
                  () {
                    Navigator.pushNamed(context, '/market');
                  },
                ),
                _buildOptionButton(
                  'start investing',
                  Icons.home_outlined,
                  Colors.amber.shade100,
                  () {
                    Navigator.pushNamed(context, '/invest');
                  },
                ),
                _buildOptionButton(
                  ' contact us',
                  Icons.phone,
                  Colors.blue.shade100,
                  () {
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String title, IconData iconData, Color bgColor, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(50),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBox(double price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        '\$${price.round()}',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

// شاشة استكشاف الخيارات
class ExploreOptionsPage extends StatefulWidget {
  const ExploreOptionsPage({super.key});

  @override
  State<ExploreOptionsPage> createState() => _ExploreOptionsPageState();
}

class _ExploreOptionsPageState extends State<ExploreOptionsPage> {
  String _selectedCity = 'Amman';
  
  final Map<String, double> cityPrices = {
    'Amman': 25901.0,
    'Irbid': 18000.0,
    'Aqaba': 22000.0,
    'Zarqa': 15000.0,
  };

  final Map<String, List<String>> cityImages = {
    'Amman': [
      'https://images.unsplash.com/photo-1570129477492-45c003edd2be',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
    ],
    'Irbid': [
      'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
      'https://images.unsplash.com/photo-1572120360610-d971b9b78827',
    ],
    'Aqaba': [
      'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
      'https://images.unsplash.com/photo-1599423300746-b62533397364',
    ],
    'Zarqa': [
      'https://images.unsplash.com/photo-1523217582562-09d0def993a6',
      'https://images.unsplash.com/photo-1551218808-94e220e084d2',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Options'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Explore Options',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 20),

            // Graph Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${cityPrices[_selectedCity]?.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: _selectedCity,
                    items: cityPrices.keys.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value!;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Properties Grid
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: cityImages[_selectedCity]!.map((imageUrl) {
                return _buildPropertyCard(imageUrl, _selectedCity);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyCard(String imageUrl, String city) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black.withOpacity(0.5),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      city,
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// شاشة عرض اتجاهات السوق
class ViewMarketTrendsScreen extends StatelessWidget {
   ViewMarketTrendsScreen({Key? key}) : super(key: key);

  // بيانات المبيعات لكل شهر (مثال)
  final List<double> monthlySales = [
    10, 12, 15, 14, 18, 20, 23, 25
  ]; 

  String getMarketPrediction() {
    double growthRate = (monthlySales.last - monthlySales.first) / monthlySales.first;
    if (growthRate > 0.2) {
      return "AI Prediction: Market is growing fast, expect a 10-15% price increase.";
    } else if (growthRate > 0.05) {
      return "AI Prediction: Moderate growth, 3-5% expected rise in prices.";
    } else {
      return "AI Prediction: Market is stable, no major changes expected.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Market trends', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'View Market Trends',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  barGroups: _getBarGroups(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'];
                          return SideTitleWidget(
                            
                            child: Text(months[value.toInt()], style: const TextStyle(fontSize: 12)),
                            meta:meta,
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatBox('Income', '20,000,000', Colors.green),
                _buildStatBox('Expenses', '5,000,000', Colors.red),
              ],
            ),
            const SizedBox(height: 20),
            // هنا تحليل الذكاء الصناعي
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.insights, color: Colors.blue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      getMarketPrediction(),
                      style: const TextStyle(fontSize: 16),
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

  List<BarChartGroupData> _getBarGroups() {
    return List.generate(monthlySales.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: monthlySales[index],
            color: Colors.brown,
            width: 15,
          ),
        ],
      );
    });
  }

  Widget _buildStatBox(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 3),
        ],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
 

class StartInvestingPage extends StatefulWidget {
  const StartInvestingPage({super.key});

  @override
  State<StartInvestingPage> createState() => _StartInvestingPageState();
}

class _StartInvestingPageState extends State<StartInvestingPage> {
  double _investmentAmount = 50000;
  String _selectedType = 'Residential';

  final List<String> _propertyTypes = [
    'Residential',
    'Commercial',
    'Land',
    'Industrial'
  ];

  String getRecommendation() {
    if (_investmentAmount < 50000) {
      return "We recommend starting with Residential properties.";
    } else if (_investmentAmount < 200000) {
      return "Consider Commercial or Residential investments.";
    } else if (_investmentAmount < 500000) {
      return "Land investments might offer long-term value.";
    } else {
      return "Explore Industrial projects for higher returns.";
    }
  }

  String getRiskLevel() {
    if (_investmentAmount < 50000) {
      return "Low Risk";
    } else if (_investmentAmount < 200000) {
      return "Moderate Risk";
    } else if (_investmentAmount < 500000) {
      return "High Risk";
    } else {
      return "Very High Risk";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Start Investing")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
              height: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              "Customize Your Investment",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Choose your preferences to start investing in the best property options available.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            const Text("Select Investment Amount"),
            Text("\$${_investmentAmount.toInt()}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _investmentAmount,
              min: 10000,
              max: 1000000,
              divisions: 99,
              label: _investmentAmount.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _investmentAmount = value;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text("Select Property Type"),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
              items: _propertyTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            const Text(
              "AI Recommendation:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              getRecommendation(),
              style: TextStyle(color: Colors.green.shade700),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            const Text(
              "Risk Level:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              getRiskLevel(),
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Investing \$${_investmentAmount.toInt()} in $_selectedType property."),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text("Start Now", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}