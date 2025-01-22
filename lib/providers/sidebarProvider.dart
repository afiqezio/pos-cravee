import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarState extends StateNotifier<Map<String, int>> {
  SidebarState()
      : super({
          'headerIndex': 0,
          'footerIndex': -1
        }); // Default to -1 (no selection)

  void selectHeaderIndex(int index) {
    state = {
      'headerIndex': index,
      'footerIndex': state['footerIndex']!
    }; // Update the selected header index
  }

  void selectFooterIndex(int index) {
    state = {
      'headerIndex': state['headerIndex']!,
      'footerIndex': index
    }; // Update the selected footer index
  }
}

// Create a provider for the SidebarState
final sidebarProvider =
    StateNotifierProvider<SidebarState, Map<String, int>>((ref) {
  return SidebarState();
});
