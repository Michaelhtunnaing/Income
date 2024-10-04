import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:MM_TVPro/ads_change/adschange.dart';
import 'package:MM_TVPro/controller/movie_data_controller.dart';
import '../controller/ads_controller.dart';
import '../controller/football_highlight.dart';
import '../controller/football_live_controller.dart';
import '../controller/network_controller.dart';
import '../data_service/data_service.dart';
import '../ui/hightlight.dart';
import '../ui/home.dart';
import '../ui/movies.dart';
import '../ui/setting.dart';
import '../utils/constants.dart';
import 'helper_widgets.dart';

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({super.key});

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation>
    with WidgetsBindingObserver {
  final NetworkController _networkController = Get.find<NetworkController>();
  final AdsController adsController = Get.put(AdsController());
  final DataController dataController = Get.put(DataController());
  final DataService dataService = Get.find<DataService>();
  final HighlightController highlightController =
      Get.put(HighlightController());
  final MovieController movieController = Get.put(MovieController());

  final List<Widget> screens = [
    MyHome(),
    const MyHighlight(),
    MyMovie(),
    Setting()
  ];

  @override
  void initState() {
    AdsChange().showInterstital();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: Obx(() {
        final ConnectionStatus status = _networkController.status.value;
        if (status == ConnectionStatus.loading) {
          return _buildLoadingScreen("Network Checking");
        } else if (status == ConnectionStatus.connected) {
          if (_networkController.isLoading.value) {
            return _buildLoadingScreen("Data Fetching");
          }
          if (!_networkController.con.value) {
            return _buildAppStatus();
          }
          if (_networkController.uriversion.value != Utils.uiVersion) {
            final check = GetStorage().read('ui') ?? false;
            if (!check) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                _showAboutDialog();
              });
            }
          }
          return screens[_networkController.count.value];
        } else {
          return _buildErrorScreen();
        }
      }),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildLoadingScreen(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.prograssiveDots(
            color: const Color.fromARGB(255, 189, 113, 113),
            size: 100,
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/cell_tower.png', height: 100),
          const Text(
            "An error occurred, please retry the operation",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _networkController.checkConnectivity();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Please turn on your phone's internet or wifi",
                  style: TextStyle(fontSize: 20),
                ),
              ));
            },
            child: const Text(
              'Retry',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.3))
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[200]!,
            hoverColor: Colors.grey[200]!,
            gap: 8,
            activeColor: Colors.redAccent,
            iconSize: 25,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            tabBackgroundColor: Colors.grey[200]!,
            tabs: const [
              GButton(icon: Icons.live_tv, text: "Live"),
              GButton(icon: Icons.sports_soccer, text: "Highlight"),
              GButton(icon: Icons.movie, text: "Movie"),
              GButton(icon: Icons.settings, text: "Settings")
            ],
            selectedIndex: _networkController.count.value,
            onTabChange: (index) {
              _networkController.changeNavigation(index);
            },
          ),
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, animated1, animated2) => Container(),
      transitionBuilder: (context, a1, a2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(a1),
          child: AlertDialog(
            title: const Center(child: Text('UI Update')),
            content: SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/playstore.png",
                        height: 40, width: 40),
                  ),
                  const SizedBox(height: 10),
                  Text("=> Version ${_networkController.uriversion.value}"),
                  const SizedBox(height: 10),
                  Text("=> ${_networkController.uriversionDetails.value}"),
                ],
              ),
            ),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide.none,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      MyWidget().gotoUrl(_networkController.link.value);
                    },
                    child: const Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      GetStorage().write('ui', true);
                      Navigator.pop(context);
                    },
                    child: const Text('Skip'),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppStatus() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/rocket.png", width: 200, height: 250),
            const SizedBox(height: 15),
            Text('${_networkController.uriversion.value}',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text(_networkController.title.value,
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 15),
            Text(_networkController.subtitle.value,
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                MyWidget().gotoUrl(_networkController.link.value);
              },
              child: const Text(
                "Update",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
