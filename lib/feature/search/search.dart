// import 'package:ads_app/feature/create_New_Ad/cubit/cubit.dart';
// import 'package:ads_app/feature/create_New_Ad/widgets/Build_item.dart';
// import 'package:ads_app/feature/resources/colors/colors.dart';
// import 'package:flutter/material.dart';

// class SearchView extends StatefulWidget {
//   @override
//   _AdScreenState createState() => _AdScreenState();
// }

// class _AdScreenState extends State<SearchView> {
//   TextEditingController _searchController = TextEditingController();
//   List<Ad> _filteredAds = [];

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     String searchTerm = _searchController.text.trim();
//     AdCubit.get(context).searchAds(searchTerm).then((ads) {
//       setState(() {
//         _filteredAds = ads;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ads'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(color: AppColors.black),
//               ),
//               height: 50,
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _searchController,
//                         decoration: InputDecoration.collapsed(
//                           hintText: 'Search',
//                         ),
//                       ),
//                     ),
//                     Icon(
//                       Icons.search,
//                       color: Colors.red,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           _filteredAds.length != 0
//               ? Expanded(
//                   child: ListView.builder(
//                     itemCount: _filteredAds.length,
//                     itemBuilder: (context, index) {
//                       Ad ad = _filteredAds[index];
//                       return BuildItemCart(
//                           image: ad.imageUrl,
//                           describtion: ad.description,
//                           profuctName: ad.name);
//                     },
//                   ),
//                 )
//               : Text("there is no ads "),
//         ],
//       ),
//     );
//   }
// }

//////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FilterPage extends StatefulWidget {
//   @override
//   _FilterPageState createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {
//   String selectedCategory = 'Most Popular';
//   String selectedIndustry = 'Automotive';
//   int selectedInvestment = 2000;
//   List<DocumentSnapshot> searchResults = [];

//   final TextEditingController searchController = TextEditingController();

//   void applyFilters() async {
//     Query query = FirebaseFirestore.instance.collection('ads');

//     if (searchController.text.isNotEmpty) {
//       query = query
//           .where('title', isGreaterThanOrEqualTo: searchController.text)
//           .where('title',
//               isLessThanOrEqualTo: searchController.text + '\uf8ff');
//     }

//     if (selectedCategory.isNotEmpty) {
//       query = query.where('category', isEqualTo: selectedCategory);
//     }

//     if (selectedIndustry.isNotEmpty) {
//       query = query.where('industry', isEqualTo: selectedIndustry);
//     }

//     query = query.where('investment', isEqualTo: selectedInvestment);

