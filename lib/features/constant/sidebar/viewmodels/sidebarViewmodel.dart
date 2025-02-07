import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/app/route.dart';

class SidebarState extends StateNotifier<SidebarSelection> {
  SidebarState() : super(SidebarSelection());

  void selectHeaderIndex(int index) {
    state = SidebarSelection(
      selectedIndex: index,
      sublistExpanded: state.sublistExpanded,
      isCollapsed: state.isCollapsed,
    );
  }

  void selectFooterIndex(int index) {
    state = SidebarSelection(
      selectedIndex: index,
      sublistExpanded: state.sublistExpanded,
      isCollapsed: state.isCollapsed,
    );
  }

  void resetSelection() {
    state = SidebarSelection(
      sublistExpanded: state.sublistExpanded,
      isCollapsed: state.isCollapsed,
    );
    while (getGoRouter().canPop() == true) {
      getGoRouter().pop();
    }
    getGoRouter().pushReplacement('/dashboard');
  }

  void toggleSidebar() {
    final isCollapsing = !state.isCollapsed;
    int newSelectedIndex = state.selectedIndex;
    final lastSelectedSubItems = Map<int, int>.from(state.lastSelectedSubItems);
    final currentExpanded = Map<int, bool>.from(state.sublistExpanded);

    if (isCollapsing) {
      // When collapsing, if current selection is a subitem, select its parent
      for (int parentIndex = 1; parentIndex <= 10; parentIndex++) {
        if (state.selectedIndex >= parentIndex * 100 &&
            state.selectedIndex < (parentIndex + 1) * 100) {
          lastSelectedSubItems[parentIndex] = state.selectedIndex;
          newSelectedIndex = parentIndex;
          currentExpanded.clear();
          break;
        }
      }
    } else {
      // When expanding, restore the last selected subitem if there was one
      final parentIndex = newSelectedIndex;
      if (lastSelectedSubItems.containsKey(parentIndex)) {
        newSelectedIndex = lastSelectedSubItems[parentIndex]!;
        currentExpanded[parentIndex] = true;
      }
    }

    state = state.copyWith(
      isCollapsed: isCollapsing,
      selectedIndex: newSelectedIndex,
      lastSelectedSubItems: lastSelectedSubItems,
      sublistExpanded: currentExpanded,
    );
  }

  void toggleSublist(int index) {
    final currentExpanded = Map<int, bool>.from(state.sublistExpanded);
    final isExpanding = !(currentExpanded[index] ?? false);
    currentExpanded[index] = isExpanding;

    final lastSelectedSubItems = Map<int, int>.from(state.lastSelectedSubItems);
    int newSelectedIndex = state.selectedIndex;

    if (isExpanding) {
      // If expanding and there was a previously selected subitem, restore it
      if (lastSelectedSubItems.containsKey(index)) {
        newSelectedIndex = lastSelectedSubItems[index]!;
      }
    } else {
      // If collapsing and current selection is a subitem, store and select parent
      if (state.selectedIndex >= index * 100 &&
          state.selectedIndex < (index + 1) * 100) {
        lastSelectedSubItems[index] = state.selectedIndex;
        newSelectedIndex = index;
      }
    }

    state = state.copyWith(
      sublistExpanded: currentExpanded,
      selectedIndex: newSelectedIndex,
      lastSelectedSubItems: lastSelectedSubItems,
    );
  }
}

// Create a class to hold the sidebar selection state
class SidebarSelection {
  final int selectedIndex;
  final bool isCollapsed;
  final Map<int, bool> sublistExpanded;
  final Map<int, int> lastSelectedSubItems;

  SidebarSelection({
    this.selectedIndex = 1,
    this.isCollapsed = false,
    Map<int, bool>? sublistExpanded,
    Map<int, int>? lastSelectedSubItems,
  })  : sublistExpanded = sublistExpanded ?? {},
        lastSelectedSubItems = lastSelectedSubItems ?? {};

  SidebarSelection copyWith({
    int? selectedIndex,
    bool? isCollapsed,
    Map<int, bool>? sublistExpanded,
    Map<int, int>? lastSelectedSubItems,
  }) {
    return SidebarSelection(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isCollapsed: isCollapsed ?? this.isCollapsed,
      sublistExpanded: sublistExpanded ?? this.sublistExpanded,
      lastSelectedSubItems: lastSelectedSubItems ?? this.lastSelectedSubItems,
    );
  }
}

// Create a provider for the SidebarState
final sidebarProvider =
    StateNotifierProvider<SidebarState, SidebarSelection>((ref) {
  return SidebarState();
});
