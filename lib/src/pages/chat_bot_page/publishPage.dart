import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jarvis/src/providers/authProvider.dart';
import 'package:jarvis/src/services/chatBotServices.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PublishPage extends StatefulWidget {
  final String botId;
  final String botName;

  const PublishPage({Key? key, required this.botId, required this.botName})
      : super(key: key);

  @override
  _PublishPageState createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  final List<PlatformInfo> platforms = [
    PlatformInfo(
        name: 'Slack', iconPath: 'assets/slack.png', isConfigured: false),
    PlatformInfo(
        name: 'Telegram', iconPath: 'assets/telegram.png', isConfigured: false),
    PlatformInfo(
        name: 'Messenger',
        iconPath: 'assets/messenger.png',
        isConfigured: false),
  ];

  late Map<String, String> _urls;

  final TextEditingController slackTokenController = TextEditingController();
  final TextEditingController slackClientIdController = TextEditingController();
  final TextEditingController slackClientSecretController =
      TextEditingController();
  final TextEditingController slackSigningSecretController =
      TextEditingController();

  final TextEditingController telegramTokenController = TextEditingController();

  final TextEditingController messengerTokenController =
      TextEditingController();
  final TextEditingController messengerBotPageIDController =
      TextEditingController();
  final TextEditingController messengerAppSecretController =
      TextEditingController();

  String? _selectedPlatform;
  String? _telegramRedirectUrl;
  String? _slackRedirectUrl;
  String? _messengerRedirectUrl;

  @override
  void initState() {
    super.initState();
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    fetchConfiguration(authProvider.knowledgeBaseToken!, widget.botId);
    _urls = {
      'slack_oauth2':
          'https://knowledge-api.jarvis.cx/kb-core/v1/bot-integration/slack/auth/${widget.botId}',
      'slack_eventRequest':
          'https://knowledge-api.jarvis.cx/kb-core/v1/hook/slack/${widget.botId}',
      'slack_slashRequest':
          'https://knowledge-api.jarvis.cx/kb-core/v1/hook/slack/slash/${widget.botId}',
      'messenger_callback':
          'https://knowledge-api.jarvis.cx/kb-core/v1/hook/messenger/${widget.botId}',
      'messenger_verify': 'knowledge',
    };
  }

  Future<void> fetchConfiguration(String kbToken, String assistantId) async {
    final data = await ChatBotServices().getConfigurations(
        kbToken: kbToken, assistantId: assistantId);

    int length = data.length;
    for (int i = 0; i < length; ++i) {
      if (data[i]['type'] == 'telegram') {
        setState(() {
          platforms[1].isConfigured = true;
          telegramTokenController.text = data[i]['metadata']['botToken'];
          _telegramRedirectUrl = data[i]['metadata']['redirect'];
        });
      }
      else if (data[i]['type'] == 'slack') {
        setState(() {
          platforms[0].isConfigured = true;
          slackTokenController.text = data[i]['metadata']['token'];
          slackClientIdController.text = data[i]['metadata']['clientId'];
          slackClientSecretController.text = data[i]['metadata']['clientSecret'];
          slackSigningSecretController.text = data[i]['metadata']['signingSecret'];
        });
      }
      else if (data[i]['type'] == 'messenger') {
        setState(() {
          platforms[2].isConfigured = true;
          messengerTokenController.text = data[i]['metadata']['token'];
          messengerBotPageIDController.text = data[i]['metadata']['pageId'];
          messengerAppSecretController.text = data[i]['metadata']['appSecret'];
        });
      }
    }
  }

  void _showConfigureDialog(PlatformInfo platform) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AuthProvider authProvider =
            Provider.of<AuthProvider>(context, listen: false);

        return AlertDialog(
          title: Text('Configure ${platform.name} Bot'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (platform.name == 'Slack') ...[
                  const Text(
                      'Connect to Slack Bots and chat with this bot in Slack App'),
                  const SizedBox(height: 20),
                  const Text('1. Slack copylink',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const Text(
                      'Copy the following contents to your Slack app configuration page.'),
                  const SizedBox(height: 10),
                  _buildCopyLinkSection(
                      'OAuth2 Redirect URLs', _urls['slack_oauth2']!),
                  const SizedBox(height: 10),
                  _buildCopyLinkSection(
                      'Event Request URL', _urls['slack_eventRequest']!),
                  const SizedBox(height: 10),
                  _buildCopyLinkSection(
                      'Slash Request URL', _urls['slack_slashRequest']!),
                  const SizedBox(height: 10),
                  const Text('2. Slack information',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 10),
                  _buildTextField('Token', slackTokenController),
                  const SizedBox(height: 10),
                  _buildTextField('Client ID', slackClientIdController),
                  const SizedBox(height: 10),
                  _buildTextField('Client Secret', slackClientSecretController),
                  const SizedBox(height: 10),
                  _buildTextField(
                      'Signing Secret', slackSigningSecretController),
                ] else if (platform.name == 'Telegram') ...[
                  const Text(
                      'Connect to Telegram Bots and chat with this bot in Telegram App.'),
                  const SizedBox(height: 20),
                  const Text('1. Telegram information',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 10),
                  _buildTextField('Token', telegramTokenController),
                ] else if (platform.name == 'Messenger') ...[
                  const Text(
                      'Connect to Messenger Bots and chat with this bot in Messenger App.'),
                  const SizedBox(height: 20),
                  const Text('1. Messenger copylink',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const Text(
                      'Copy the following contents to your Messenger app configuration page.'),
                  const SizedBox(height: 10),
                  _buildCopyLinkSection(
                      'Callback URL', _urls['messenger_callback']!),
                  const SizedBox(height: 10),
                  _buildCopyLinkSection(
                      'Verify Token', _urls['messenger_verify']!),
                  const Text('2. Messenger information',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 10),
                  _buildTextField(
                      'Messenger Bot Token', messengerTokenController),
                  const SizedBox(height: 10),
                  _buildTextField(
                      'Messenger Bot Page ID', messengerBotPageIDController),
                  const SizedBox(height: 10),
                  _buildTextField(
                      'Messenger Bot App Secret', messengerAppSecretController),
                ]
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (platform.name == 'Telegram') {
                  verifyTelegramBotConfigure(authProvider.knowledgeBaseToken!);
                }
                else if (platform.name == 'Slack') {
                  // Verify Slack Bot Configure
                  verifySlackBotConfigure(authProvider.knowledgeBaseToken!);
                }
                else if (platform.name == 'Messenger') {
                  // Verify Messenger Bot Configure
                  verifyMessengerBotConfigure(authProvider.knowledgeBaseToken!);
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCopyLinkSection(String title, String url) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: Text(url, style: const TextStyle(color: Colors.blue)),
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: url));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard')),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(color: Colors.black),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Future<void> verifyTelegramBotConfigure(String kbToken) async {
    String telegramBotToken = telegramTokenController.text;
    final data = await ChatBotServices().verifyTelegramBotConfigure(
        kbToken: kbToken, botToken: telegramBotToken);

    if (data['ok'] == true) {
      setState(() {
        platforms[1].isConfigured = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Telegram Bot Token')),
      );
    }
  }

  Future<void> verifySlackBotConfigure(String kbToken) async {
    String slackToken = slackTokenController.text;
    String clientId = slackClientIdController.text;
    String clientSecret = slackClientSecretController.text;
    String signingSecret = slackSigningSecretController.text;

    final data = await ChatBotServices().verifySlackBotConfigure(
        kbToken: kbToken,
        botToken: slackToken,
        clientId: clientId,
        clientSecret: clientSecret,
        signingSecret: signingSecret);

    if (data == true) {
      setState(() {
        platforms[0].isConfigured = true;
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Slack Bot Configuration')),
      );
    }

  }

  Future<void> verifyMessengerBotConfigure(String kbToken) async {
    String messengerToken = messengerTokenController.text;
    String pageId = messengerBotPageIDController.text;
    String appSecret = messengerAppSecretController.text;

    final data = await ChatBotServices().verifyMessengerBotConfiguration(
        kbToken: kbToken,
        botToken: messengerToken,
        pageId: pageId,
        appSecret: appSecret);

    if (data['ok'] == true) {
      setState(() {
        platforms[2].isConfigured = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Messenger Bot Configuration')),
      );
    }
  }

  Future<String> publishTelegramBotToken(
      String kbToken, String assistantId) async {
    String telegramBotToken = telegramTokenController.text;
    final data = await ChatBotServices().publishTelegramBot(
        kbToken: kbToken, botToken: telegramBotToken, assistantId: assistantId);

    return data['redirect'];
  }

  Future<String> publishSlackBotToken(String kbToken, String assistantId) async {
    String slackToken = slackTokenController.text;
    String clientId = slackClientIdController.text;
    String clientSecret = slackClientSecretController.text;
    String signingSecret = slackSigningSecretController.text;

    final data = await ChatBotServices().publishSlackBot(
        kbToken: kbToken,
        botToken: slackToken,
        clientId: clientId,
        clientSecret: clientSecret,
        signingSecret: signingSecret,
        assistantId: assistantId
    );

    return data['redirect'];
  }

  Future<String> publishMessengerBotToken(
      String kbToken, String assistantId) async {
    String messengerToken = messengerTokenController.text;
    String pageId = messengerBotPageIDController.text;
    String appSecret = messengerAppSecretController.text;

    final data = await ChatBotServices().publishMessengerBot(
        kbToken: kbToken,
        botToken: messengerToken,
        pageId: pageId,
        appSecret: appSecret,
        assistantId: assistantId);

    return data['redirect'];
  }

  Future<void> _publishBot() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    if (_selectedPlatform == 'Telegram') {
      String redirectUrl = _telegramRedirectUrl ?? '';
      if (platforms[1].isConfigured == false) {
        redirectUrl = await publishTelegramBotToken(
            authProvider.knowledgeBaseToken!, widget.botId); 
      }
      _showSuccessDialog(redirectUrl, 'Open');
    }
    else if (_selectedPlatform == 'Slack') {
      // Publish Slack Bot
      String redirectUrl = _slackRedirectUrl ?? '';
      if (platforms[0].isConfigured == false) {
        redirectUrl = await publishSlackBotToken(authProvider.knowledgeBaseToken!, widget.botId);
      } 
      _showSuccessDialog(redirectUrl, 'Authorize');
    }
    else if (_selectedPlatform == 'Messenger') {
      // Publish Messenger Bot
      String redirectUrl = _messengerRedirectUrl ?? '';
      if (platforms[2].isConfigured == false) {
        redirectUrl = await publishMessengerBotToken(authProvider.knowledgeBaseToken!, widget.botId); 
      }
      _showSuccessDialog(redirectUrl, 'Authorize');
    }
  }

  void _showSuccessDialog(String redirectUrl, String buttonName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Publishing Successful'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Your bot has been successfully published to Telegram.'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (await canLaunchUrl(Uri.parse(redirectUrl))) {
                    await launchUrl(Uri.parse(redirectUrl));
                  } else {
                    throw 'Could not launch $redirectUrl';
                  }
                },
                child: Text(buttonName),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Publish ${widget.botName}'),
        ),
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: platforms.length,
                itemBuilder: (context, index) {
                  final platform = platforms[index];
                  return ListTile(
                    leading: Checkbox(
                      value: _selectedPlatform == platform.name,
                      onChanged: platform.isConfigured
                          ? (bool? value) {
                              setState(() {
                                if (value == true) {
                                  _selectedPlatform = platform.name;
                                } else {
                                  _selectedPlatform = null;
                                }
                                // platform.isConfigured = value ?? false;
                              });
                            }
                          : null,
                    ),
                    title: Row(
                      children: [
                        Image.asset(platform.iconPath,
                            width: 24.0, height: 24.0),
                        const SizedBox(width: 8.0),
                        Text(platform.name),
                      ],
                    ),
                    subtitle: Text(
                        platform.isConfigured ? 'Verified' : 'Not Configured'),
                    trailing: ElevatedButton(
                      onPressed: () => _showConfigureDialog(platform),
                      child: const Text('Configure'),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _publishBot,
                child: const Text('Publish'),
              ),
            ),
          ],
        ));
  }
}

class PlatformInfo {
  final String name;
  final String iconPath;
  bool isConfigured;

  PlatformInfo(
      {required this.name, required this.iconPath, this.isConfigured = false});
}
