import 'package:flutter/material.dart';
import 'package:ai_english/core/http/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatHistoryPage extends ConsumerStatefulWidget {
  const ChatHistoryPage({super.key});

  @override
  ChatHistoryPageState createState() => ChatHistoryPageState();
}

class ChatHistoryPageState extends ConsumerState<ChatHistoryPage> {
  final ApiClient _apiClient = ApiClient();
  List<Map<String, dynamic>> _conversations = [];
  List<Map<String, dynamic>> _filteredConversations = [];
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _fetchConversations();
  }

  Future<void> _fetchConversations() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    try {
      final response = await _apiClient.get('/english/conversation_sets');
      final data = response.data['sets'] as List<dynamic>;

      setState(() {
        _conversations = data.map((item) {
          final createdAt = DateTime.parse(item['created_at']).toLocal();
          final formattedDate = DateFormat('yyyy/MM/dd').format(createdAt);
          return {
            'id': item['id'],
            'title': item['title'],
            'created_at': formattedDate,
          };
        }).toList();
        _filteredConversations = _conversations;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  void _filterConversations(String keyword) {
    setState(() {
      _filteredConversations = _conversations
          .where((conversation) => conversation['title']
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat History'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: _filterConversations,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _isError
                    ? const Center(child: Text('Failed to load conversations'))
                    : ListView.builder(
                        itemCount: _filteredConversations.length,
                        itemBuilder: (context, index) {
                          final conversation = _filteredConversations[index];
                          return ListTile(
                            title: Text(conversation['title']),
                            subtitle: Text(conversation['created_at']),
                            onTap: () {
                              debugPrint('Tap message');
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
