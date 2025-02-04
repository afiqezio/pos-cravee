import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarState extends StateNotifier<SidebarSelection> {
  SidebarState() : super(SidebarSelection()); // Initialize with default values

  void selectHeaderIndex(int index) {
    state =
        SidebarSelection(headerIndex: index, footerIndex: state.footerIndex);
  }

  void selectFooterIndex(int index) {
    state =
        SidebarSelection(headerIndex: state.headerIndex, footerIndex: index);
  }

  void resetSelection() {
    state = SidebarSelection();
  }
}

// Create a class to hold the sidebar selection state
class SidebarSelection {
  final int headerIndex;
  final int footerIndex;

  SidebarSelection({this.headerIndex = 1, this.footerIndex = -1});
}

// Create a provider for the SidebarState
final sidebarProvider =
    StateNotifierProvider<SidebarState, SidebarSelection>((ref) {
  return SidebarState();
});