//     query.get().then((querySnapshot) {
//       setState(() {
//         searchResults = querySnapshot.docs;
//       });
//     }).catchError((error) {
//       print("Error getting documents: $error");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             floating: true,
//             snap: true,
//             backgroundColor: Colors.white,
//             title: Text('Filter', style: TextStyle(color: Colors.black)),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: <Widget>[
//                   TextField(
//                     controller: searchController,
//                     decoration: InputDecoration(
//                       hintText: 'Search',
//                       prefixIcon: Icon(Icons.search, color: Colors.grey),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   FilterSection(
//                     title: 'By Category',
//                     options: ['Most Popular', 'Global', 'Best Performance'],
//                     selectedOption: selectedCategory,
//                     onSelectionChanged: (value) {
//                       setState(() {
//                         selectedCategory = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   FilterSection(
//                     title: 'By Industry',
//                     options: [
//                       'Automotive',
//                       'Health',
//                       'Travel',
//                       'Food',
//                       'Design',
//                       'Learning',
//                       'Beauty'
//                     ],
//                     selectedOption: selectedIndustry,
//                     onSelectionChanged: (value) {
//                       setState(() {
//                         selectedIndustry = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 30),
//                   Text(
//                     'How much you want to invest monthly?',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),
//                   Wrap(
//                     spacing: 8,
//                     children:
//                         [500, 1000, 1500, 2000, 2500, 3000, 4000].map((amount) {
//                       return FilterChip(
//                         label: Text('EGP $amount'),
//                         selected: selectedInvestment == amount,
//                         selectedColor: Colors.red,
//                         onSelected: (bool selected) {
//                           setState(() {
//                             selectedInvestment = amount;
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 40),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.red,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       onPressed: () {
//                         applyFilters();
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                         child: Text('Apply', style: TextStyle(fontSize: 18)),
//                       ),
//                     ),
//                   ),
//                   ...searchResults
//                       .map((doc) => ListTile(
//                             title: Text(doc['title']),
//                             subtitle: Text(doc['description']),
//                           ))
//                       .toList(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FilterSection extends StatelessWidget {
//   final String title;
//   final List<String> options;
//   final String selectedOption;
//   final Function(String) onSelectionChanged;

//   const FilterSection({
//     Key? key,
//     required this.title,
//     required this.options,
//     required this.selectedOption,
//     required this.onSelectionChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           title,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 8,
//           children: options.map((option) {
//             bool isSelected = selectedOption == option;
//             return ChoiceChip(
//               label: Text(option),
//               selected: isSelected,
//               selectedColor: Colors.red,
//               backgroundColor: isSelected ? Colors.red : Colors.white,
//               labelStyle: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black,
//               ),
//               onSelected: (bool selected) {
//                 onSelectionChanged(option);
//               },
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
////////////////////////////////
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedCategory = 'Most Popular';
  String selectedIndustry = 'Automotive';
  int selectedInvestment = 2000;
  List<DocumentSnapshot> searchResults = [];
  bool isLoading = false; // To handle loading state

  final TextEditingController searchController = TextEditingController();

  void applyFilters() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    Query query = FirebaseFirestore.instance.collection('ads');

    if (searchController.text.isNotEmpty) {
      query = query
          .where('title', isGreaterThanOrEqualTo: searchController.text)
          .where('title',
              isLessThanOrEqualTo: searchController.text + '\uf8ff');
    }

    if (selectedCategory.isNotEmpty) {
      query = query.where('category', isEqualTo: selectedCategory);
    }

    if (selectedIndustry.isNotEmpty) {
      query = query.where('industry', isEqualTo: selectedIndustry);
    }

    query = query.where('investment', isEqualTo: selectedInvestment);

    query.get().then((querySnapshot) {
      setState(() {
        searchResults = querySnapshot.docs;
        isLoading = false; // Hide loading indicator
      });
    }).catchError((error) {
      print("Error getting documents: $error");
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            title: Text('Filter', style: TextStyle(color: Colors.black)),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilterSection(
                    title: 'By Category',
                    options: ['Most Popular', 'Global', 'Best Performance'],
                    selectedOption: selectedCategory,
                    onSelectionChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  FilterSection(
                    title: 'By Industry',
                    options: [
                      'Automotive',
                      'Health',
                      'Travel',
                      'Food',
                      'Design',
                      'Learning',
                      'Beauty'
                    ],
                    selectedOption: selectedIndustry,
                    onSelectionChanged: (value) {
                      setState(() {
                        selectedIndustry = value;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'How much you want to invest monthly?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    children:
                        [500, 1000, 1500, 2000, 2500, 3000, 4000].map((amount) {
                      return FilterChip(
                        label: Text('EGP $amount'),
                        selected: selectedInvestment == amount,
                        selectedColor: Colors.red,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedInvestment = amount;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: applyFilters,
                    child: Text('Apply Filters'),
                  ),
                  SizedBox(height: 20),
                  if (isLoading)
                    CircularProgressIndicator()
                  else if (searchResults.isEmpty)
                    Text('No results found.'),
                  if (searchResults.isNotEmpty)
                    ...searchResults
                        .map((doc) => ListTile(
                              title: Text(doc['title']),
                              subtitle: Text(doc['description']),
                            ))
                        .toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterSection extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final Function(String) onSelectionChanged;

  const FilterSection({
    Key? key,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            bool isSelected = selectedOption == option;
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              selectedColor: Colors.red,
              backgroundColor: isSelected ? Colors.red : Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
              onSelected: (bool selected) {
                onSelectionChanged(option);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
