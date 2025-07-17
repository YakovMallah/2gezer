import 'dart:async';
import '../domain/shared_list.dart';
import '../domain/list_item.dart';

class ListRepository {
  static final _lists = <String, List<SharedList>>{};
  static final _items = <String, List<ListItem>>{};

  Future<List<SharedList>> getLists(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_lists[groupId] ?? []);
  }

  Future<SharedList> createList(String groupId, String title) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final sl = SharedList(
      id: id,
      groupId: groupId,
      title: title,
      createdBy: 'me',
      createdAt: DateTime.now(),
    );
    _lists.putIfAbsent(groupId, () => []).add(sl);
    return sl;
  }

  Future<void> deleteList(String listId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _lists.forEach((g, l) => l.removeWhere((sl) => sl.id == listId));
    _items.remove(listId);
  }

  Future<List<ListItem>> getItems(String listId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_items[listId] ?? []);
  }

  Stream<List<ListItem>> itemsStream(String listId) async* {
    // simple hook: emit initial and after every op
    yield await getItems(listId);
  }

  Future<ListItem> addItem(String listId, String content) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final it = ListItem(
      id: id,
      listId: listId,
      content: content,
      isCompleted: false,
      updatedBy: 'me',
      updatedAt: DateTime.now(),
    );
    _items.putIfAbsent(listId, () => []).add(it);
    return it;
  }

  Future<void> toggleCompleted(String itemId, bool isCompleted) async {
    await Future.delayed(const Duration(milliseconds: 100));
    for (var list in _items.values) {
      for (var it in list) {
        if (it.id == itemId) {
          it.isCompleted = isCompleted;
          it.updatedAt = DateTime.now();
        }
      }
    }
  }

  Future<void> deleteItem(String itemId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _items.forEach((k, l) => l.removeWhere((it) => it.id == itemId));
  }
}